"""
Accounts blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

accounts = Blueprint('accounts', __name__)

# Get all the accounts from the database
@accounts.route('/accounts', methods=['GET'])
def get_accounts():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Account_id, Balance, AccountType, Date_created FROM Accounts')
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
@accounts.route('/accounts', methods=['POST'])
def create_account():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO Accounts (Account_id, Balance, AccountType, Date_created) VALUES (%s, %s, %s, %s)',
            (data['Account_id'], data.get('Balance'), data['AccountType'], data.get('Date_created'))
        )
        db.get_db().commit()
        response = {"message": "Account created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the account's information
@accounts.route('/accounts', methods=['PUT'])
def update_account():
    account_info = request.json
    id = account_info['Account_id']
    balance = account_info['Balance']
    AccountType = account_info['AccountType']
    DateCreated = account_info['Date_created']

    query = 'UPDATE Accounts SET balance = %s, AccountType = %s, Date_created = %s WHERE Account_id = %s'
    data = (balance, AccountType, DateCreated, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Account updated successfully'}), 200

# Delete the account's info given their ID number
@accounts.route('/accounts/<account_id>', methods=['DELETE'])
def delete_account(AccountID):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Accounts WHERE Account_id = {0}', (AccountID))
        db.get_db().commit()
        return make_response(jsonify({'message': 'User deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all accoiunts with a particular Account_id
# @accounts.route('/accounts/<Account_id>', methods=['GET'])
# def get_account_accountid(Account_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Account where Account_id = {0}'.format(Account_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

# Get detailed info of all accoiunts with a particular User_id
@accounts.route('/accounts/<user_id>', methods=['GET'])
def get_account_userid(user_id):
   cursor = db.get_db().cursor()
   cursor.execute('select * from AccountInfo where User_id = %s'.format(user_id))
   row_headers = [x[0] for x in cursor.description]
   json_data = []
   theData = cursor.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   the_response = make_response(jsonify(json_data))
   the_response.status_code = 200
   the_response.mimetype = 'application/json'
   return the_response


