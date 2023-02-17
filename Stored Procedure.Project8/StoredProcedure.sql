/*
 Task 1: Entity Generation

- Create the function traducerAgent that accepts no parameters and returns an SQL-formatted
string that represents a traducer.

- Create the function desciminatorAgent that accepts no parameters and returns an SQL-
formatted string that represents a discriminator.

- Create the function resourceBuilder that accepts no parameters and returns an SQL-formatted
string that represents a resource.
*/

DROP DATABASE IF EXISTS AggressorPlanning;
CREATE DATABASE AggressorPlanning;
Use AggressorPlanning;

DROP FUNCTION IF EXISTS traducerAgent;
DELIMITER //


CREATE FUNCTION traducerAgent()
RETURNS VARCHAR(255)
DETERMINISTIC

BEGIN
    DECLARE Content VARCHAR(255);
    DECLARE TID VARCHAR(20);
    DECLARE TType VARCHAR(10);
    DECLARE TypeNumber INT;
    DECLARE TLoc_X INT;
    DECLARE TLoc_Y INT;
    DECLARE TValue INT;
    DECLARE TLethality INT;
    DECLARE TStatus VARCHAR(20);
    DECLARE StatusNumber INT;
    DECLARE TDurability FLOAT;
    DECLARE A INT;
    DECLARE B INT;

    SET TypeNumber = RAND() * (2 - 1) + 1;
    IF TypeNumber = 1 THEN
    	SET TType = 'Medium';
    ELSE 
    	SET TType = 'Heavy';
    END IF;

    SET TLoc_X = RAND() * (200 - 0) + 0 ;
    SET TLoc_Y = RAND() * (200 - 0) + 0 ;

    IF TType = 'Medium' THEN
    	SET TValue = 10;
    ELSE
    	SET TValue = 25;	
    END IF;

    IF TType = 'Medium' THEN
    	SET TLethality = 100;
    ELSE
    	SET TLethality = 300;	
    END IF;
    

    SET StatusNumber = RAND() * (2 - 1) + 1;
    IF StatusNumber = 1 THEN
    	SET TStatus = 'Available';
    ELSE 
    	SET TStatus = 'Not Available';
    END IF;

    SET TDurability = ROUND(TLethality/(RAND() * (10 - 5) + 5),2);
     
    SET A = RAND() * (5 - 1) + 5;
    SET B = RAND() * (100 - 1) + 1;

    SET TID = CONCAT('TA-',A,'-',B);

    SET Content = CONCAT("INSERT INTO aggressor_system.traducer VALUES('",TID,"','",TType,"'",', ', TLoc_X,', ', TLoc_Y,' ,', TValue,',', TLethality,', ',"'",TStatus,"'",', ', TDurability,')');
    RETURN Content;
  
     

END //
DELIMITER ;
SELECT traducerAgent() AS 'INV';


DROP FUNCTION IF EXISTS desciminatorAgent;
DELIMITER //


CREATE FUNCTION desciminatorAgent()
RETURNS VARCHAR(255)
DETERMINISTIC

BEGIN
    DECLARE DContent VARCHAR(255);
    DECLARE TID VARCHAR(20);
    DECLARE DType VARCHAR(10);
    DECLARE DTypeNumber INT;
    DECLARE DLoc_X INT;
    DECLARE DLoc_Y INT;
    DECLARE DValue INT;
    DECLARE DLethality INT;
    DECLARE DStatus VARCHAR(20);
    DECLARE StatusNumber INT;
    DECLARE DDurability FLOAT;
    DECLARE A INT;
    DECLARE B INT;

    SET DTypeNumber = RAND() * (2 - 1) + 1;
    IF DTypeNumber = 1 THEN
    	SET DType = 'Standard';
    ELSE 
    	SET DType = 'Multi-Role';
    END IF;

    SET DLoc_X = RAND() * (900 - 400) + 400 ;
    SET DLoc_Y = RAND() * (900 - 4) + 4 ;

    IF DType = 'Standard' THEN
    	SET DValue = 4;
    ELSE
    	SET DValue = 7;	
    END IF;

    IF DType = 'Standard' THEN
    	SET DLethality = 10;
    ELSE
    	SET DLethality = 12;	
    END IF;
    

    SET StatusNumber = RAND() * (2 - 1) + 1;
    IF StatusNumber = 1 THEN
    	SET DStatus = 'Available';
    ELSE 
    	SET DStatus = 'Not Available';
    END IF;

    SET DDurability = ROUND(DLethality/(RAND() * (10 - 5) + 5),2);
     
    SET A = RAND() * (5 - 1) + 5;
    SET B = RAND() * (100 - 1) + 1;

    SET TID = CONCAT('DA-',A,'-',B);

    SET DContent = CONCAT('INSERT INTO aggressor_system.discriminator VALUES','(',"'",TID,"',","'",DType,"'",', ', DLoc_X,', ', DLoc_Y,' ,', DValue,',', DLethality,', ',"'",DStatus,"'",', ', DDurability,')');
    RETURN DContent;
  
     

