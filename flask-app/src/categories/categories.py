"""
Categories blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

categories = Blueprint('categories', __name__)

# Get all the Categories from the database
@categories.route('/categories', methods=['GET'])
def get_Categories():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Category_id, Name FROM Categories')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# add a new Category to the database
@categories.route('/categories', methods=['POST'])
def create_Category():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO Categories (Category_id, Name) VALUES (%s, %s)',
            (data.get('Category_id'), data.get('Name'))
        )
        db.get_db().commit()
        response = {"message": "Category created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the Categories information
@categories.route('/categories', methods=['PUT'])
def update_Category():
    Category_info = request.json
    id = Category_info['Category_id']
    Name = Category_info['Name']

    query = 'UPDATE Categories SET name = %s'
    data = (Name, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'Category updated successfully'}), 200

# Delete the Categories info given their ID number
@categories.route('/categories/<Category_id>', methods=['DELETE'])
def delete_Category(Category_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Categories WHERE Category_id = %s', (Category_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'Category deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all Categories with a particular Category_ id
@categories.route('/categorys/<category_id>', methods=['GET'])
def get_Category(Category_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Categories where Category_id = %s'.format(Category_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


