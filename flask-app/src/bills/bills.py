"""
Bills blueprint
"""

from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

bills = Blueprint('Bills', __name__)

# Get all the bills from the database
@bills.route('/bills', methods=['GET'])
def get_bills():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Bill_id, DueBy, Description, Account_id, Budget_id from Bills')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Add a new bill to the database based on Account_id
@bills.route('/bills/<Account_id>', methods=['POST'])
def add_new_bill(Account_id):
    
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    # Assuming bill_id and budget_id are not passed in the JSON, as they are auto-incremented
    desc = the_data['Description']
    dueby = the_data['DueBy']

    # Constructing the query
    query = 'INSERT INTO Bills (Account_id, Description, DueBy) VALUES ('
    query += '"' + str(Account_id) + '", '
    query += '"' + desc + '", '
    query += '"' + dueby + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'
    

# update the mutable bill information
@bills.route('/bills/bill_id', methods=['PUT'])
def update_bill():
    bill_info = request.json
    id = bill_info['bill_id']
    due_by = bill_info['DueBy']
    desc = bill_info['Description']

    query = 'UPDATE Bills SET DueBy = %s, Description = %s, where Bill_id = %s'
    data = (due_by, desc, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Bill updated successfully'}), 200

# Delete the bill info given its ID number
@bills.route('/bills/<Bill_id>', methods=['DELETE'])
def delete_bill(Bill_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Bills WHERE Bill_id = {0}'.format(Bill_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'Bill deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)
    
# # Get detailed info of a bill based on its Bill_id
# @bills.route('/bills/<Bill_id>', methods=['GET'])
# def get_Bill_Bill_id(Bill_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Bills where Bill_id = {0}'.format(Bill_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

#Get detailed info of all bills based on its Account_id
@bills.route('/bills/<Account_id>', methods=['GET'])
def get_bill_accountid(Account_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Bills where Account_id = {0}'.format(Account_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# # Get detailed info of all bills based on its Budget_id
# @bills.route('/bills/<budget_id>', methods=['GET'])
# def get_bill_budgetid(Budget_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Bills where Budget_id = {0}'.format(Budget_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response