END //
DELIMITER ;
SELECT desciminatorAgent() AS 'INV 2';



DROP FUNCTION IF EXISTS resourceBuilder;
DELIMITER //


CREATE FUNCTION resourceBuilder()
RETURNS VARCHAR(255)
DETERMINISTIC

BEGIN
    DECLARE RContent VARCHAR(255);
    DECLARE TID VARCHAR(20);
    DECLARE RType VARCHAR(10);
    DECLARE RTypeNumber INT;
    DECLARE RLoc_X INT;
    DECLARE RLoc_Y INT;
    DECLARE RValue INT;
    DECLARE RStatus VARCHAR(20);
    DECLARE RStatusNumber INT;
    DECLARE RProtection INT;
    DECLARE A INT;
    DECLARE B INT;

    SET RTypeNumber = RAND() * (3 - 1) + 1;
    IF RTypeNumber = 1 THEN
    	SET RType = 'TAC';
    ELSEIF RTypeNumber = 2 THEN
    	SET RType = 'OP';
    ELSE
    	SET RType = 'STRAT';
    END IF;

    SET RLoc_X = RAND() * (950 - 700) + 700;
    SET RLoc_Y = RAND() * (950 - 700) + 700;

    IF RType = 'TAC' THEN
    	SET RValue = RAND() * (150 - 10) + 10;
    ELSEIF RType = 'OP' THEN
    	SET RValue = RAND() * (300 - 75) + 75;
    ELSE
    	SET RValue = RAND() * (500 - 250) + 250;
    END IF;

    SET RStatusNumber = RAND() * (2 - 1) + 1;
    IF RStatusNumber = 1 THEN
    	SET RStatus = 'Active';
    ELSE 
    	SET RStatus = 'Dormant';
    END IF;
   
    IF RType = 'TAC' and RStatus = 'Active' THEN
    	SET RProtection = RAND() * (300 - 100) + 100;
    ELSEIF RType = 'TAC' and RStatus = 'Dormant' THEN
    	SET RProtection = RAND() * (150 - 50) + 50;
    ELSEIF RType = 'OP' and RStatus = 'Active' THEN
    	SET RProtection = RAND() * (1000 - 750) + 750;
    ELSEIF RType = 'OP' and RStatus = 'Dormant' THEN
    	SET RProtection = RAND() * (150 - 50) + 50;
    ELSEIF RType = 'STRAT' and RStatus = 'Active' THEN
    	SET RProtection = RAND() * (3000 - 2500) + 2500;
    ELSE
    	SET RProtection = RAND() * (150 - 50) + 50;

    END IF;
     
    SET A = RAND() * (5 - 1) + 5;
    SET B = RAND() * (100 - 1) + 1;

    SET TID = CONCAT('R-',A,'#',B);

    SET RContent = CONCAT('INSERT INTO aggressor_system.resource VALUES','(',"'",TID,"',","'",RType,"'",', ', RLoc_X,', ', RLoc_Y,' ,', RValue,',',"'",RStatus,"'",', ', RProtection,')');
   	RETURN RContent;
  
     

END //
DELIMITER ;
SELECT resourceBuilder() AS 'INV 3';

