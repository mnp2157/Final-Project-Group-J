from flask import Flask, render_template, request, redirect, url_for, make_response
import mysql.connector

# Create connection object
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="rainarathod", #CHANGE BASED ON HOST
    database=""
)
# Create cursor
cursor = mydb.cursor()

