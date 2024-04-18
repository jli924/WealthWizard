"""
Articles blueprint
"""

from flask import Blueprint, request, jsonify, make_response, current_app
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
@articles.route('/articles/<User_id>', methods=['POST'])
def create_article(User_id):
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    title = the_data['Title']
    content = the_data['Content']

    # Constructing the query
    query = 'INSERT INTO Articles (User_id, Content, Title) VALUES ('
    query += '"' + str(User_id) + '", '
    query += '"' + content + '", '
    query += '"' + title + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'
    
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

# Get detailed info of all articles with a particular userID
@articles.route('/articles/<user_id>', methods=['GET'])
def get_article_userid(user_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Articles where User_id = {0}'.format(user_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response