"""
goals blueprint
"""

from flask import Blueprint, request, jsonify, make_response
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
@goals.route('/goals', methods=['POST'])
def create_goal():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO Goals (Goal_id, Name, Date, TotalFund, SavedSoFar) VALUES (%s, %s, %s, %s, %s)',
            (data.get('Goal_id'), data.get('Name'), data.get('Date'), data.get('TotalFund'), data.get('SavedSoFar'))
        )
        db.get_db().commit()
        response = {"message": "Goal created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
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
    
# Get detailed info of goal with a particular goalID
@goals.route('/goal/<goal_id>', methods=['GET'])
def get_goal(Goal_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Goals where Goal_id = {0}'.format(Goal_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response