
USE asteroids;

DROP PROCEDURE IF EXISTS calculateStrategic;
DELIMITER //

CREATE PROCEDURE calculateStrategic(CountryName VARCHAR(20))
BEGIN
	DECLARE Design VARCHAR(20);
	DECLARE CountryN VARCHAR(20);
	DECLARE ATYPE VARCHAR(20);
	DECLARE Chromium Decimal(10,2);
	DECLARE Cobalt Decimal(10,2);
	DECLARE Tungsten Decimal(10,2);
	DECLARE Uranium Decimal(10,2);
	DECLARE row_count INT;    
	DECLARE counter INT;

	DECLARE cursor_Inv CURSOR FOR SELECT r.Designation, cs.Chromium, cs.Cobalt, cs.Tungsten, cs.Uranium, r.Country, r.AType
	FROM registry r
	JOIN composition_strategic cs ON r.Designation = cs.Designation
	WHERE r.Country = CountryName;



	DROP TABLE IF EXISTS strategicAnalysis;

	CREATE TABLE strategicAnalysis(
	A_DESG VARCHAR(20),
	A_Chromium Decimal(10,2),
	A_Cobalt Decimal(10,2),
	A_Tungsten Decimal(10,2),
	A_Uranium Decimal(10,2),
	A_Country VARCHAR(20),
	A_AType VARCHAR(20),
	
	CONSTRAINT PK_strategicAnalysis PRIMARY KEY(A_DESG)
	);


	OPEN cursor_Inv;

	SET counter = 0;
	SET row_count = FOUND_ROWS();
	WHILE counter < row_count DO
		FETCH cursor_Inv INTO Design, Chromium, Cobalt, Tungsten, Uranium, CountryN, ATYPE;
		INSERT INTO strategicAnalysis VALUES(Design, Chromium, Cobalt, Tungsten, Uranium, CountryN, ATYPE);
		SET counter = counter + 1;

	END WHILE;
	CLOSE cursor_Inv;
	SELECT * FROM strategicAnalysis LIMIT 20;

END //
DELIMITER ;


CALL calculateStrategic('US');





