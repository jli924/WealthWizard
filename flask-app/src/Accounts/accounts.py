"""
Accounts blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

Accounts = Blueprint('Accounts', __name__)

# Get all the accounts from the database
@Accounts.route('/Accounts', methods=['GET'])
def get_accounts():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Account_id, Balance, AccountType, DateCreated FROM Accounts')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# add a new account to the database
@Accounts.route('/Accounts', methods=['POST'])
def create_account():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO Accounts (Account_id, Balance, AccountType, DateCreated) VALUES (%s, %s, %s, %s)',
            (data['Account_id'], data.get('Balance'), data['AccountType'], data.get('DateCreated'))
        )
        db.get_db().commit()
        response = {"message": "Account created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the account's information
@Accounts.route('/Accounts', methods=['PUT'])
def update_account():
    account_info = request.json
    id = account_info['Account_id']
    balance = account_info['Balance']
    AccountType = account_info['AccountType']
    DateCreated = account_info['DateCreated']

    query = 'UPDATE Accounts SET balance = %s, AccountType = %s, DateCreated = %s WHERE Account_id = %s'
    data = (balance, AccountType, DateCreated, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Account updated successfully'}), 200

# Delete the account's info given their ID number
@Accounts.route('/Accounts/<Account_id>', methods=['DELETE'])
def delete_account(AccountID):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Accounts WHERE Account_id = %s', (AccountID))
        db.get_db().commit()
        return make_response(jsonify({'message': 'User deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all accoiunts with a particular Account_id
@Accounts.route('/Accounts/<Account_id>', methods=['GET'])
def get_account(Account_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Accounts where Account_id = %s'.format(Account_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