/*
Task 2: Database Generation
Create the stored procedure buildAggressor that builds the database aggressor_system.

*/


DROP PROCEDURE IF EXISTS buildAggressor;
DELIMITER //


CREATE PROCEDURE buildAggressor()
BEGIN

	DROP DATABASE IF EXISTS aggressor_system;
	CREATE DATABASE aggressor_system;
	
	DROP TABLE IF EXISTS aggressor_system.traducer;
	CREATE TABLE aggressor_system.traducer(
	TID VARCHAR(50),
	TType ENUM('Medium','Heavy'),
	TLoc_X INT,
	TLoc_Y INT,
	TValue INT,
	TLethal INT,
	TStatus ENUM('Available','Not Available'),
	TDurable DECIMAL(10,2)
	);

	DROP TABLE IF EXISTS aggressor_system.discriminator;
	CREATE TABLE aggressor_system.discriminator(
	DID VARCHAR(20),
	DType ENUM('Standard','Multi-Role'),
	DLoc_X INT,
	DLoc_Y INT,
	DValue INT,
	DLethal INT,
	DStatus ENUM('Available','Not Available'),
	DDurable DECIMAL(10,2)
	);

	DROP TABLE IF EXISTS aggressor_system.resource;
	CREATE TABLE aggressor_system.resource(
	RID VARCHAR(20),
	RType ENUM('TAC','OP','STRAT'),
	RLoc_X INT,
	RLoc_Y INT,
	RValue INT,
	RStatus ENUM('Active','Dormant'),
	RProtect DECIMAL(10,2)
	);

END //
DELIMITER ;

CALL buildAggressor();


/*
Task 3: Database Population
Create the stored procedure aggressorPopulator that accepts the number of traducer records, discriminator records, and resource records and populates the database 
aggressor_system with the specified number, which have been generated using the functions.

*/


DROP PROCEDURE IF EXISTS aggressorPopulator;
DELIMITER //


CREATE PROCEDURE aggressorPopulator(NumTrad INT, NumDiscr INT, NumRes INT)
BEGIN
	
	DECLARE Count INT;
	SET Count = 0;

	WHILE Count < NumTrad DO
        SET @trad = traducerAgent();
        PREPARE stmt1 FROM @trad;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
		SET Count = Count + 1;
	END WHILE;
    SELECT * FROM aggressor_system.traducer;

    SET Count = 0;
    WHILE Count < NumDiscr DO
        SET @tdisc = desciminatorAgent();
        PREPARE stmt1 FROM @tdisc;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
		SET Count = Count + 1;
	END WHILE;
    SELECT * FROM aggressor_system.discriminator;

    SET Count = 0;
    WHILE Count < NumRes DO
        SET @tres = resourceBuilder();
        PREPARE stmt1 FROM @tres;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
		SET Count = Count + 1;
	END WHILE;
    SELECT * FROM aggressor_system.resource;


END //
DELIMITER ;

CALL aggressorPopulator(100,100,25);


/*

Task 4: Data Analysis 
*Modify your build_aggressor to remove the primary keys from the aggressor_system database.
*Build 100 traducers 100 discriminators 25 resource records.

Create the stored procedure TD_analysis that accepts no parameters and produces the analysis
of the traducer and discriminator records.

*/


DROP PROCEDURE IF EXISTS TD_analysis;
DELIMITER //


