"""
Tags blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

tags = Blueprint('tags', __name__)

# Get all the Tags from the database
@tags.route('/tags', methods=['GET'])
def get_Tags():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Tag_id, TagName FROM Tags')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# add a new Tag to the database
@tags.route('/tags', methods=['POST'])
def create_Tag():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO Tags (Tag_id, TagName) VALUES (%s, %s)',
            (data.get('Tag_id'), data.get('TagName'))
        )
        db.get_db().commit()
        response = {"message": "Tag created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the Tags information
@tags.route('/tags', methods=['PUT'])
def update_Tag():
    Tag_info = request.json
    id = Tag_info['Tag_id']
    TagName = Tag_info['TagName']

    query = 'UPDATE Tags SET TagName = %s'
    data = (TagName, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Tag updated successfully'}), 200

# Delete the Tags info given their ID number
@tags.route('/tags/<tag_id>', methods=['DELETE'])
def delete_Tag(Tag_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Tags WHERE Tag_id = %s', (Tag_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'Tag deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all Tags with a particular Tag_ id
@tags.route('/tags/<tag_id>', methods=['GET'])
def get_Tag(Tag_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Tags where Tag_id = %s'.format(Tag_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


