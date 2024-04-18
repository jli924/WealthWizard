"""
budgets blueprint
"""

from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

budgets = Blueprint('Budgets', __name__)

# Get all the budgets from the database
@budgets.route('/budgets', methods=['GET'])
def get_budgets():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Budget_id, MaxAmount, MinRemaining, Remaining, Spent, AccountID, CategoryID from Budgets')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Add a new budget to the database
@budgets.route('/budgets/<AccountID>', methods=['POST']) 
def add_new_budget(AccountID):
    
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    # Assuming bill_id and budget_id are not passed in the JSON, as they are auto-incremented
    max_a = the_data['MaxAmount']
    madefor = the_data['MadeFor']


    # Constructing the query
    query = 'INSERT INTO Budgets (AccountID, MaxAmount, MadeFor, CategoryID, MinRemaining, Remaining, Spent) VALUES ('
    query += '"' + str(AccountID) + '", '
    query += '"' + str(max_a) + '", '
    query += '"' + madefor + '", 1, 1.00, '
    query += '"' + str(max_a) + '", 0.00)'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'
    
# update the mutable budget information
@budgets.route('/budgets/<Budget_id>', methods=['PUT'])
def update_budget(Budget_id):
    budget_info = request.json
    id = budget_info['Budget_id']
    max_a = budget_info['MaxAmount']
    min_r = budget_info['MinRemaining']
    remain = budget_info['Remaining']
    spent = budget_info['Spent']

    query = 'UPDATE Budgets SET MaxAmount = %s, MinRemaining = %s, Remaining = %s, Spent = %s where Budget_id = %s'
    data = (max_a, min_r, remain, spent, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Budget updated successfully'}), 200

# Delete the budget info given its ID number
@budgets.route('/budgets/<budget_id>', methods=['DELETE'])
def delete_budget(budget_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Budgets WHERE Budget_id = %s'.format(budget_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'Budget deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all budgets based on its budgetID
@budgets.route('/budgets-by-budget/<Budget_id>', methods=['GET'])
def get_budget_budgetid(Budget_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Budgets where Budget_id = {0}'.format(Budget_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get detailed info of all budgets based on its categoryID
# @budgets.route('/budgets/<categoryID>', methods=['GET'])
# def get_budget_categoryid(categoryid):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Budgets where CategoryID = {0}'.format(categoryid))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

# # Get detailed info of all budgets based on its accountID
@budgets.route('/budgets/<AccountID>', methods=['GET'])
def get_budget_accountid(AccountID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Budgets where AccountID = {0}'.format(AccountID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response