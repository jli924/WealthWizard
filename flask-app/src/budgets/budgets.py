"""
budgets blueprint
"""

from flask import Blueprint, request, jsonify, make_response
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
@budgets.route('/budgets', methods=['POST'])
def create_budget():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO Budgets (Budget_id, MaxAmount, MinRemaining, Remaining, Spent) VALUES (%s, %s, %s, %s, %s)',
            (data.get('Budget_id'), data.get('MaxAmount'), data.get('MinRemaining'), data.get('Remaining'), data.get('Spent'))
        )
        db.get_db().commit()
        response = {"message": "Budget created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the mutable budget information
@budgets.route('/budgets/budget_id', methods=['PUT'])
def update_budget():
    budget_info = request.json
    id = budget_info['Budget_id']
    max_a = budget_info['MaxAmount']
    min_r = budget_info['MinRemaining']
    remain = budget_info['Remaining']
    spent = budget_info['Spent']

    query = 'UPDATE Budgets SET MaxAmount = %s, MinRemaining = %s, Remaining = %s, Spent = %s where Budget_id = %s'
    data = (max_a, min_r, remain, spent)
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
# @budgets.route('/budgets/<budget_id>', methods=['GET'])
# def get_budget_budgetid(budget_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Budgets where Budget_id = {0}'.format(budget_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

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
    cursor.execute('select * from budgets where AccountID = {0}'.format(AccountID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response