DROP DATABASE IF EXISTS StrikePlanning;
CREATE DATABASE StrikePlanning;
USE StrikePlanning;

## TASK 1

DROP PROCEDURE IF EXISTS build_Targeting;
DELIMITER //


CREATE PROCEDURE build_Targeting()
BEGIN

	DROP DATABASE IF EXISTS Targeting;
	CREATE DATABASE Targeting;
	#USE Targeting;

	CREATE TABLE Targeting.targets(
	targetID VARCHAR(50),
	reportingSource ENUM('Satellite','Ground Observer','Airborne Observer'),
	reportingDate DATE,
	CONSTRAINT PK_TARGETS PRIMARY KEY(targetID)
	);

	CREATE TABLE Targeting.targetDimensions(
	targetID VARCHAR(50),
	length DECIMAL(10,2),
	width DECIMAL(10,2),
	sqFootage DECIMAL(10,2) GENERATED ALWAYS AS (length * width) STORED,
	CONSTRAINT PK_TARGETDim PRIMARY KEY(targetID),
	CONSTRAINT FK_TARGETDim FOREIGN KEY(targetID) REFERENCES targets(targetID)
	);

	CREATE TABLE Targeting.targetLocation(
	targetID VARCHAR(50),
	coords JSON,
	CONSTRAINT PK_TARGETLoc PRIMARY KEY(targetID),
	CONSTRAINT FK_TARGETLoc FOREIGN KEY(targetID) REFERENCES targets(targetID)
	);


	CREATE TABLE Targeting.targetValue(
	targetID VARCHAR(50),
	sector ENUM('North', 'East', 'West', 'South'),
	tgtvalue DECIMAL(10,2),
	CONSTRAINT PK_TARGETVal PRIMARY KEY(targetID),
	CONSTRAINT FK_TARGETVal FOREIGN KEY(targetID) REFERENCES targets(targetID)
	);


	CREATE TABLE Targeting.targetList(
	tgtDesignation VARCHAR(50),
	targetID VARCHAR(50),
	approved TINYINT(1),
	Priority ENUM('Immediate', 'High', 'Routine'),	 
	
	CONSTRAINT PK_TARGETLIST PRIMARY KEY(tgtDesignation),
	CONSTRAINT UK_TARGETLIST UNIQUE KEY(targetID),
	CONSTRAINT FK_TARGETLIST FOREIGN KEY(targetID) REFERENCES targets(targetID)
	);

	CREATE TABLE Targeting.resourcesRequired(
	tgtDesignation VARCHAR(50),
	assetType VARCHAR(50),
	assets INT,
	CONSTRAINT PK_RESOURCEReq PRIMARY KEY(tgtDesignation),
	CONSTRAINT FK_RESOURCEReq FOREIGN KEY(tgtDesignation) REFERENCES targetList(tgtDesignation)
	);

	CREATE TABLE Targeting.strikeAssets(
	assetID VARCHAR(50),
	assetType VARCHAR(50),
	costPerMission DECIMAL(10,2),
	CONSTRAINT PK_STRIKEAssets PRIMARY KEY(assetID)
	);


END //
DELIMITER ;

CALL build_Targeting();



## TASK 2


DROP PROCEDURE IF EXISTS populate_Targeting;
DELIMITER //


CREATE PROCEDURE populate_Targeting(Data JSON)
BEGIN

	

	INSERT INTO Targeting.targets (targetID,reportingSource,reportingDate)
	SELECT JSON_UNQUOTE(JSON_EXTRACT(Data, '$.targets[0]')) AS 'targetID', JSON_UNQUOTE(JSON_EXTRACT(Data, '$.targets[1]')) AS 'reportingSource',
	JSON_EXTRACT(Data, '$.targets[2]') AS 'reportingDate';

	INSERT INTO Targeting.targetDimensions (targetID,length,width)
	SELECT JSON_UNQUOTE(JSON_EXTRACT(Data, '$.targetDimensions[0]')) AS 'targetID', JSON_EXTRACT(Data, '$.targetDimensions[1]') AS 'length',
	JSON_EXTRACT(Data, '$.targetDimensions[2]') AS 'width';


	INSERT INTO Targeting.targetLocation (targetID,coords)
	SELECT JSON_UNQUOTE(JSON_EXTRACT(Data, '$.targetLocation[0]')) AS 'targetID', JSON_EXTRACT(Data, '$.targetLocation[1]') AS 'coords';

	INSERT INTO Targeting.targetValue (targetID,sector,tgtvalue)
	SELECT JSON_UNQUOTE(JSON_EXTRACT(Data, '$.targetValue[0]')) AS 'targetID', JSON_UNQUOTE(JSON_EXTRACT(Data, '$.targetValue[1]')) AS 'sector',
	JSON_EXTRACT(Data, '$.targetValue[2]') AS 'tgtvalue';

	INSERT INTO Targeting.targetList (tgtDesignation,targetID, approved, Priority)
	SELECT JSON_UNQUOTE(JSON_EXTRACT(Data, '$.targetList[0]')) AS 'tgtDesignation', JSON_UNQUOTE(JSON_EXTRACT(Data, '$.targetList[1]')) AS 'targetID',
	JSON_EXTRACT(Data, '$.targetList[2]') AS 'approved', JSON_UNQUOTE(JSON_EXTRACT(Data, '$.targetList[3]')) AS 'Priority';

	INSERT INTO Targeting.strikeAssets (assetID, assetType, costPerMission)
	SELECT JSON_UNQUOTE(JSON_EXTRACT(Data, '$.strikeAssets[0]')) AS 'assetID', JSON_UNQUOTE(JSON_EXTRACT(Data, '$.strikeAssets[1]')) AS 'assetType',
	JSON_EXTRACT(Data, '$.strikeAssets[2]') AS 'costPerMission';

	INSERT INTO Targeting.resourcesRequired (tgtDesignation, assetType, assets)
	SELECT JSON_UNQUOTE(JSON_EXTRACT(Data, '$.resourcesRequired[0]')) AS 'tgtDesignation', JSON_UNQUOTE(JSON_EXTRACT(Data, '$.resourcesRequired[1]')) AS 'assetType',
	JSON_EXTRACT(Data, '$.resourcesRequired[2]') AS 'assets';

	#SELECT * From targets;

