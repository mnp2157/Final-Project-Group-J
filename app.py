
from flask import Flask
import mysql.connector
from flask import render_template, request, redirect, url_for, make_response
import mysql.connector
# instantiate the app
app = Flask(__name__)

# Connect to the database
mydb = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password= "rainarathod",
    database = "bookstore"
)
# Retrieve all the categories from the database
cursor = mydb.cursor()
query = "select categoryId, categoryName from category"
cursor.execute(query)
# Fetch all the rows in a list of tuples called categories
categories=cursor.fetchall()

# set up routes
@app.route('/')
def home():
    #Link to the index page.  Pass the categories as a parameter
    return render_template('index.html', categories=categories)

@app.route('/category')
def category():
    # Store the categoryId passed as a URL parameter into a variable
    categoryId = request.args.get('categoryId')
    # Retrieve the books from the database that are associated with the selected categoryId
    query2 = "SELECT * FROM book WHERE categoryId = %s"
    record=(categoryId,)
    cursor.execute(query2, record)
    # Fetch all the rows in a list of tuples called books.
    books=cursor.fetchall()
    # Link to the category page.  Pass the selectedCategory, categories and books as parameters
    return render_template('category.html', selectedCategory=categoryId, categories=categories, books=books)

@app.errorhandler(Exception)
def handle_error(e):
    """
    Output any errors - good for debugging.
    """
    return render_template('error.html', error=e) # render the edit template

if __name__ == "__main__":
    app.run(debug = True)