CREATE PROCEDURE TD_analysis()
BEGIN  
    DECLARE Status VARCHAR(50); DECLARE Result INT; DECLARE Result1 INT;
    DECLARE Type VARCHAR(50); DECLARE Result2 INT; DECLARE Result3 INT;
    DECLARE Result4 INT; DECLARE Result5 INT; DECLARE Result6 INT; DECLARE Result7 INT;
    DECLARE TotValue INT; DECLARE Result8 INT; DECLARE Result9 INT;
    DECLARE Result10 INT; DECLARE Result11 INT;
    DECLARE AvailPer DECIMAL(10,4);
    DECLARE row_count INT;    
    DECLARE counter INT;

    DECLARE Status2 VARCHAR(50); DECLARE Result12 INT; DECLARE Result13 INT;
    DECLARE Type2 VARCHAR(50); DECLARE Result14 INT; DECLARE Result15 INT;
    DECLARE Result16 INT; DECLARE Result17 INT; DECLARE Result18 INT; DECLARE Result19 INT;
    DECLARE TotValue2 INT; DECLARE Result20 INT; DECLARE Result21 INT;
    DECLARE Result22 INT; DECLARE Result23 INT;
    DECLARE AvailPer2 DECIMAL(10,4);
    DECLARE row_count2 INT;    
    DECLARE counter2 INT;


    DECLARE cursor_Inv CURSOR FOR SELECT TStatus,TType,TValue
    FROM aggressor_system.traducer;

    DECLARE cursor_Inv2 CURSOR FOR SELECT DStatus,DType,DValue
    FROM aggressor_system.discriminator;


    OPEN cursor_Inv;

    SET counter = 0;
    SET row_count = FOUND_ROWS();
    SET Result = 0; SET Result1 = 0;
    SET Result2 = 0; SET Result3 = 0;
    SET Result4 = 0; SET Result5 = 0;
    SET Result6 = 0; SET Result7 = 0;
    SET Result8 = 0; SET Result9 = 0;
    SET Result10 = 0; SET Result11 = 0;

    WHILE counter < row_count DO
        FETCH cursor_Inv INTO Status, Type, TotValue; 

        IF Status = 'Available' THEN 
            SET Result = Result + 1;
        ELSE
            SET Result1 = Result1 + 1;
        END IF;

        IF Type = 'Medium' THEN 
            SET Result2 = Result2 + 1;
        ELSE
            SET Result3 = Result3 + 1;
        END IF;
        
        IF Status = 'Available' and Type = 'Medium' THEN 
            SET Result4 = Result4 + 1;
        ELSEIF Status = 'Available' and Type = 'Heavy' THEN 
            SET Result5 = Result5 + 1;
        END IF;

        IF Status = 'Not Available' and Type = 'Medium' THEN 
            SET Result6 = Result6 + 1;
        ELSEIF Status = 'Not Available' and Type = 'Heavy' THEN 
            SET Result7 = Result7 + 1;
        END IF;

        IF Status = 'Available' THEN 
            SET Result8 = Result8 + TotValue;
        ELSEIF Status = 'Not Available' THEN 
            SET Result9 = Result9 + TotValue;
        END IF;

        IF Status = 'Available' and Type = 'Medium' THEN 
            SET Result10 = Result10 + TotValue;
        ELSEIF Status = 'Not Available' and Type = 'Heavy' THEN 
            SET Result11 = Result11 + TotValue;
        END IF;

        SET AvailPer = ROUND(Result/100,2);
        SET counter = counter + 1; 

    END WHILE;
    CLOSE cursor_Inv;


    OPEN cursor_Inv2;

    SET counter2 = 0;
    SET row_count2 = FOUND_ROWS();
    SET Result12 = 0; SET Result13 = 0;
    SET Result14 = 0; SET Result15 = 0;
    SET Result16 = 0; SET Result17 = 0;
    SET Result18 = 0; SET Result19 = 0;
    SET Result20 = 0; SET Result21 = 0;
    SET Result22 = 0; SET Result23 = 0;

    WHILE counter2 < row_count2 DO
        FETCH cursor_Inv2 INTO Status2, Type2, TotValue2; 

        IF Status2 = 'Available' THEN 
            SET Result12 = Result12 + 1;
        ELSE
            SET Result13 = Result13 + 1;
        END IF;

        IF Type2 = 'Standard' THEN 
            SET Result14 = Result14 + 1;
        ELSE
            SET Result15 = Result15 + 1;
        END IF;

        IF Status2 = 'Available' and Type2 = 'Standard' THEN 
            SET Result16 = Result16 + 1;
        ELSEIF Status2 = 'Available' and Type2 = 'Multi-Role' THEN 
            SET Result17 = Result17 + 1;
        END IF;

        IF Status2 = 'Not Available' and Type2 = 'Standard' THEN 
            SET Result18 = Result18 + 1;
        ELSEIF Status2 = 'Not Available' and Type2 = 'Multi-Role' THEN 
            SET Result19 = Result19 + 1;
        END IF;

        IF Status2 = 'Available' THEN 
            SET Result20 = Result20 + TotValue2;
        ELSEIF Status2 = 'Not Available' THEN 
            SET Result21 = Result21 + TotValue2;
        END IF;

        IF Status2 = 'Available' and Type2 = 'Standard' THEN 
            SET Result22 = Result22 + TotValue2;
        ELSEIF Status2 = 'Not Available' and Type2 = 'Multi-Role' THEN 
            SET Result23 = Result23 + TotValue2;
        END IF;

        SET AvailPer2 = ROUND(Result2/100,2);

        SET counter2 = counter2 + 1; 

    END WHILE;
    CLOSE cursor_Inv2;

    SELECT CONCAT('TRADUCER ANALYSIS','\n',SPACE(8),'Available:',' ',Result,' ','Not Available:',' ',Result1,'\n',SPACE(8), 
        'Total Mediums:',' ',Result2,' ','Total Heavies:',' ',Result3,'\n',SPACE(8),'Total Available Mediums:',' ',Result4,' ','Total Available Heavies:',' ',Result5,
        '\n',SPACE(8), 'Total Not Available Mediums:',' ',Result6,' ','Total Not Available Heavies:',' ',Result7,
        '\n',SPACE(8), 'Total Value Available:',' ',Result8,' ','Total Value Not Available:',' ',Result9,
        '\n',SPACE(8), 'Total Value Available Mediums:',' ',Result10,' ','Total Value Not Available Heavies:',' ',Result11,
        '\n',SPACE(8), 'Availability Percentage:',' ',AvailPer,
        '\n','DISCRIMINATOR ANALYSIS','\n',SPACE(8),'Available:',' ',Result12,' ','Not Available:',' ',Result13,'\n',SPACE(8),
        'Total Standards:',' ',Result14,' ','Total Multi-Roles:',' ',Result15,'\n',SPACE(8),'Total Available Standards:',' ',Result16,' ','Total Available Multi-Roles:',' ',Result17,
        '\n',SPACE(8), 'Total Not Available Standards:',' ',Result18,' ','Total Not Available Multi-Roles:',' ',Result19,
        '\n',SPACE(8), 'Total Value Available:',' ',Result20,' ','Total Value Not Available:',' ',Result21,
        '\n',SPACE(8), 'Total Value Available Standards:',' ',Result22,' ','Total Value Not Available Multi-Roles:',' ',Result23,
        '\n',SPACE(8), 'Availability Percentage:',' ',AvailPer2) AS INV;



