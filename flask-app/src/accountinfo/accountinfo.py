"""
AccountInfo blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

accountinfo = Blueprint('AccountInfo', __name__)

# Get detailed info of all accounts belonging to a given UserID
@accountinfo.route('/accountinfo/<user_id>', methods=['GET'])
def get_accountid(user_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Accounts a INNER JOIN AccountInfo ai ON a.Account_id = ai.Account_id WHERE ai.User_id = {0}'.format(user_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response