"""
AccountInfo blueprint
"""

from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

accountinfo = Blueprint('AccountInfo', __name__)

# Get detailed info of all accounts belonging to a given UserID
@accountinfo.route('/accountinfo/<User_id>', methods=['GET'])
def get_accountid(User_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Accounts a INNER JOIN AccountInfo ai ON a.Account_id = ai.Account_id WHERE ai.User_id = {0}'.format(User_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@accountinfo.route('/accountinfo/<User_id>', methods=['POST'])
def add_new_accountinfo(User_id):
    
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    # Assuming bill_id and budget_id are not passed in the JSON, as they are auto-incremented
    accID = the_data['Account_id']

    # Constructing the query
    query = 'INSERT INTO AccountInfo (User_id, Account_id) VALUES ('
    query += '"' + str(User_id) + '", '
    query += '"' + str(accID) + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'