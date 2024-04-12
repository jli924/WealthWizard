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
    cursor.execute('SELECT transaction_id, amount, date, description from transactions')
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
            'INSERT INTO transactions (transaction_id, amount, date, description) VALUES (%s, %s, %s, %s)',
            (data.get('transaction_id'), data.get('amount'), data.get('date'), data.get('description'))
        )
        db.get_db().commit()
        response = {"message": "transaction created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the mutable transaction information
@transactions.route('/transactions/transactionID', methods=['PUT'])
def update_transaction():
    transaction_info = request.json
    id = transaction_info['transaction_id']
    max_a = transaction_info['maxamount']
    min_r = transaction_info['minremaining']
    remain = transaction_info['remaining']
    spent = transaction_info['spent']

    query = 'UPDATE transactions SET max_a = %s, min_r = %s, remain = %s, spent = %s where id = %s'
    data = (max_a, min_r, remain, spent)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'transaction updated successfully'}), 200

# Delete the transaction info given its ID number
@transactions.route('/transactions/<transactionID>', methods=['DELETE'])
def delete_transaction(transaction_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM transactions WHERE transaction_id = %s'.format(transaction_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'transaction deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all transactions based on its transactionID
@transactions.route('/transactions/<transactionID>', methods=['GET'])
def get_transaction_transactionid(transaction_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from transactions where transaction_id = %s'.format(transaction_id))
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
@transactions.route('/transactions/<categoryID>', methods=['GET'])
def get_transaction_categoryid(categoryid):
    cursor = db.get_db().cursor()
    cursor.execute('select * from transactions where categoryid = %s'.format(categoryid))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get detailed info of all transactions based on its accountID
@transactions.route('/transactions/<accountID>', methods=['GET'])
def get_transaction_accountid(accountid):
    cursor = db.get_db().cursor()
    cursor.execute('select * from transactions where accountid = %s'.format(accountid))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response