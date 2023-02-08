USE droneFF;


DROP PROCEDURE IF EXISTS showAvailableUnits;
DELIMITER //


CREATE PROCEDURE showAvailableUnits(ActiveFireID VARCHAR(20))
BEGIN
	

	DROP TABLE IF EXISTS availability;

	CREATE TEMPORARY TABLE availability(
	UnitID VARCHAR(20),
	UnitLocation VARCHAR(20),
	FireLocation VARCHAR(20),
	DroneRange INT,
	DroneSpeed INT,
	DistanceToFire DECIMAL(10,2),
	FlightTimeToFire DECIMAL(10,2),
	DronesOperational INT,
	DronesReady INT,
	TotalCapacity INT,
	RequiredCapacity INT,
	TotalMissionCost INT,
	CONSTRAINT PK_AVAILABILITY PRIMARY KEY(UnitID)
	);


	

	INSERT INTO availability (UnitID, UnitLocation, DronesOperational,DronesReady, DroneRange, DroneSpeed,TotalCapacity,
	TotalMissionCost, RequiredCapacity, FireLocation, DistanceToFire, FlightTimeToFire)
	
	
	SELECT UnitID, AF_Location, DronesOperational,DronesReady, DRange, DSpeed, DCapacity*DronesReady,
	DronesReady*MissionCost, 
	CASE
		WHEN Fire_Category = 'A' THEN  400000
		WHEN Fire_Category = 'B' THEN  600000
		WHEN Fire_Category = 'C' THEN  800000
		WHEN Fire_Category = 'D' THEN  900000
	END
	, Fire_Location 

	, CONCAT(ROUND(SQRT(POW(SUBSTRING_INDEX(Fire_Location, ':', 1) - SUBSTRING_INDEX(AF_Location, ':', 1),2) + 
	POW(SUBSTRING_INDEX(Fire_Location, ':', -1) - SUBSTRING_INDEX(AF_Location, ':', -1),2)),2))

	, (CONCAT(ROUND(SQRT(POW(SUBSTRING_INDEX(Fire_Location, ':', 1) - SUBSTRING_INDEX(AF_Location, ':', 1),2) + 
	POW(SUBSTRING_INDEX(Fire_Location, ':', -1) - SUBSTRING_INDEX(AF_Location, ':', -1),2)),2))) / DSpeed

	
	FROM droneUnits, airfields, droneTypes 
	CROSS JOIN activeFires aF
	
	WHERE (airfields.AFID = droneUnits.AirfieldAssigned) AND (droneTypes.DModel = droneUnits.DroneModel)
	AND (aF.FireID = ActiveFireID); 

	
	
	SELECT * FROM availability WHERE DroneRange >= DistanceToFire;






END //
DELIMITER ;

CALL showAvailableUnits('F2-12-1');
CALL showAvailableUnits('F2-8-11');