END //
DELIMITER ;

CALL TD_analysis();


/*

Create the stored procedure RemoveDuplicates that accepts no parameters and removes all
duplicate Traducers (TID), Discriminators (DID), and Resources(RID) from their associated tables.
* Your stored procedure must make use of a cursor for all data retrieval and must utilize the
Delete command for duplicate record removal.

*/


DROP PROCEDURE IF EXISTS RemoveDuplicates;
DELIMITER //


CREATE PROCEDURE RemoveDuplicates()
BEGIN 

    DECLARE TID_Dup VARCHAR(50); DECLARE TType_Dup VARCHAR(50); DECLARE TLoc_X_Dup INT;
    DECLARE TLoc_Y_Dup INT; DECLARE TValue_Dup INT; DECLARE TLethal_Dup INT;
    DECLARE TStatus_Dup VARCHAR(50); DECLARE TDurable_Dup DECIMAL(10,2);
    DECLARE row_count INT;    
    DECLARE counter INT;
    DECLARE CountDuplicate INT;

    DECLARE DID_Dup VARCHAR(50); DECLARE DType_Dup VARCHAR(50); DECLARE DLoc_X_Dup INT;
    DECLARE DLoc_Y_Dup INT; DECLARE DValue_Dup INT; DECLARE DLethal_Dup INT;
    DECLARE DStatus_Dup VARCHAR(50); DECLARE DDurable_Dup DECIMAL(10,2);
    DECLARE row_count1 INT;    
    DECLARE counter1 INT;
    DECLARE CountDuplicate1 INT;

    DECLARE RID_Dup VARCHAR(50); DECLARE RType_Dup VARCHAR(50); DECLARE RLoc_X_Dup INT;
    DECLARE RLoc_Y_Dup INT; DECLARE RValue_Dup INT; 
    DECLARE RStatus_Dup VARCHAR(50); DECLARE RProtect_Dup DECIMAL(10,2);
    DECLARE row_count2 INT;    
    DECLARE counter2 INT;
    DECLARE CountDuplicate2 INT;
    

    DECLARE cursor_Traducer CURSOR FOR SELECT *
    FROM aggressor_system.traducer;

    DECLARE cursor_Discriminator CURSOR FOR SELECT *
    FROM aggressor_system.discriminator;

    DECLARE cursor_Resource CURSOR FOR SELECT *
    FROM aggressor_system.resource;

    OPEN cursor_Traducer;   # Coursor for traducer

    SET counter = 0;
    SET row_count = FOUND_ROWS();
    

    WHILE counter < row_count DO
        FETCH cursor_Traducer INTO TID_Dup, TType_Dup, TLoc_X_Dup, TLoc_Y_Dup, TValue_Dup, TLethal_Dup, TStatus_Dup, TDurable_Dup; 


        SELECT @CountDuplicate := count(TID) FROM aggressor_system.traducer WHERE TID = TID_Dup;
       
        
        IF @CountDuplicate > 1 THEN

            DELETE FROM aggressor_system.traducer WHERE TID = TID_Dup;
            INSERT INTO aggressor_system.traducer VALUES(TID_Dup, TType_Dup, TLoc_X_Dup, TLoc_Y_Dup, TValue_Dup, TLethal_Dup, TStatus_Dup, TDurable_Dup);
            SELECT CONCAT('DELETE ', TID_Dup); # For depicting information what TIDs are deleted


        END IF;

        SET counter = counter + 1;

    END WHILE;
    CLOSE cursor_Traducer;



    OPEN cursor_Discriminator;    # Coursor for discriminator

    SET counter1 = 0;
    SET row_count1 = FOUND_ROWS();
    

    WHILE counter1 < row_count1 DO
        FETCH cursor_Discriminator INTO DID_Dup, DType_Dup, DLoc_X_Dup, DLoc_Y_Dup, DValue_Dup, DLethal_Dup, DStatus_Dup, DDurable_Dup; 


        SELECT @CountDuplicate1 := count(DID) FROM aggressor_system.discriminator WHERE DID = DID_Dup;
       
        
        IF @CountDuplicate1 > 1 THEN

            DELETE FROM aggressor_system.discriminator WHERE DID = DID_Dup;
            INSERT INTO aggressor_system.discriminator VALUES(DID_Dup, DType_Dup, DLoc_X_Dup, DLoc_Y_Dup, DValue_Dup, DLethal_Dup, DStatus_Dup, DDurable_Dup);
            SELECT CONCAT('DELETE ', DID_Dup); # For depicting information what DIDs are deleted

        END IF;

        SET counter1 = counter1 + 1;

    END WHILE;
    CLOSE cursor_Discriminator;


        OPEN cursor_Resource;    # Coursor for resource

    SET counter2 = 0;
    SET row_count2 = FOUND_ROWS();
    

    WHILE counter2 < row_count2 DO
        FETCH cursor_Resource INTO RID_Dup, RType_Dup, RLoc_X_Dup, RLoc_Y_Dup, RValue_Dup, RStatus_Dup, RProtect_Dup; 


        SELECT @CountDuplicate2 := count(RID) FROM aggressor_system.resource WHERE RID = RID_Dup;
       
        
        IF @CountDuplicate2 > 1 THEN

            DELETE FROM aggressor_system.resource WHERE RID = RID_Dup;
            INSERT INTO aggressor_system.resource VALUES(RID_Dup, RType_Dup, RLoc_X_Dup, RLoc_Y_Dup, RValue_Dup, RStatus_Dup, RProtect_Dup);
            SELECT CONCAT('DELETE ', RID_Dup);  # For depicting information what RIDs are deleted

        END IF;

        SET counter2 = counter2 + 1;

    END WHILE;
    CLOSE cursor_Resource;


