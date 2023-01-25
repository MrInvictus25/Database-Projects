USE imperial_defense;

/* TASK 1.

Create the function routerDisplay that accepts a router id number and prints the following
information, to the shell, about the router in the format shown below.
• RID
• RType
• RouteFinding
• Connectivity
*/

DROP FUNCTION IF EXISTS routerDisplay;

DELIMITER //
CREATE FUNCTION routerDisplay(A VARCHAR (5))

RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE N VARCHAR(100);
	SELECT CONCAT('ID: ',RID,'->TYPE: ',Rtype,'->PATH: ',RouteFinding,'->CONNECT: ',Connectivity)
	FROM Router WHERE RID = A INTO N;    
	RETURN N;
END //
DELIMITER ;

SELECT routerDisplay('RTR1') AS 'TASK 1';


/* TASK 2.

Create the function timeTillRevise that accepts the name of an antivirus software and prints to the
shell the software’s name and the number of years from February 10, 2022, until the software’s revise
date
*/


DROP FUNCTION IF EXISTS timeTillRevise;

DELIMITER //
CREATE FUNCTION timeTillRevise(Name VARCHAR (10))

RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE N VARCHAR(100);
	SELECT CONCAT(Sname, ' Antivirus Software Revision in ', ROUND(DATEDIFF('2025-08-04', CURDATE())/365,2), ' years')
	FROM AntiVirus WHERE Sname = Name INTO N;    
	RETURN N;
END //
DELIMITER ;

SELECT timeTillRevise('Aphalea') AS 'TASK 2';



/* TASK 3.

Create the function getFirewallCode that accepts the ID number of a firewall system and prints to
the shell, a firewall code based on the following scheme
*/


DROP FUNCTION IF EXISTS getFirewallCode;

DELIMITER //
CREATE FUNCTION getFirewallCode(ID VARCHAR (10))

RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE N INT;
	DECLARE IDNum VARCHAR(50);
	DECLARE SystName VARCHAR(100);
	DECLARE SystFilter VARCHAR(100);
	DECLARE Total VARCHAR(100);

	SELECT IDNumber,SystemName, Filter
	FROM Firewall WHERE IDNumber = ID INTO IDNum,SystName,SystFilter;

	IF SystName = 'Zara' THEN
		IF SystFilter = 'Packet' THEN
			SET N = 25;
		END IF;
	ELSEIF SystName = 'Zara' THEN
		IF SystFilter = 'Frame' THEN
			SET N = 30;
		END IF;
		
	ELSEIF SystName = 'Etis' THEN
		IF SystFilter = 'Frame' THEN
			SET N = 35;
		END IF;

	ELSEIF SystName = 'Etis' THEN
		IF SystFilter = 'Packet' THEN
			SET N = 40;
		END IF;
	ELSEIF SystName = 'Ecoria' THEN
		IF SystFilter = 'Packet' THEN
			SET N = 45;
		END IF;
	ELSEIF SystName = 'Cheirus' THEN
		IF SystFilter = 'Frame' THEN
			SET N = 50;
		END IF;

	END IF;	
	SET Total = CONCAT(IDNum,'->',SystName,'->',SystFilter,'->CODE: ', N);
	 
	RETURN Total;
END //
DELIMITER ;

SELECT getFirewallCode('FW_y-0') AS 'TASK 3';


/* TASK 4. 

Create the function hubPortDifference that accepts the ID number of two hubs and prints to the shell
the difference (absolute value) between their entry and exit port numbers
*/



DROP FUNCTION IF EXISTS hubPortDifference1;

DELIMITER //
CREATE FUNCTION hubPortDifference1(A VARCHAR (10))

RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE N VARCHAR(100);
	
	
	SELECT CONCAT('HUB: ', HID,' Range: ', ABS(EntryPort - ExitPort))
	FROM Hub 
	WHERE HID = A INTO N; 
	
	RETURN N;
END //
DELIMITER ;

# SELECT hubPortDifference1('HB-1') AS 'TASK 4';


DROP FUNCTION IF EXISTS hubPortDifference2;

DELIMITER //
CREATE FUNCTION hubPortDifference2(B VARCHAR (10))

RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE D VARCHAR(100);
	
	
	SELECT CONCAT('HUB: ', HID,' Range: ', ABS(EntryPort - ExitPort))
	FROM Hub 
	WHERE HID = B INTO D; 
	
	RETURN D;
END //
DELIMITER ;

# SELECT hubPortDifference2('HB-10') AS 'TASK 4';



DROP FUNCTION IF EXISTS hubPortDifference;

DELIMITER //
CREATE FUNCTION hubPortDifference(A VARCHAR (10), B VARCHAR(10))

RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE S VARCHAR(100);
	DECLARE W VARCHAR(100);
	DECLARE U VARCHAR(100);

	SET S = hubPortDifference1(A);
	SET W = hubPortDifference2(B);
	SET U = CONCAT(S,' ',W);
	
	RETURN U;
END //
DELIMITER ;

SELECT hubPortDifference('HB-1','HB-10') AS 'TASK 4';

/* Task 5.
Create the function distanceToSite that accepts the name of a site and the x and y coordinates of
another location and prints to the shell the 2D Euclidean distance from the site to the other location
*/


DROP FUNCTION IF EXISTS distanceToSite;

DELIMITER //
CREATE FUNCTION distanceToSite(NameSite VARCHAR(10),Xcor INT, Ycor INT)
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE Status VARCHAR(100);
    DECLARE 2D_Euclidean DECIMAL(5,2);
    DECLARE Total VARCHAR(100);

    SELECT SiteStatus,ROUND(SQRT(POW(ABS(Xcor - XCoord), 2) + POW(ABS(Ycor - YCoord), 2)), 2) 
    FROM Site WHERE SiteName = NameSite INTO Status, 2D_Euclidean;
   

    IF Status = 'OFFLINE' THEN
        SET Total = 'Site Offline...Distance Unknown';
    ELSE 
        SET Total = CONCAT('Distance to location ','[',Xcor,':',Ycor,']', ' from ',NameSite, ' is ',2D_Euclidean,' Km');
    END IF;

    RETURN Total;

END //
DELIMITER ;
SELECT distanceToSite('Fay246e20', 0, 0) AS 'TASK 5';
SELECT distanceToSite('Eaw99q12', 0, 0) AS 'TASK 5';


/* Task 6.
Create the function distanceBetweenWidgets that accepts the ID number of two widgets and prints
to the shell the 2D Euclidean distance between them
*/



DROP FUNCTION IF EXISTS distanceBetweenWidgets1;

DELIMITER //
CREATE FUNCTION distanceBetweenWidgets1(IDWidget_1 VARCHAR (10), IDWidget_2 VARCHAR (10))

RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE NameWidget_1 VARCHAR(50);
	DECLARE NameWidget_2 VARCHAR(50);
	DECLARE Loc_1 VARCHAR(50);
	DECLARE Loc_2 VARCHAR(50);
	DECLARE Total_1 VARCHAR(100);
	SELECT WID, Location FROM Widget WHERE WID = IDWidget_1 INTO NameWidget_1, Loc_1; 
	SELECT WID, Location FROM Widget WHERE WID = IDWidget_2 INTO NameWidget_2, Loc_2; 
	SET Total_1 = CONCAT('Distance from ',NameWidget_1,' Located at Site ', Loc_1, ' to ', NameWidget_2,
		' Located at Site ', Loc_2,' is');

	RETURN Total_1;
END //
DELIMITER ;


#SELECT distanceBetweenWidgets1('WDG#1', 'WDG#10') AS 'TASK 6';


DROP FUNCTION IF EXISTS distanceBetweenWidgets2;

DELIMITER //
CREATE FUNCTION distanceBetweenWidgets2(NameSite_1 VARCHAR(10), NameSite_2 VARCHAR(10), Distance_1 INT,Distance_2 INT)

RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE NameS_1 VARCHAR(10);
	DECLARE NameS_2 VARCHAR(10);
	DECLARE  2D_Euclidean_1 DECIMAL(5,2);
	DECLARE  2D_Euclidean_2 DECIMAL(5,2);   
	DECLARE Total_2 VARCHAR(50);
	SELECT SiteName, ROUND(SQRT(POW(ABS(Distance_1 - XCoord), 2) + POW(ABS(Distance_2 - YCoord), 2)), 2) 
	FROM Site WHERE SiteName = NameSite_1 INTO NameS_1, 2D_Euclidean_1; 
	SELECT SiteName, ROUND(SQRT(POW(ABS(Distance_1 - XCoord), 2) + POW(ABS(Distance_2 - YCoord), 2)), 2) 
	FROM Site WHERE SiteName = NameSite_2 INTO NameS_2, 2D_Euclidean_2; 
	
	
	SET Total_2 = CONCAT(ABS(2D_Euclidean_1 - 2D_Euclidean_2), ' Km');
	RETURN Total_2;
END //
DELIMITER ;

#SELECT distanceBetweenWidgets2('Aah987w7', 'Cah99q3', 0, 0) AS 'TASK 6';



DROP FUNCTION IF EXISTS distanceBetweenWidgets;

