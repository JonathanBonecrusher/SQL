CREATE TABLE if not exists Bookings
(
	book_ref CHARACTER VARYING(6) PRIMARY KEY,
	book_date DATE NOT NULL,
	total_amount MONEY NOT NULL
);

CREATE TABLE if not exists Tickets
(
	ticket_no INTEGER PRIMARY KEY,
	book_ref CHARACTER VARYING(6) NOT NULL,
	passenger_id INTEGER NOT NULL,
	passenger_name CHARACTER VARYING(50) NOT NULL,
	contact_data DATE,
	FOREIGN KEY (book_ref) REFERENCES Bookings (book_ref)
);

CREATE TABLE if not exists Aircrafts
(
	aircraft_code CHARACTER PRIMARY KEY,
	model CHAR NOT NULL,
	arange INTEGER not null  
);

CREATE TABLE if not exists Seats
(
	aircraft_code CHARACTER,
	seat_no CHARACTER VARYING(5),
	fare_conditions CHARACTER VARYING(10) NOT NULL,
	PRIMARY KEY(aircraft_code,seat_no),
	FOREIGN KEY (aircraft_code) REFERENCES Aircrafts(aircraft_code)
);

CREATE TABLE if not exists Airports
(
	airport_code CHARACTER PRIMARY KEY,
	airport_name CHARACTER NOT NULL,
	city CHARACTER NOT NULL,
	longitude CHARACTER NOT NULL,
	latitude CHARACTER NOT NULL,
	timezone timestamp with time zone NOT NULL
);

CREATE TABLE if not exists Flights
(
	flight_id CHARACTER VARYING(6) PRIMARY KEY,
	flight_no INTEGER NOT NULL,
	scheduled_departure timestamp NOT NULL,
	scheduled_arrival timestamp NOT NULL,
	departure_airport CHARACTER VARYING(3) NOT NULL,
	arrival_airport CHARACTER VARYING(3) NOT NULL,
	status CHARACTER NOT NULL,
	aircraft_code CHARACTER NOT NULL,
	actual_departure timestamp with time zone,
	actual_arrival timestamp with time zone,
	FOREIGN KEY (aircraft_code) REFERENCES Aircrafts (aircraft_code),
	FOREIGN KEY (departure_airport) REFERENCES Airports (airport_code),
	FOREIGN KEY (arrival_airport) REFERENCES Airports (airport_code)
);


CREATE TABLE if not exists Ticket_flights
(
	ticket_no INTEGER,
	flight_id CHARACTER VARYING(6),
	fare_conditions CHARACTER VARYING(10) NOT NULL,
	amount INTEGER NOT NULL,
	PRIMARY KEY(ticket_no, flight_id),
	FOREIGN KEY (flight_id) REFERENCES Flights (flight_id),
	FOREIGN KEY (ticket_no) REFERENCES Tickets (ticket_no)
);

CREATE TABLE if not exists Boarding_passes
(
	ticket_no INTEGER,
	flight_id CHARACTER VARYING(6),
	boarding_no CHARACTER VARYING(30) NOT NULL,
	seat_no CHARACTER VARYING(5) NOT NULL,
	PRIMARY KEY(ticket_no, flight_id),
	FOREIGN KEY (flight_id, ticket_no) REFERENCES Ticket_flights (flight_id, ticket_no)
);

INSERT INTO bookings(book_ref,book_date,total_amount) VALUES
('A21B44','2015-11-15',15404);

INSERT INTO tickets(ticket_no,book_ref,passenger_id,passenger_name,contact_data) VALUES
(2134585900126, 'A21B44', 6518225420, 'DodonovAlex');

INSERT INTO aircrafts(aircraft_code,model,arange) VALUES
('31F','TY-134',3200);

INSERT INTO seats(aircraft_code,seat_no,fare_conditions) VALUES
('31F','2A','BUSINESS');

INSERT INTO airports(airport_code,airport_name,city,longitude,latitude,timezone) VALUES
('SVX','KOLTSOVO','EKATERINBURG','60.804314','56.750336','2015-11-22 15:11:42');

INSERT INTO flights(flight_id,flight_no,scheduled_departure,scheduled_arrival,departure_airport,arrival_airport,status,aircraft_code,actual_departure,actual_arrival) VALUES
('C33TT2',22145,'2015-11-16T21:11:30','2015-11-17T01:11:30','SVX','SVO','ON TIME','31F','2015-11-16 23:11:30','2015-11-17 01:11:30');

INSERT INTO ticket_flights(ticket_no,flight_id,fare_conditions,amount) VALUES
(2134585900126,'C33TT2','BUSINESS',54350);

INSERT INTO Boarding_passes(ticket_no,flight_id,boarding_no,seat_no) VALUES
(2134585900126,'C33TT2','213DD45','2A');
