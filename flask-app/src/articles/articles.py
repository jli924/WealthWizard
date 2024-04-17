"""
Articles blueprint
"""

from flask import Blueprint, request, jsonify, make_response
import json
from src import db

articles = Blueprint('articles', __name__)

# Get all the articles from the database
@articles.route('/articles', methods=['GET'])
def get_articles():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Article_id, Title, Content, UploadDate from Articles')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# add a new article to the database
@articles.route('/articles', methods=['POST'])
def create_article():
    data = request.get_json()  
    # Insert data into database
    try:
        cursor = db.get_db().cursor()
        cursor.execute(
            'INSERT INTO articles (Article_id, Title, Content, UploadDate) VALUES (%s, %s, %s, %s)',
            (data.get('Article_id'), data.get('Title'), data.get('Content'), data.get('UploadDate'))
        )
        db.get_db().commit()
        response = {"message": "Article created successfully"}
        return make_response(jsonify(response), 200)
    except Exception as e:
        db.get_db().rollback()
        response = {"error": str(e)}
        return make_response(jsonify(response), 500)
    
# update the articles information
@articles.route('/articles', methods=['PUT'])
def update_article():
    article_info = request.json
    id = article_info['article_id']
    title = article_info['title']
    content = article_info['content']
    uploaddate = article_info['uploaddate']

    query = 'UPDATE Articles SET Title = %s, Content = %s, UploadDate = %s where Article_id = %s'
    data = (title, content, uploaddate, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'article updated successfully'}), 200

# Delete the articles info given their ID number
@articles.route('/articles/<articleID>', methods=['DELETE'])
def delete_article(article_id):
    cursor = db.get_db().cursor()
    try:
        cursor.execute('DELETE FROM Articles WHERE Article_id = %s'.format(article_id))
        db.get_db().commit()
        return make_response(jsonify({'message': 'article deleted successfully'}), 200)
    except Exception as e:
        db.get_db().rollback()
        return make_response(jsonify({'error': str(e)}), 500)

# Get detailed info of all articles with a particular articleID
@articles.route('/articles/<articleID>', methods=['GET'])
def get_article_articleid(article_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Articles where Article_id = {0}'.format(article_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get detailed info of all articles with a particular userID
# @articles.route('/articles/<userID>', methods=['GET'])
# def get_article_userid(user_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from Articles where Article_id = {0}'.format(user_id))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response