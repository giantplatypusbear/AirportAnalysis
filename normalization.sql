DROP TABLE IF EXISTS Airlines;
CREATE TABLE Airlines (
  AirlineCode TEXT PRIMARY KEY,
  AirlineName TEXT
);
INSERT INTO Airlines 
 select DISTINCT AirlineCode, AirlineName from Departure0NF;

 DROP TABLE IF EXISTS Airports;
CREATE TABLE Airports (
  AirportCode TEXT PRIMARY KEY,
  AirportName TEXT,
  City TEXT,
  State TEXT 
);
INSERT INTO Airports 
 select DISTINCT AirportCode, AirportName, City, State from Departure0NF; 
 
 DROP TABLE IF EXISTS DepartureData;
 CREATE TABLE  DepartureData(
  DepartureDate DATE,
  AirlineCode TEXT,
  AirportCode TEXT,
  Departures INT,
  PRIMARY KEY(DepartureDate, AirlineCode, AirportCode)
  FOREIGN KEY (AirlineCode) REFERENCES Airlines(AirlineCode),
  FOREIGN KEY (AirportCode) REFERENCES Airports(AirportCode)
);
INSERT INTO DepartureData 
 select DISTINCT DepartureDate, AirlineCode, AirportCode, Departures from Departure0NF;
 
 

 