END //
DELIMITER ;

CALL RemoveDuplicates();
#SELECT count(TID) FROM aggressor_system.traducer;  # For depicting information what TIDs are duplicated
SELECT * FROM aggressor_system.traducer;
SELECT * FROM aggressor_system.discriminator;
SELECT * FROM aggressor_system.resource;




## SECOND VERSION!

DROP PROCEDURE IF EXISTS RemoveDuplicates1;
DELIMITER //


CREATE PROCEDURE RemoveDuplicates1()
BEGIN 

    DECLARE TID_Dup VARCHAR(50);DECLARE TType_Dup VARCHAR(50); DECLARE TLoc_X_Dup INT;
    DECLARE TLoc_Y_Dup INT; DECLARE TValue_Dup INT; DECLARE TLethal_Dup INT;
    DECLARE TStatus_Dup VARCHAR(50); DECLARE TDurable_Dup DECIMAL(10,2);
    DECLARE row_count INT;    
    DECLARE counter INT;
    DECLARE CountDuplicate INT;

    DECLARE DID_Dup VARCHAR(50); DECLARE DType_Dup VARCHAR(50); DECLARE DLoc_X_Dup INT;
    DECLARE DLoc_Y_Dup INT; DECLARE DValue_Dup INT; DECLARE DLethal_Dup INT;
    DECLARE DStatus_Dup VARCHAR(50); DECLARE DDurable_Dup DECIMAL(10,2);
    DECLARE row_count1 INT;    
    DECLARE counter1 INT;
    DECLARE CountDuplicate1 INT;

    DECLARE RID_Dup VARCHAR(50); DECLARE RType_Dup VARCHAR(50); DECLARE RLoc_X_Dup INT;
    DECLARE RLoc_Y_Dup INT; DECLARE RValue_Dup INT; 
    DECLARE RStatus_Dup VARCHAR(50); DECLARE RProtect_Dup DECIMAL(10,2);
    DECLARE row_count2 INT;    
    DECLARE counter2 INT;
    DECLARE CountDuplicate2 INT;
    

    DECLARE cursor_Traducer CURSOR FOR SELECT *
    FROM aggressor_system.traducer;

    DECLARE cursor_Discriminator CURSOR FOR SELECT *
    FROM aggressor_system.discriminator;

    DECLARE cursor_Resource CURSOR FOR SELECT *
    FROM aggressor_system.resource;


    DROP TABLE IF EXISTS temp_traducer;
    CREATE TEMPORARY TABLE temp_traducer(
    TID VARCHAR(50),
    TType ENUM('Medium','Heavy'),
    TLoc_X INT,
    TLoc_Y INT,
    TValue INT,
    TLethal INT,
    TStatus ENUM('Available','Not Available'),
    TDurable DECIMAL(10,2)
    );

    DROP TABLE IF EXISTS temp_discriminator;
    CREATE TEMPORARY TABLE temp_discriminator(
    DID VARCHAR(20),
    DType ENUM('Standard','Multi-Role'),
    DLoc_X INT,
    DLoc_Y INT,
    DValue INT,
    DLethal INT,
    DStatus ENUM('Available','Not Available'),
    DDurable DECIMAL(10,2)
    );

    DROP TABLE IF EXISTS temp_resource;
    CREATE TEMPORARY TABLE temp_resource(
    RID VARCHAR(20),
    RType ENUM('TAC','OP','STRAT'),
    RLoc_X INT,
    RLoc_Y INT,
    RValue INT,
    RStatus ENUM('Active','Dormant'),
    RProtect DECIMAL(10,2)
    );


    OPEN cursor_Traducer;    -- Coursor for traducer
    SET counter = 0;
    SET row_count = FOUND_ROWS();
    

    WHILE counter < row_count DO
        FETCH cursor_Traducer INTO TID_Dup, TType_Dup, TLoc_X_Dup, TLoc_Y_Dup, TValue_Dup, TLethal_Dup, TStatus_Dup, TDurable_Dup; 

        SELECT @CountDuplicate := count(TID) FROM temp_traducer WHERE TID = TID_Dup;
       
        
        IF @CountDuplicate = 0 THEN

            INSERT INTO temp_traducer VALUES(TID_Dup, TType_Dup, TLoc_X_Dup, TLoc_Y_Dup, TValue_Dup, TLethal_Dup, TStatus_Dup, TDurable_Dup);
            
        END IF;    
        
        IF @CountDuplicate = 1 THEN

            SELECT CONCAT('DELETE', TID_Dup);   # For depicting information what TIDs are deleted

        END IF;

        SET counter = counter + 1;

    END WHILE;
    CLOSE cursor_Traducer;

    DELETE FROM aggressor_system.traducer;
    INSERT INTO aggressor_system.traducer SELECT * FROM temp_traducer;


    OPEN cursor_Discriminator;    -- Coursor for discriminator
    SET counter1 = 0;
    SET row_count1 = FOUND_ROWS();
    

    WHILE counter1 < row_count1 DO
        FETCH cursor_Discriminator INTO DID_Dup, DType_Dup, DLoc_X_Dup, DLoc_Y_Dup, DValue_Dup, DLethal_Dup, DStatus_Dup, DDurable_Dup; 

        SELECT @CountDuplicate1 := count(DID) FROM temp_discriminator WHERE DID = DID_Dup;
       
        
        IF @CountDuplicate1 = 0 THEN

            INSERT INTO temp_discriminator VALUES(DID_Dup, DType_Dup, DLoc_X_Dup, DLoc_Y_Dup, DValue_Dup, DLethal_Dup, DStatus_Dup, DDurable_Dup);
            
        END IF;    
        
        IF @CountDuplicate1 = 1 THEN

            SELECT CONCAT('DELETE', DID_Dup);  # For depicting information what DIDs are deleted

        END IF;

        SET counter1 = counter1 + 1;

    END WHILE;
    CLOSE cursor_Discriminator;

    DELETE FROM aggressor_system.discriminator;
    INSERT INTO aggressor_system.discriminator SELECT * FROM temp_discriminator;

    OPEN cursor_Resource;    -- Coursor for resource
    SET counter2 = 0;
    SET row_count2 = FOUND_ROWS();

    WHILE counter2 < row_count2 DO
        FETCH cursor_Resource INTO RID_Dup, RType_Dup, RLoc_X_Dup, RLoc_Y_Dup, RValue_Dup, RStatus_Dup, RProtect_Dup; 

        SELECT @CountDuplicate2 := count(RID) FROM temp_resource WHERE RID = RID_Dup;
       
        
        IF @CountDuplicate2 = 0 THEN

            INSERT INTO temp_resource VALUES(RID_Dup, RType_Dup, RLoc_X_Dup, RLoc_Y_Dup, RValue_Dup, RStatus_Dup, RProtect_Dup);
            
        END IF;    
        
        IF @CountDuplicate2 = 1 THEN

            SELECT CONCAT('DELETE', RID_Dup);  # For depicting information what RIDs are deleted

        END IF;

        SET counter2 = counter2 + 1;

    END WHILE;
    CLOSE cursor_Resource;

    DELETE FROM aggressor_system.resource;
    INSERT INTO aggressor_system.resource SELECT * FROM temp_resource;


END //
DELIMITER ;

-- Uncomment to call the second version procedure and look through how it works. I commented this procedure because I had used DELETE Command one time.
-- But this procedure removes all duplicates, leaves the first origin and does not change an order of the records.

#CALL RemoveDuplicates1();
#SELECT count(TID) FROM aggressor_system.traducer;  # For depicting information what TIDs are duplicated
-- SELECT * FROM aggressor_system.traducer;
-- SELECT * FROM aggressor_system.discriminator;
-- SELECT * FROM aggressor_system.resource;



