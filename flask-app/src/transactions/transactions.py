"""
transactions blueprint
"""

from flask import Blueprint, request, jsonify, make_response
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
@transactions.route('/transactions', methods=['POST'])
def create_transaction():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO Transactions (Transaction_id, Amount, Date, Description) VALUES (%s, %s, %s, %s)',
            (data.get('Transaction_id'), data.get('amount'), data.get('date'), data.get('Description'))
        )
        db.get_db().commit()
        response = {"message": "Transaction created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
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

# Get detailed info of all transactions based on its Transaction ID
@transactions.route('/transactions/<transaction_id>', methods=['GET'])
def get_Transaction_Transaction_id(Transaction_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Transactions where Transaction_id = {0}'.format(Transaction_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get detailed info of all transactions based on its categoryID
# @transactions.route('/transactions/<categoryID>', methods=['GET'])
# def get_transaction_categoryid(Category_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Transactions where Category_id = {0}'.format(Category_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

# # Get detailed info of all transactions based on its accountID
# @transactions.route('/transactions/<accountID>', methods=['GET'])
# def get_transaction_accountid(Account_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Transactions where Accountid = {0}'.format(Account_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

# # Get detailed info of all transactions based on its goalID
# @transactions.route('/transactions/<goalID>', methods=['GET'])
# def get_transaction_goalid(goal_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Transactions where Account_id = {0}'.format(goal_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response