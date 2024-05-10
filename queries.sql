-- This is the SQL queries for the Last Resort Project 
use last_resort; 

-- Q1) What is the total revenue for each month in the first quarter of 2024 for sleeping rooms? 
SELECT 
    MONTH(sleepRes.dateIn) AS month, 
    SUM(r.totalCharge) AS total_revenue
FROM 
    receipt AS r
JOIN 
    sleeping_room_reservation AS sleepRes ON r.sleepingRoomReservationId = sleepRes.sleepingRoomReservationId
WHERE 
    sleepRes.dateIn BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY 
    YEAR(sleepRes.dateIn), 
    MONTH(sleepRes.dateIn)
ORDER BY 
	month; 
    
-- Q2) Who are the top 10 customers based on purchases? 
SELECT 
    c.customerId, 
    c.customerName, 
    SUM(r.totalCharge) AS total_purchases
FROM 
    receipt AS r
JOIN 
    customer AS c ON r.customerId = c.customerId
GROUP BY 
    c.customerId, c.customerName
ORDER BY 
    total_purchases DESC
LIMIT 10;

-- Q3) Which customers have spent the most money in the past year? Does this create an ideal client type? 
SELECT 
    c.customerId, 
    c.customerName,
    r.chargeType,
    SUM(r.totalCharge) AS total_purchases 
FROM 
    receipt r 
LEFT JOIN 
    meeting_room_guest_list mg ON mg.meetingRoomReservationId = r.meetingRoomReservationId
LEFT JOIN 
    sleeping_room_guest sg ON sg.sleepingRoomReservationId = r.sleepingRoomReservationId 
JOIN 
    customer c ON c.customerId = COALESCE(mg.customerId, sg.customerId)
GROUP BY 
    c.customerId, c.customerName, r.chargeType
ORDER BY 
    total_purchases DESC
    LIMIT 10; 
    
-- Q4) Which meeting room location is doing best? 
SELECT 
    mr.buildingName
FROM 
    meeting_room AS mr
JOIN 
    meeting_room_reservation AS mrr ON mr.meetingRoomId = mrr.meetingRoomId
JOIN 
    receipt AS r ON mrr.meetingRoomReservationId = r.meetingRoomReservationId
GROUP BY 
	mr.buildingName
ORDER BY 
    COUNT(mrr.meetingRoomReservationId) DESC,
    SUM(r.totalCharge) DESC
    LIMIT 1; 

-- Q5) What service type is the most popular? 
SELECT 
    serviceType,
    COUNT(usageId) AS NumberOfUses
FROM 
    service_usage
GROUP BY 
    serviceType
ORDER BY 
    NumberOfUses DESC
LIMIT 1; 

-- Q6) Which type of sleeping room is doing best? 
SELECT 
    sr.bedCount
FROM 
    sleeping_room AS sr
JOIN 
    sleeping_room_reservation AS srr ON sr.sleepingRoomId = srr.sleepingRoomId
JOIN 
    receipt AS r ON srr.sleepingRoomReservationId = r.sleepingRoomReservationId
GROUP BY 
    sr.bedCount
ORDER BY 
	COUNT(srr.sleepingRoomReservationId) DESC,
    SUM(r.totalCharge)  DESC
    LIMIT 1; 

