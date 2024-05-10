
CREATE DATABASE last_resort; 
use last_resort; 

-- Sleeping Room Table
CREATE TABLE sleeping_room (
    sleepingRoomId INT PRIMARY KEY AUTO_INCREMENT,
    sleepingRoomNumber INT,
    roomFloor INT,
    buildingName VARCHAR(20),
    bedRating INT,
    bedCount INT,
    bathroomAccessibility BOOLEAN,
    telephone BOOLEAN,
    television BOOLEAN,
    closets BOOLEAN,
    drawers BOOLEAN
);
-- Staff Table
CREATE TABLE staff (
    staffId INT PRIMARY KEY AUTO_INCREMENT,
    staffName VARCHAR(100),
    staffRole VARCHAR(50)
);

-- Customer Table
CREATE TABLE customer (
    customerId INT PRIMARY KEY AUTO_INCREMENT,
    customerName VARCHAR(100),
    customerType VARCHAR(50),
    customerCooperativeness BOOLEAN,
    customerFlexibility BOOLEAN
);

-- Sleeping Room Reservation Table
CREATE TABLE sleeping_room_reservation (
    sleepingRoomReservationId INT PRIMARY KEY AUTO_INCREMENT,
    dateIn DATE,
    dateOut DATE,
    timeIn TIME,
    timeOut TIME,
    availability BOOLEAN,
    overStayFee BOOLEAN,
    staffId INT,
    sleepingRoomId INT,
    FOREIGN KEY (staffId) REFERENCES staff(staffId),
    FOREIGN KEY (sleepingRoomId) REFERENCES sleeping_room(sleepingRoomId)
);

-- Sleeping Room Guest Table
CREATE TABLE sleeping_room_guest (
	sleepingRoomGuestId INT PRIMARY KEY AUTO_INCREMENT, 
    sleepingRoomReservationId INT,
    customerId INT,
    FOREIGN KEY (sleepingRoomReservationId) REFERENCES sleeping_room_reservation(sleepingRoomReservationId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
);

-- Access Card Table
CREATE TABLE access_card (
    cardId INT PRIMARY KEY AUTO_INCREMENT,
    customerId INT,
    cardPin VARCHAR(4),
    date DATE,
    recentTimeIn TIME,
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
);

-- Meeting Room Table
CREATE TABLE meeting_room (
    meetingRoomId INT PRIMARY KEY AUTO_INCREMENT,
    meetingRoomNumber VARCHAR(10),
    roomFloor INT,
    buildingName VARCHAR(50),
    seatCapacity INT,
    bathroomAccessibility BOOLEAN,
    patio BOOLEAN,
    pool BOOLEAN
);

-- Meeting Room Reservation Table
CREATE TABLE meeting_room_reservation (
    meetingRoomReservationId INT PRIMARY KEY AUTO_INCREMENT,
    meetingRoomId INT,
    date DATE,
    slot VARCHAR(50),
    staffId INT,
    FOREIGN KEY (meetingRoomId) REFERENCES meeting_room(meetingRoomId),
    FOREIGN KEY (staffId) REFERENCES staff(staffId)
);

-- Meeting Room Guest List Table
CREATE TABLE meeting_room_guest_list (
	meetingRoomGuestListId INT PRIMARY KEY AUTO_INCREMENT, 
    meetingRoomReservationId INT,
    customerId INT,
    FOREIGN KEY (meetingRoomReservationId) REFERENCES meeting_room_reservation(meetingRoomReservationId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
);

-- Event Table
CREATE TABLE event (
    eventId INT PRIMARY KEY AUTO_INCREMENT,
    baseRate INT,
    eventDate DATE,
    eventTimeStart TIME,
    eventTimeEnd TIME,
    meetingRoomId INT,
    estimatedGuestCount INT, 
    estimatedSpeaker VARCHAR(100),
    hostType VARCHAR(50),
    FOREIGN KEY (meetingRoomId) REFERENCES meeting_room(meetingRoomId)
);

-- Service Usage Table
CREATE TABLE service_usage (
    usageId INT PRIMARY KEY AUTO_INCREMENT,
    serviceType VARCHAR(50),
    serviceCost DECIMAL(10, 2),
    serviceDate DATE,
    serviceStartTime TIME,
    meetingRoomReservationId INT,
    sleepingRoomReservationId INT,
    staffId INT,
    FOREIGN KEY (meetingRoomReservationId) REFERENCES meeting_room_reservation(meetingRoomReservationId),
    FOREIGN KEY (sleepingRoomReservationId) REFERENCES sleeping_room_reservation(sleepingRoomReservationId),
    FOREIGN KEY (staffId) REFERENCES staff(staffId)
);

-- Advance Deposit Table
CREATE TABLE advance_deposit (
    depositId INT PRIMARY KEY AUTO_INCREMENT,
    depositAmount DECIMAL(10, 2),
    depositDate DATE, 
    customerId INT,
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
);

-- Sleeping Room Cost Table
CREATE TABLE sleeping_room_cost (
    sleepingRoomCostId INT PRIMARY KEY AUTO_INCREMENT,
    sleepingRoomId INT,
    baseRate DECIMAL(10, 2),
    FOREIGN KEY (sleepingRoomId) REFERENCES sleeping_room(sleepingRoomId)
);

-- Meeting Room Cost Table
CREATE TABLE meeting_room_cost (
    meetingRoomCostId INT PRIMARY KEY AUTO_INCREMENT,
    meetingRoomId INT,
    eatingStatus BOOLEAN, 
    baseRate DECIMAL(10, 2),
    FOREIGN KEY (meetingRoomId) REFERENCES meeting_room(meetingRoomId)
);

-- Receipt Table
CREATE TABLE receipt (
    receiptId INT PRIMARY KEY AUTO_INCREMENT,
    customerId INT, 
    chargeType VARCHAR(25),
    sleepingRoomReservationId INT, 
    meetingRoomReservationId INT, 
    serviceCost DECIMAL(10, 2), 
    baseCharge DECIMAL(10, 2), 
    totalCharge DECIMAL(10, 2), 
    FOREIGN KEY (sleepingRoomReservationId) REFERENCES sleeping_room_reservation(sleepingRoomReservationId), 
    FOREIGN KEY (customerId) REFERENCES customer(customerId), 
    FOREIGN KEY (meetingRoomReservationId) REFERENCES meeting_room_reservation(meetingRoomReservationId)
);

-- Event List Table 
CREATE TABLE event_list ( 
eventListId INT PRIMARY KEY AUTO_INCREMENT,
eventId INT, 
customerId INT, 
FOREIGN KEY (eventId) REFERENCES event(eventId), 
FOREIGN KEY (customerId) REFERENCES customer(customerId) 
); 
