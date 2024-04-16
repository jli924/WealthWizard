# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_root_password.txt').readline().strip()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'Magic'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Add the default route
    # Can be accessed from a web browser
    # http://ip_address:port/
    # Example: localhost:8001
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the Wealth Wizard app</h1>"

    # Import the various Beluprint Objects
    from src.users.users  import users
    from src.articles.articles import articles
    from src.comments.comments import comments
    from src.tags.tags import tags    
    from src.Accounts.accounts import accounts
    from src.categories.categories import categories
    from src.goals.goals import goals
    from src.transactions.transactions  import transactions
    from src.budgets.budgets import budgets
    from src.bills.bills import bills
    from src.investments.investments import investments

    # Register the routes from each Blueprint with the app object
    # and give a url prefix to each
    app.register_blueprint(users,    url_prefix='/u')
    app.register_blueprint(transactions, url_prefix='/tr')
    app.register_blueprint(tags, url_prefix='/ta')
    app.register_blueprint(investments, url_prefix='/i')
    app.register_blueprint(goals, url_prefix='/g')
    app.register_blueprint(comments, url_prefix='/co')
    app.register_blueprint(categories, url_prefix='/ca')
    app.register_blueprint(budgets, url_prefix='/bu')
    app.register_blueprint(bills, url_prefix='/bi')
    app.register_blueprint(articles, url_prefix='/ar')
    app.register_blueprint(accounts, url_prefix='/ac')

    # Don't forget to return the app object
    return app