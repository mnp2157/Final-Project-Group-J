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

@app.route('/index')
def index():
    return render_template('index.html')

@app.route('/get_data', methods=['POST'])
def get_data():
    selected_option = request.form['selected_option']

    # Define queries based on the selected option
    if selected_option == '1':
        return("you chose 1")
    elif selected_option == '2':
        #sql_query = "SELECT * FROM table2"
        return("you chose 2")
    elif selected_option == '3':
        #sql_query = "SELECT * FROM table3"
        return("you chose 3")
    else:
        # Handle default case or return an error
        return "Invalid option selected."

    #cursor.execute(sql_query)
    #result = cursor.fetchall()

    # Pass the result to the result.html template
    return render_template('result.html' #result=result)

if __name__ == "__main__":
    app.run(debug = True)