DELIMITER //
CREATE FUNCTION distanceBetweenWidgets(A VARCHAR(100), B VARCHAR(100), C VARCHAR(100), D VARCHAR(100),
	E INT, F INT)


RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE S VARCHAR(100);
	DECLARE W VARCHAR(100);
	DECLARE U VARCHAR(100);

	SET S = distanceBetweenWidgets1(A,B);
	SET W = distanceBetweenWidgets2(C,D,E,F);
	
	SET U = CONCAT(S,' ',W);
	
	RETURN U;

END //
DELIMITER ;

SELECT distanceBetweenWidgets('WDG#1', 'WDG#10', 'Aah987w7', 'Cah99q3', 0, 0) AS 'TASK 6';

/* TASK 7.
Create the function networkBWRange that accepts the name of a network and prints the following
information to the shell about the network
*/


DROP FUNCTION IF EXISTS networkBWRange;

DELIMITER //
CREATE FUNCTION networkBWRange(Net_Name VARCHAR(50))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE Network_Name VARCHAR(100);
    DECLARE Network_Status VARCHAR(50);
    DECLARE Type VARCHAR(50);
    DECLARE Distance DECIMAL(5,2);

    SELECT NetName, NetStatus, (MaxBW - MinBW) FROM Network 
    WHERE NetName = Net_Name INTO Network_Name,Network_Status, Distance;

    IF Network_Status = 'OFFLINE' THEN
        SET Network_Name = 'Network is Offline Bandwidth is 0';    
    ELSE
        IF Network_Name LIKE  '%_SAT' THEN
                SET Type = 'Satellite Network';  
        ELSEIF Network_Name LIKE  '%_DEF' THEN
                SET Type = "Defense Network";
        ELSEIF Network_Name LIKE  '%_CIV' THEN
                SET Type = "Civilian Network";  
        ELSEIF SNetwork_Name LIKE  '%_SURV' THEN
                SET Type = "Surveillance Network";  
        ELSEIF Network_Name LIKE  '%_TRACK' THEN
                SET Type = "Tracking Network";                          
        END IF;   
        SET Network_Name = CONCAT(Type,' ', Net_Name,' Bandwidth Range is ',Distance,'gbs');
    END IF;

    RETURN Network_Name;
END //
DELIMITER ;

SELECT networkBWRange('Zebetis02xNET_SAT') AS 'TASK 7.1';
SELECT networkBWRange('Brore03yNET_SAT') AS 'TASK 7.2';


/* TASK 8.

Create the function switchConfiguration that accepts the ID number of a switch and prints to the
shell information about the switch
*/


DROP FUNCTION IF EXISTS switchConfiguration;

DELIMITER //
CREATE FUNCTION switchConfiguration(Switch_ID VARCHAR(10))
RETURNS VARCHAR(200)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE ID_Number VARCHAR(150);
	DECLARE EntPort INT;
	DECLARE ExPort INT;
	DECLARE Stackable_New INT;
	DECLARE PoE_New INT;
	DECLARE A_To VARCHAR(50);
	DECLARE Source VARCHAR(50);
	DECLARE Network_Status VARCHAR(100);
	DECLARE Number_Port INT;
	DECLARE Total VARCHAR(200);
	DECLARE Ranki VARCHAR(100);


	SELECT SID, EntryPort, ExitPort, Stackable, PoE, AssignedTo 
	FROM Switch WHERE SID = Switch_ID INTO ID_Number, EntPort, ExPort, Stackable_New, PoE_New, A_To;

	SELECT NetStatus FROM Network WHERE NetName = A_To INTO Network_Status;

	IF Network_Status = 'OFFLINE' THEN
        SET ID_Number = 'The Switch is Currently Unavailable';    
    	RETURN ID_Number;
    END IF;
    
	IF SUBSTRING_INDEX(ID_Number,'-', -2) % 2 = 0 AND Stackable_New = 0 THEN
		SET Number_Port = EntPort;
	ELSE
		SET	Number_Port = ExPort;
	END IF;

	IF Number_Port = EntPort THEN
	    SET Ranki = 'Secure Switch';
	ELSE
	    SET Ranki = 'Unsecure Switch';
	END IF;
		
	IF PoE_New = 1 THEN
	    SET Source = 'AC';
	ELSE
	    SET Source = 'DC';
	END IF;
	

	SET ID_Number = CONCAT('Switch ',Switch_ID,' PRIMARY PORT: ',Number_Port,' POWER: ',Source,' SECURITY: ',Ranki,' is a part of Network ',A_To);
	RETURN ID_Number;
    
  	


END //
DELIMITER ;

SELECT switchConfiguration('SW-5') AS 'TASK 8_1';
SELECT switchConfiguration('SW-20') AS 'TASK 8_2';









