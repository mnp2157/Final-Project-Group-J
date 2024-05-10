from flask import Flask
import mysql.connector
from flask import render_template, request, redirect, url_for, make_response
import mysql.connector
# instantiate the app
app= Flask(__name__)

# Create connection object
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="rainarathod", #CHANGE BASED ON HOST
    database=""
)
# Create cursor
cursor = mydb.cursor()
@app.route('/')
def home():
    return render_template('base.html')

if __name__ == "__main__":
    app.run(debug = True)