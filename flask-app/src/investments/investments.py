"""
investments blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

investments = Blueprint('investments', __name__)

# Get all the investments from the database
@investments.route('/investments', methods=['GET'])
def get_investments():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Investment_id, Account_id, Type, Amount, Description, Date from Investments')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Add a new investment to the database
@investments.route('/investments', methods=['POST'])
def create_investments():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO Investments (Investment_id, Account_id, Type, Amount, Description, Date) VALUES (%s, %s, %s, %s, %s, %s)',
            (data.get('Investment_id'), data.get('Account_id'), data('Type'), data.get('Amount'), data.get('Description'), data.get('Date'))
        )
        db.get_db().commit()
        response = {"message": "Investment created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the mutable investment information
@investments.route('/investments/investment_id', methods=['PUT'])
def update_investments():
    inv_info = request.json
    id = inv_info['Investment_id']
    type = inv_info['Type']
    amount = inv_info['Amount']
    desc = inv_info['Description']
    date = inv_info['Date']

    query = 'UPDATE Investments SET Type = %s, Amount = %s, Description = %s, Date = %s where Investment_id = %s'
    data = (type, amount, desc, date, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Investment updated successfully'}), 200

# Delete the investment info given its ID number
@investments.route('/investments/<investment_id>', methods=['DELETE'])
def delete_investments(Investment_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Investments WHERE Investment_id = %s'.format(Investment_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'Investment deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)
    
# Get detailed info of a investment based on its Investment_id
# @investments.route('/investments/<Investment_id>', methods=['GET'])
# def get_investments_investmentid(Investment_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Investments where Investment_id = {0}'.format(Investment_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

# Get detailed info of all investment based on its Account_id
@investments.route('/investments/<Account_id>', methods=['GET'])
def get_investment_accountid(Account_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Investments where Account_id = {0}'.format(Account_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response