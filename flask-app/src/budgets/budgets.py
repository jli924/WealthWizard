"""
budgets blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

budgets = Blueprint('budgets', __name__)

# Get all the budgets from the database
@budgets.route('/budgets', methods=['GET'])
def get_budgets():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT budgetid, maxamount, minremaining, remaining, spent from budgets')
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
            'INSERT INTO budgets (budgetid, maxamount, minremaining, remaining, spent) VALUES (%s, %s, %s, %s, %s)',
            (data['budgetid'], data.get('maxamount'), data['minremaining'], data.get('remaining'), data.get('spent'))
        )
        db.get_db().commit()
        response = {"message": "Budget created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)\
    
# update the mutable budget information
@users.route('/budgets/budgetID', methods=['PUT'])
def update_budget():
    budget_info = request.json
    id = budget_info['budget_id']
    max_a = budget_info['maxamount']
    min_r = budget_info['minremaining']
    remain = budget_info['remaining']
    spent = budget_info['spent']

    query = 'UPDATE budgets SET max_a = %s, min_r = %s, remain = %s, spent = %s where id = %s'
    data = (max_a, min_r, remain, spent)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Budget updated successfully'}), 200

# Delete the budget info given its ID number
@budgets.route('/budgets/<budgetID>', methods=['DELETE'])
def delete_budget(budgetID):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM budgets WHERE budgetid = %s', (user_id,))
        db.get_db().commit()
        return make_response(jsonify({'message': 'Budget deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all budgets based on its budgetID
@budgets.route('/budgets/<budgetID>', methods=['GET'])
def get_budget_budgetid(budgetID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from budgets where budgetID = %s'.format(budgetID))
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
@budgets.route('/budgets/<categoryID>', methods=['GET'])
def get_budget_categoryid(categoryid):
    cursor = db.get_db().cursor()
    cursor.execute('select * from budgets where categoryid = %s'.format(categoryid))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get detailed info of all budgets based on its accountID
@budgets.route('/budgets/<accountID>', methods=['GET'])
def get_budget_accountid(accountid):
    cursor = db.get_db().cursor()
    cursor.execute('select * from budgets where accountid = %s'.format(accountid))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response