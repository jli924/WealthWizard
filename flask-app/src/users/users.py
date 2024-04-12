"""
Users blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

users = Blueprint('users', __name__)

# Get all the users from the database
@users.route('/users', methods=['GET'])
def get_users():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT userid, firstname, lastname, email, phone, birthdate from users')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# add a new user to the database
@users.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()  # Assumes the request body contains JSON with the new user's data

    # Validate data or handle it according to your application's requirements
    if not data or not 'email' in data or not 'firstname' in data:
        # Assuming email and firstname are mandatory
        response = {"error": "Missing data"}
        return make_response(jsonify(response), 400)
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO users (firstname, lastname, email, phone, birthdate) VALUES (%s, %s, %s, %s, %s)',
            (data['firstname'], data.get('lastname'), data['email'], data.get('phone'), data.get('birthdate'))
        )
        db.get_db().commit()
        response = {"message": "User created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)

# Get detailed info of all users with a particular userID
@users.route('/users/<userID>', methods=['GET'])
def get_user(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from users where userID = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# update the users information given their ID number
@users.route('/users', methods=['PUT'])
def update_user():
    user_info = request.json
    id = user_info['userid']
    first = user_info['firstname']
    last = user_info['lastname']
    email = user_info['email']
    phone = user_info['phone']
    birth = user_info['birthdate']

    query = 'UPDATE users SET firstname = %s, lastname = %s, email = %s, phone = %s, birthdate = %s where id = %s'
    data = (first, last, email, phone, birth)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'User updated successfully'}), 200

# Delete the users info given their ID number
@users.route('/users/<userID>', methods=['DELETE'])
def delete_user(user_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM users WHERE userid = %s', (user_id,))
        db.get_db().commit()
        return make_response(jsonify({'message': 'User deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

