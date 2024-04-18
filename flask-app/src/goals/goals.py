"""
goals blueprint
"""

from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

goals = Blueprint('goals', __name__)

# Get all the goals from the database
@goals.route('/goals', methods=['GET'])
def get_goals():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Goal_id, Name, Date, TotalFund, SavedSoFar from Goals')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# add a new goal to the database
@goals.route('/goals/<Account_id>', methods=['POST'])
def create_goal(Account_id):
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    name = the_data['Name']
    date = the_data['Date']
    totalFund = the_data['TotalFund']

    # Constructing the query
    query = 'INSERT INTO Goals (Account_id, Name, Date, TotalFund, SavedSoFar) VALUES ('
    query += '"' + str(Account_id) + '", '
    query += '"' + name + '", '
    query += '"' + str(date) + '", '
    query += '"' + str(totalFund) + '", 0.00)'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'
    
# update the goals information
@goals.route('/goals', methods=['PUT'])
def update_goal():
    goal_info = request.json
    id = goal_info['Goal_id']
    name = goal_info['Name']
    date = goal_info['Date']
    total_fund = goal_info['TotalFund']
    saved_so_far = goal_info['SavedSoFar']

    query = 'UPDATE Goals SET Name = %s, Date = %s, TotalFund = %s, SavedSoFar = %s WHERE Goal_id = %s'
    data = (name, date, total_fund, saved_so_far, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Goal updated successfully'}), 200

# Delete the goal info given their ID number
@goals.route('/goals/<goal_id>', methods=['DELETE'])
def delete_goal(Goal_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Goals WHERE Goal_id = %s', (Goal_id,))
        db.get_db().commit()
        return make_response(jsonify({'message': 'Goal deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)


# Get detailed info of all accounts belonging to a given accountID
@goals.route('/goals/<Account_id>', methods=['GET'])
def get_goals_accountid(Account_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Goals WHERE Account_id = {0}'.format(Account_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@goals.route('/goals-tr/<Account_id>', methods=['GET'])
def get_goals_accountid_transac(Account_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Goals g JOIN Transactions tr ON g.Goal_id = tr.Goal_id WHERE tr.Account_id = {0}'.format(Account_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response