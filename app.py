from flask import Flask, render_template, request, redirect, url_for, make_response
import mysql.connector

import mysql.connector

from openpyxl import load_workbook

# Create workbook object
book = load_workbook(filename="LastResortHotel.xlsx", data_only=True)

# Create worksheet object
data = book["Hotel"]

# Create connection object
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password=" ",
    database=""
)

# Create cursor
cursor = mydb.cursor()


class sleeping_room():
    sleepingRoomId = db.Something else goes
    here, i
    think
    name
    of
    row in sql?
    sleepingRoomNumber = db.
    roomFloor = db.
    bedRating = db.
    bedCount = db.
    bathroomAccessibility = db.
    telephone = db.
    television = db.
    drawers = db.


class sleeping_room_reservation():
    sleepingRoomReservationId = db.
    dateIn = db.
    dateOut = db.
    timeIn = db.
    timeOut = db.
    availability = db.
    overStayFee = db.
    staffId = db.
    sleepingRoomId = db.


class sleeping_room_guest():
    sleepingRoomReservationId = db.
    customerId = db.

class access_card():
    cardId = db.
    customerId = db.
    cardPin = db.
    date = db.
    recentTimeIn = db.

class meeting_room():
    meetingRoomId = db.
    meetingRoomNumber = db.
    roomFloor = db.
    buildingName = db.
    seatCapacity = db.
    bathroomAccessibility = db.
    patio = db.
    pool = db.


class meeting_room_reservation():
    meetingRoomReservationId = db.
    meetingRoomId = db.
    Date = db.
    Slot = db.
    Staffid = db.
    meetingRoomId = db.


class meeting_room_guest_list():
    meetingRoomReservationId = db.
    customerId = db.


class event():
    eventId = db.
    baseRate = db.
    eventDate = db.
    eventTimeStart = db.
    eventTimeEnd = db.
    meeingRooomId = db.
    estimatedSpeaker = db.
    hostType = db.
    baseRate = db.


class service_usage():
    usageId = db.
    serviceType = db.
    serviceCost = db.
    serviceDate = db.
    serviceStartTime = db.
    meetingRoomReservationId = db.
    sleepingRoomReservationId = db.
    staffId = db.


Class
customer():
customerId = db.
customerName = db.
customerType = db.
customerCooperativeness = db.
customerFlexbility = db.

app = Flask(__name__)


