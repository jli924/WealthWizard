"""
Accounts blueprint
"""

from flask import Blueprint, request, jsonify, make_response, current_app
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

# get max account ID
# @accounts.route('/accounts-max', methods=['GET'])
# def get_max_accountid():
#     cursor = db.get_db().cursor()
#     cursor.execute('SELECT MAX(Account_id) AS Account_id FROM Accounts')
#     max_row = cursor.fetchone()
#     max_id = max_row[0]

#     # +1
#     next_id = max_id + 1
#     the_response = make_response(jsonify(next_id))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

@accounts.route('/accounts-max', methods=['GET'])
def get_accounts():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT MAX(Account_id) AS Account_id FROM Accounts')
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
@accounts.route('/accounts/<User_id>', methods=['POST'])
def add_new_account(User_id):
    
    the_data = request.json
    current_app.logger.info(the_data)
    
    # Extracting the variables
    # Assuming bill_id and budget_id are not passed in the JSON, as they are auto-incremented
    bal = the_data['Balance']
    type = the_data['AccountType']

    # Constructing the query
    query = 'INSERT INTO Accounts (Balance, AccountType) VALUES ('
    query += '"' + str(bal) + '", '
    query += '"' + str(type) + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

    
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
@accounts.route('/accounts-by-acc/<Account_id>', methods=['GET'])
def get_account_accountid(Account_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Accounts where Account_id = {0}'.format(Account_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get detailed info of all accoiunts with a particular User_id
@accounts.route('/accounts/<User_id>', methods=['GET'])
def get_account_userid(User_id):
   cursor = db.get_db().cursor()
   cursor.execute('SELECT * FROM AccountInfo ai JOIN Users u ON ai.User_id = u.User_id JOIN Accounts a on ai.Account_id = a.Account_id WHERE u.User_id = {0}'.format(User_id))
   row_headers = [x[0] for x in cursor.description]
   json_data = []
   theData = cursor.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   the_response = make_response(jsonify(json_data))
   the_response.status_code = 200
   the_response.mimetype = 'application/json'
   return the_response