END //
DELIMITER ;

CALL populate_Targeting(JSON_OBJECT(
	'targets',JSON_ARRAY('T-001','Satellite','2022-01-01'),
	'targetLocation',JSON_ARRAY('T-001',JSON_ARRAY(10,12)),
	'targetValue',JSON_ARRAY('T-001','North',120000),
	'targetDimensions',JSON_ARRAY('T-001',50,50),
	'targetList',JSON_ARRAY('APT-001','T-001',1,'Immediate'),
	'strikeAssets',JSON_ARRAY('A1','Aircraft',1000),
	'resourcesRequired',JSON_ARRAY('APT-001','Aircraft',4)));

CALL populate_Targeting(JSON_OBJECT(
	'targets',JSON_ARRAY('T-002','Ground Observer','2022-01-03')
	,'targetLocation',JSON_ARRAY('T-002',JSON_ARRAY(18,18)),'targetValue',JSON_ARRAY('T-002','South',125000),
	'targetDimensions',JSON_ARRAY('T-002',20,50),'targetList',JSON_ARRAY('APT-002','T-002',1,'Routine'),'strikeAssets',JSON_ARRAY('A2','Aircraft',1000),
	'resourcesRequired',JSON_ARRAY('APT-002','Aircraft',2)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-003','Satellite','2022-01-05')
	,'targetLocation',JSON_ARRAY('T-003',JSON_ARRAY(130,12)),'targetValue',JSON_ARRAY('T-003','East',125000),
	'targetDimensions',JSON_ARRAY('T-003',50,90),'targetList',JSON_ARRAY('APT-003','T-003',1,'Immediate'),'strikeAssets',JSON_ARRAY('S1','System',8000),
	'resourcesRequired',JSON_ARRAY('APT-003','System',4)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-004','Airborne Observer','2022-01-02')
	,'targetLocation',JSON_ARRAY('T-004',JSON_ARRAY(10,120)),'targetValue',JSON_ARRAY('T-004','North',180000),
	'targetDimensions',JSON_ARRAY('T-004',10,50),'targetList',JSON_ARRAY('APT-004','T-004',1,'High'),'strikeAssets',JSON_ARRAY('A3','Aircraft',1000),
	'resourcesRequired',JSON_ARRAY('APT-004','Aircraft',6)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-005','Satellite','2022-01-07')
	,'targetLocation',JSON_ARRAY('T-005',JSON_ARRAY(110,125)),'targetValue',JSON_ARRAY('T-005','West',160000),
	'targetDimensions',JSON_ARRAY('T-005',50,150),'targetList',JSON_ARRAY('APT-005','T-005',1,'Immediate'),'strikeAssets',JSON_ARRAY('S2','System',8000),
	'resourcesRequired',JSON_ARRAY('APT-005','System',2)));

#SELECT * FROM targetLocation;


## TASK 3



DROP PROCEDURE IF EXISTS display_Targeting;
DELIMITER //


CREATE PROCEDURE display_Targeting(D VARCHAR(30))
BEGIN

SET @sql_data = CONCAT('SELECT * FROM Targeting.', D);

PREPARE stmt FROM @sql_data;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql_data = CONCAT('Describe Targeting.', D);

PREPARE stmt FROM @sql_data;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



END //
DELIMITER ;

CALL display_Targeting('targetDimensions');
CALL display_Targeting('targetList');
CALL display_Targeting('targets');
CALL display_Targeting('targetLocation');
CALL display_Targeting('targetValue');
CALL display_Targeting('strikeAssets');
CALL display_Targeting('resourcesRequired');



