"""
Users blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

users = Blueprint('Users', __name__)

# Get all the users from the database
@users.route('/users', methods=['GET'])
def get_users():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate from Users')
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
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO users (User_id, FirstName, LastName, Email, Phone, BirthDate) VALUES (%s, %s, %s, %s, %s, %s)',
            (data.get('User_id'), data.get('FirstName'), data.get('LastName'), data.get('Email'), data.get('Phone'), data.get('BirthDate'))
        )
        db.get_db().commit()
        response = {"message": "User created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the users information
@users.route('/users', methods=['PUT'])
def update_user():
    user_info = request.json
    id = user_info['User_id']
    first = user_info['FirstName']
    last = user_info['LastName']
    email = user_info['Email']
    phone = user_info['Phone']
    birth = user_info['BirthDate']

    query = 'UPDATE Users SET FirstName = %s, LastName = %s, Email = %s, Phone = %s, BirthDate = %s where User_id = %s'
    data = (first, last, email, phone, birth, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'User updated successfully'}), 200

# Delete the users info given their ID number
@users.route('/users/<userID>', methods=['DELETE'])
def delete_user(user_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM users WHERE User_id = %s'.format(user_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'User deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all users with a particular userID
@users.route('/users/<user_id>', methods=['GET'])
def get_user(user_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Users where User_id = {0}'.format(user_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response