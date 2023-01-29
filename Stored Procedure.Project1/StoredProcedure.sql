USE imperial_defense;

DROP PROCEDURE IF EXISTS widget_Refactor;
DELIMITER //

CREATE PROCEDURE widget_Refactor()
BEGIN

	DROP TABLE IF EXISTS r_widget;

	CREATE TABLE r_widget(
	RWID INT AUTO_INCREMENT,
	WidgetID VARCHAR(20),
	RType ENUM('IDEV', 'IPAD', 'ITERM'),
	NetAssigned VARCHAR(40),
	RNetType ENUM('SAT', 'TRACK', 'SURV', 'DEF', 'CIV'),
	RLocation VARCHAR(100),
	RAccess ENUM('A1', 'B2', 'C3', 'D4'),
	RSecure ENUM('Encrypted', 'Plain Text'),
	RUser JSON,
	CONSTRAINT PK_R_WIDGET PRIMARY KEY(RWID),
	CONSTRAINT UK_R_WIDGET UNIQUE KEY(WidgetID),
	CONSTRAINT FK_R_WIDGET FOREIGN KEY(WidgetID) REFERENCES Widget(WID)
	);


	INSERT INTO r_widget (WidgetID, NetAssigned, RLocation, RType, RNetType, RAccess, RSecure)#, RUser)
	SELECT WID, AssignedTo, 
		CONCAT(Location,'--', ' X:', S.XCoord, ' Y:',S.YCoord),
		CASE  
			WHEN WType = 'Device' THEN 'IDEV' 
			WHEN WType = 'Pad' THEN 'IPAD'
			WHEN WType = 'Terminal' THEN 'ITERM' 
		END
		, SUBSTRING_INDEX(AssignedTo,'_',-1),
		CASE 
			WHEN SUBSTRING(AccessCode,1, 1) = 'A' THEN 'A1'
			WHEN SUBSTRING(AccessCode,1, 1) = 'B' THEN 'B2'
			WHEN SUBSTRING(AccessCode,1, 1) = 'C' THEN 'C3'
			WHEN SUBSTRING(AccessCode,1, 1) = 'D' THEN 'D4'
		END
		, CASE
			WHEN Secure = True THEN  'Encrypted' 
			WHEN Secure = False THEN 'Plain Text' 
		END
	
	FROM Widget W 
	JOIN Site S ON W.Location = S.SiteName;

	


	UPDATE r_widget,
		(SELECT WID, WType, AccessCode FROM Widget) AS Widget

	SET r_widget.RUser = JSON_OBJECT("ID", WID,"DEVICE", WType, "ACCESS CODE", AccessCode,"Encrypted_YN", 
		CASE
			WHEN r_widget.RSecure = 'Encrypted' THEN 'User Encrypted'
			WHEN r_widget.RSecure = 'Plain Text' THEN 'User Not Encrypted'
		END
		)

	WHERE r_widget.WidgetID = Widget.WID;

	SELECT * FROM r_widget LIMIT 10;
	
END //
DELIMITER ;

CALL widget_Refactor();