"""
transactions blueprint
"""

from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

transactions = Blueprint('transactions', __name__)

# Get all the transactions from the database
@transactions.route('/transactions', methods=['GET'])
def get_transactions():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Transaction_id, Amount, Date, Description from Transactions')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Add a new transaction to the database
@transactions.route('/transactions/<Account_id>', methods=['POST'])
def create_transaction(Account_id):
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    # Assuming transaction_id and date are not passed in the JSON, as they are auto-incremented
    Amount = the_data['Amount']
    desc = the_data['Description']

    # Constructing the query
    query = 'INSERT INTO Transactions (Amount, Category_id, Description, Account_id) VALUES ('
    query += '"' + str(Amount) + '", 1, '
    query += '"' + desc + '", '
    query += '"' + str(Account_id) + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'
    
# update the mutable transaction information
@transactions.route('/transactions/transaction_id', methods=['PUT'])
def update_transaction():
    transaction_info = request.json
    id = transaction_info['Transaction_id']
    amount = transaction_info['Amount']
    date = transaction_info['Date']
    desc = transaction_info['Description']

    query = 'UPDATE Transactions SET amount = %s, date = %s, desc = %s where id = %s'
    data = (amount, date, desc)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Transaction updated successfully'}), 200

# Delete the transaction info given its ID number
@transactions.route('/transactions/<transaction_id>', methods=['DELETE'])
def delete_transaction(Transaction_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Transactions WHERE Transaction_id = %s'.format(Transaction_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'Transaction deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# # Get detailed info of all transactions based on its accountID
@transactions.route('/transactions/<Account_id>', methods=['GET'])
def get_transaction_accountid(Account_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Transactions where Account_id = {0}'.format(Account_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
