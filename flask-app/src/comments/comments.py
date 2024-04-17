"""
customers blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

comments = Blueprint('comments', __name__)

# Get all the comments from the database
@comments.route('/comments', methods=['GET'])
def get_comments():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Comment_id, CONTENT from Comments')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Add a new comment to the database
@comments.route('/comments', methods=['POST'])
def create_comment():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO comments (Comment_id, CONTENT) VALUES (%s, %s)',
            (data.get('Comment_id'), data.get('CONTENT'))
        )
        db.get_db().commit()
        response = {"message": "comment created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the mutable comment information
@comments.route('/comments/commentID', methods=['PUT'])
def update_comment():
    comment_info = request.json
    id = comment_info['Comment_id']
    content = comment_info['CONTENT']

    query = 'UPDATE Comments SET content = %s where id = %s'
    data = (content, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'comment updated successfully'}), 200

# Delete the comment info given its ID number
@comments.route('/comments/<commentID>', methods=['DELETE'])
def delete_comment(Comment_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM comments WHERE Comment_id = %s'.format(Comment_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'comment deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all comments based on its comment ID
@comments.route('/comments/<Comment_id>', methods=['GET'])
def get_comment_comment_id(Comment_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM comments where Comment_id = {0}'.format(Comment_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get detailed info of all comments based on its accountID
# @comments.route('/comments/<accountID>', methods=['GET'])
# def get_comment_accountid(Account_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from comments where account_id = {0}'.format(Account_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response