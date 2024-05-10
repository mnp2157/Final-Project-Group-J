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
    database="last_resort"
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
        sql_query="SELECT MONTH(sleepRes.dateIn) AS month, SUM(r.totalCharge) AS total_revenue FROM receipt AS r JOIN sleeping_room_reservation AS sleepRes ON r.sleepingRoomReservationId = sleepRes.sleepingRoomReservationId WHERE sleepRes.dateIn BETWEEN '2024-01-01' AND '2024-03-31' GROUP BY YEAR(sleepRes.dateIn), MONTH(sleepRes.dateIn) ORDER BY month;"
    elif selected_option == '2':
        sql_query = "SELECT c.customerId, c.customerName, SUM(r.totalCharge) AS total_purchases FROM receipt AS r JOIN customer AS c ON r.customerId = c.customerId GROUP BY c.customerId, c.customerName ORDER BY total_purchases DESC LIMIT 10;"
    elif selected_option == '3':
        sql_query = "SELECT c.customerId, c.customerName, r.chargeType, SUM(r.totalCharge) AS total_purchases FROM receipt r LEFT JOIN meeting_room_guest_list mg ON mg.meetingRoomReservationId = r.meetingRoomReservationId LEFT JOIN sleeping_room_guest sg ON sg.sleepingRoomReservationId = r.sleepingRoomReservationId JOIN customer c ON c.customerId = COALESCE(mg.customerId, sg.customerId) GROUP BY c.customerId, c.customerName, r.chargeType ORDER BY total_purchases DESC;"
    elif selected_option == '4':
        sql_query="SELECT mr.buildingName, COUNT(mrr.meetingRoomReservationId) AS TotalBookings, SUM(r.totalCharge) AS TotalRevenue FROM meeting_room AS mr JOIN meeting_room_reservation AS mrr ON mr.meetingRoomId = mrr.meetingRoomId JOIN receipt AS r ON mrr.meetingRoomReservationId = r.meetingRoomReservationId GROUP BY mr.buildingName ORDER BY TotalBookings DESC, TotalRevenue DESC LIMIT 1;"
    elif selected_option == '5':
        sql_query = "SELECT serviceType, COUNT(usageId) AS NumberOfUses FROM service_usage GROUP BY serviceType ORDER BY NumberOfUses DESC LIMIT 1;"
    elif selected_option == '6':
        sql_query="SELECT sr.bedCount, COUNT(srr.sleepingRoomReservationId) AS TotalBookings, SUM(r.totalCharge) AS TotalRevenue FROM sleeping_room AS sr JOIN sleeping_room_reservation AS srr ON sr.sleepingRoomId = srr.sleepingRoomId JOIN receipt AS r ON srr.sleepingRoomReservationId = r.sleepingRoomReservationId GROUP BY sr.bedCount ORDER BY TotalBookings DESC, TotalRevenue DESC LIMIT 1;"

    cursor.execute(sql_query)
    result = cursor.fetchall()
    #Pass the result to the result.html template
    return render_template('result.html', result=result)

if __name__ == "__main__":
    app.run(debug = True)