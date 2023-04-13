/* DML: Referring to the DDL below, insert all data from the appropriately inner-joined tables */
DROP TABLE IF EXISTS Consolidated;
CREATE TABLE Consolidated (
	DepartureDate DATE,
	Quarter TEXT,
	AirlineCode TEXT,
	AirportCode TEXT,
	Departures INT,
	DelaySource TEXT,
	DelayCompensation TEXT,
	DelayMinutes INT
);

INSERT INTO Consolidated (DepartureDate, Quarter, AirlineCode, AirportCode, Departures, DelaySource, DelayCompensation, DelayMinutes)
SELECT dd.DepartureDate, mn.Quarter, dd.AirlineCode, d.AirportName, dd.Departures, d.DelaySource, dc.DelayCompensation, d.DelayMinutes
FROM DepartureData dd
INNER JOIN T2.MonthQuarterLookup2NF mn ON strftime('%m', dd.DepartureDate)= mn.Month
INNER JOIN T2.DepartureDelay d ON d.AirportName = dd.AirportCode
INNER JOIN DelayCompensation2NF dc ON d.DelaySource = dc.DelaySource;
--HINT: Refer to Chapter 10 of the course textbook, Sections: INNER JOIN and CARTESIAN JOIN, and construct an INSERT statement
--      using a SELECT statement with multiple inner-joined ***2NF*** tables plus DepartureDelay
--HINT: Use strftime('%m', ...) function to retrieve the month from the departure date to lookup in the MonthQuarterLookup2NF table
