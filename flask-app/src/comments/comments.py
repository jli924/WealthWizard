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
    cursor.execute('SELECT comment_id, content from comments')
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
            'INSERT INTO comments (comment_id, content) VALUES (%s, %s)',
            (data.get('comment_id'), data.get('content'))
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
    id = comment_info['comment_id']
    content = comment_info['content']

    query = 'UPDATE comments SET content = %s where id = %s'
    data = (content, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'comment updated successfully'}), 200

# Delete the comment info given its ID number
@comments.route('/comments/<commentID>', methods=['DELETE'])
def delete_comment(comment_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM comments WHERE comment_id = %s'.format(comment_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'comment deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all comments based on its comment ID
@comments.route('/comments/<commentId>', methods=['GET'])
def get_comment_comment_id(comment_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM comments where comment_id = %s'.format(comment_id))
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
@comments.route('/comments/<accountID>', methods=['GET'])
def get_comment_accountid(account_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from comments where account_id = %s'.format(account_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response