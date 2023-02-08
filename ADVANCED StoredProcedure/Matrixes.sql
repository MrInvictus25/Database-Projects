Use asteroids;
-- Function that creates 1D Random Numeric Array
DROP FUNCTION IF EXISTS random1D;
DELIMITER //


CREATE FUNCTION random1D(C INT)
RETURNS JSON
DETERMINISTIC
-- SELECT JSON_INSERT(
BEGIN
    DECLARE V INT; DECLARE I INT;
    DECLARE J JSON;
    SET I = 0;
    SET J = JSON_ARRAY();
    WHILE I < C DO
        SET V = RAND() * 10;
        SET J = JSON_ARRAY_INSERT(J,CONCAT('$[',I,']'),V);
        SET I = I + 1;
        

    END WHILE;
    RETURN J;
    
    

END //
DELIMITER ;


SELECT random1D(4) AS INV;



-- Function That Randomly Generates Array
DROP FUNCTION IF EXISTS randomArray;
DELIMITER //

CREATE FUNCTION randomArray(F VARCHAR(10))
RETURNS JSON
DETERMINISTIC

BEGIN
    DECLARE J JSON; 
    DECLARE I INT; 
    DECLARE V INT; 
    DECLARE A JSON;
    SET V = 0; 
    
    IF F = 'TRUE' THEN
        SET I = 0;
        SET J = JSON_ARRAY();
        WHILE I < 5 DO
            SET V = RAND() * 10;
            SET A = random1D(5);
            SET J = JSON_ARRAY_INSERT(J,CONCAT('$[',I,']'),A);
            SET I = I + 1;
    
        END WHILE;
    
    END IF;
    
    
    IF F = 'FALSE' THEN
        SET I = 0;
        SET J = JSON_ARRAY();
        WHILE I < 4 DO
            SET V = RAND() * 10;
            SET A = random1D(4);
            SET J = JSON_ARRAY_INSERT(J,CONCAT('$[',I,']'),A);
            SET I = I + 1;
        
        END WHILE;
    
    END IF;
    RETURN J;

END //
DELIMITER ;
SELECT randomArray('TRUE') AS INV;
SELECT randomArray('FALSE') AS INV;


-- Stored Procedure to build Database

DROP PROCEDURE IF EXISTS CypherMatrixBuilder;
DELIMITER //

CREATE PROCEDURE CypherMatrixBuilder()

BEGIN
    DECLARE I INT;  
    DECLARE J JSON;

    DROP DATABASE IF EXISTS Cyber_Lock;
    CREATE DATABASE Cyber_Lock;
    
    DROP TABLE IF EXISTS Cyber_Lock.CyberMatrix;
    CREATE TABLE Cyber_Lock.CyberMAtrix(
    JPK INT AUTO_INCREMENT,
    JA JSON,
    CONSTRAINT pk_cm PRIMARY KEY(JPK)
    );
    
    SET J = JSON_ARRAY();
    SET I = 0;
    WHILE I < 5 DO
        SET J = randomArray('TRUE');
        INSERT INTO Cyber_Lock.CyberMatrix (JA) VALUES(J);
        SET I = I + 1;
    END WHILE;

    SET I = 0;
    WHILE I < 5 DO
        SET J = randomArray('FALSE');
        INSERT INTO Cyber_Lock.CyberMatrix (JA) VALUES(J);
        SET I = I + 1;

    END WHILE;

END //
DELIMITER ;
CALL CypherMatrixBuilder();
SELECT * FROM Cyber_Lock.CyberMatrix;

-- Stored Procedure to accept a command

DROP PROCEDURE IF EXISTS CypherMatrixSolver;
DELIMITER //


CREATE PROCEDURE CypherMatrixSolver(CMD VARCHAR(20), IndiceA INT, IndiceB INT)

BEGIN
    DECLARE J JSON;
    DECLARE J2 JSON;
    DECLARE J5 JSON;
    DECLARE J6 JSON;
    DECLARE J3 INT;
    DECLARE J4 INT;
    DECLARE I INT;
    DECLARE I2 INT;
    DECLARE Result INT;
    DECLARE Result2 INT;
    DECLARE Count INT;

    IF CMD = 'ADD' THEN

        SET I = 0;
        SET J = JSON_ARRAY();

        WHILE I < 5 DO
            
            SET I2 = 0;
            SET J2 = JSON_ARRAY();

            WHILE I2 < 5 DO

                SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I2,']')) INTO Result  
                FROM Cyber_Lock.CyberMatrix
                WHERE JPK = IndiceA;

                SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I2,']')) INTO Result2  
                FROM Cyber_Lock.CyberMatrix
                WHERE JPK = IndiceB;

                IF Result != 'NULL' THEN

                    SET J2 = JSON_ARRAY_INSERT(J2,CONCAT('$[',I2,']'), Result + Result2);

                END IF;

                SET I2 = I2 + 1;

            END WHILE;
            
            IF J2 != 'NULL' THEN

                SET J = JSON_ARRAY_INSERT(J,CONCAT('$[',I,']'), J2);
        
            END IF;

            SET I = I + 1;

        END WHILE;

        SELECT J AS 'ADD';   
    END IF;



    IF CMD = 'SUM_COLUMN' THEN

        SET I = 0;
        SET J = JSON_ARRAY();

        WHILE I < 5 DO
            
            SET I2 = 0;
            SET J3 = 0;

            WHILE I2 < 5 DO

                SELECT JSON_EXTRACT(JA, CONCAT('$[',I2,']', '[',I,']')) INTO Result  
                FROM Cyber_Lock.CyberMatrix
                WHERE JPK = IndiceA;

                IF Result != 'NULL' THEN

                    SET J3 = J3 + Result;

                END IF;

                SET I2 = I2 + 1;

            END WHILE;
            
            IF J3 != 'NULL' THEN

                SET J = JSON_ARRAY_INSERT(J,CONCAT('$[',I,']'), J3);
        
            END IF;

            SET I = I + 1;

        END WHILE;

        SELECT J AS 'SUM_COLUMN';  
    
    END IF;



  
    IF CMD = 'SUM_ROW' THEN

        SET I = 0;
        SET J = JSON_ARRAY();

        WHILE I < 5 DO
            
            SET I2 = 0;
            SET J3 = 0;

            WHILE I2 < 5 DO

                SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I2,']')) INTO Result  
                FROM Cyber_Lock.CyberMatrix
                WHERE JPK = IndiceA;

            
                IF Result != 'NULL' THEN

                    SET J3 = J3 + Result;

                END IF;

                SET I2 = I2 + 1;

            END WHILE;
            
            IF J3 != 'NULL' THEN

                SET J = JSON_ARRAY_INSERT(J,CONCAT('$[',I,']'), J3);
        
            END IF;

            SET I = I + 1;

        END WHILE;

        SELECT J AS 'SUM_ROW';  
    
    END IF;


    IF CMD = 'SUM_DIAGONAL' THEN

        SET I = 0;
        SET J = JSON_ARRAY();
        SET J3 = 0;
        SET J4 = 0;
        

        WHILE I < 5 DO
            

            SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I,']')), JSON_LENGTH(JSON_EXTRACT(JA, CONCAT('$[',I,']')))
            INTO Result, Count
            FROM Cyber_Lock.CyberMatrix
            WHERE JPK = IndiceA;

            IF Result != 'NULL'  THEN
                    
                SET J3 = J3 + Result;


            END IF;

            SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',(Count - 1) - I,']')) INTO Result2  
            FROM Cyber_Lock.CyberMatrix
            WHERE JPK = IndiceA;

            IF Result2 != 'NULL' THEN
                    
                SET J4 = J4 + Result2;
                
            END IF;
            
            SET I = I + 1;

        END WHILE;
        
        SET J = JSON_ARRAY_INSERT(J, '$[0]', J3);
        SET J = JSON_ARRAY_INSERT(J, '$[1]', J4);
        SELECT J AS 'SUM_DIAGONAL';

        
    END IF;


    IF CMD = 'REORDER_EVEN' THEN

        SET I = 0;
        SET J = JSON_ARRAY();
        SET J2 = JSON_ARRAY();
        SET J5 = JSON_ARRAY();
        SET J3 = 0;

        WHILE I < 5 DO
            
            SET I2 = 0;
            
            WHILE I2 < 5 DO

                SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I2,']')) INTO Result  
                FROM Cyber_Lock.CyberMatrix
                WHERE JPK = IndiceA;

                IF Result = 0 or Result != 'NULL' THEN

                    IF Result %2 = 0 THEN

                        SET J = JSON_ARRAY_INSERT(J,CONCAT('$[',J3,']'), Result);

                    ELSE

                        SET J2 = JSON_ARRAY_INSERT(J2,CONCAT('$[',J3,']'), Result);

                    END IF;

                    SET J3 = J3 + 1;

                END IF;

                SET I2 = I2 + 1;
            
            END WHILE;

                    
            SET I = I + 1;

        END WHILE;

        SET J5 = JSON_MERGE(J,J2);

        SET I = 0;
        SET J3 = 0;
        SET J = JSON_ARRAY();   # rewrite a massive for new usage
        SET Count = SQRT(JSON_LENGTH(J5)); # to perform only necessary amount of loops

        
        WHILE I < Count DO

            SET I2 = 0;
            SET J2 = JSON_ARRAY(); # rewrite a massive for new usage

            WHILE I2 < Count DO

                SET J4 = JSON_EXTRACT(J5, CONCAT('$[',J3,']'));

                IF J4 = 0 or J4 != 'NULL' THEN

                    SET J2 = JSON_ARRAY_INSERT(J2, CONCAT('$[',I2,']'), J4);
                    SET J3 = J3 + 1;

                END IF;

                
                SET I2 = I2 + 1;
                

            END WHILE;

            SET J = JSON_ARRAY_INSERT(J, CONCAT('$[',I,']'), J2);      
            SET I = I + 1;

        END WHILE;

        SELECT J AS 'REORDER_EVEN';

    
    END IF;

    
    IF CMD = 'REORDER_ODD' THEN

        SET I = 0;
        SET J = JSON_ARRAY();
        SET J2 = JSON_ARRAY();
        SET J5 = JSON_ARRAY();
        SET J3 = 0;

        WHILE I < 5 DO
            
            SET I2 = 0;
            
            WHILE I2 < 5 DO

                SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I2,']')) INTO Result  
                FROM Cyber_Lock.CyberMatrix
                WHERE JPK = IndiceA;

                IF Result = 0 or Result != 'NULL' THEN

                    IF Result %2 != 0 THEN

                        SET J = JSON_ARRAY_INSERT(J,CONCAT('$[',J3,']'), Result);

                    ELSE

                        SET J2 = JSON_ARRAY_INSERT(J2,CONCAT('$[',J3,']'), Result);

                    END IF;

                    SET J3 = J3 + 1;

                END IF;

                SET I2 = I2 + 1;
            
            END WHILE;

                    
            SET I = I + 1;

        END WHILE;

        SET J5 = JSON_MERGE(J,J2);

        SET I = 0;
        SET J3 = 0;
        SET J = JSON_ARRAY();   # rewrite a massive for new usage
        SET Count = SQRT(JSON_LENGTH(J5)); # to perform only necessary amount of loops

        
        WHILE I < Count DO

            SET I2 = 0;
            SET J2 = JSON_ARRAY(); # rewrite a massive for new usage

            WHILE I2 < Count DO

                SET J4 = JSON_EXTRACT(J5, CONCAT('$[',J3,']'));

                IF J4 = 0 or J4 != 'NULL' THEN

                    SET J2 = JSON_ARRAY_INSERT(J2, CONCAT('$[',I2,']'), J4);
                    SET J3 = J3 + 1;

                END IF;

                
                SET I2 = I2 + 1;
                

            END WHILE;

            SET J = JSON_ARRAY_INSERT(J, CONCAT('$[',I,']'), J2);      
            SET I = I + 1;

        END WHILE;

        SELECT J AS 'REORDER_ODD';

    
    END IF;
    
    IF CMD = 'FLATTEN' THEN

        SET I = 0;
        SET J = JSON_ARRAY();
        SET J3 = 0;

        WHILE I < 5 DO
            
            SET I2 = 0;
            
            WHILE I2 < 5 DO

                SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I2,']')) INTO Result  
                FROM Cyber_Lock.CyberMatrix
                WHERE JPK = IndiceA;

                IF Result != 'NULL' THEN

                    SET J = JSON_ARRAY_INSERT(J,CONCAT('$[',J3,']'), Result);
            
                    SET J3 = J3 + 1;

                END IF;
  
                SET I2 = I2 + 1;

            END WHILE;
                    
            SET I = I + 1;

        END WHILE;

        SELECT J AS 'FLATTEN'; 
    
    END IF;
    

    IF CMD = 'REDUCE_SUM' THEN

        SELECT JSON_EXTRACT(JA, CONCAT('$[0]')) INTO J5  
        FROM Cyber_Lock.CyberMatrix
        WHERE JPK = IndiceA;

        SET J = JSON_ARRAY();

        IF JSON_LENGTH(J5) %2 = 0 THEN

            SET I = 0;

            WHILE I < JSON_LENGTH(J5) DO

                SET I2 = 0;
        
                SET J2 = JSON_ARRAY();

                WHILE I2 < JSON_LENGTH(J5) DO

                    SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I2,']')) INTO Result  
                    FROM Cyber_Lock.CyberMatrix
                    WHERE JPK = IndiceA;

                    SELECT JSON_EXTRACT(JA, CONCAT('$[',I + 1,']', '[',I2,']')) INTO Result2  
                    FROM Cyber_Lock.CyberMatrix
                    WHERE JPK = IndiceA;

                    SET J2 = JSON_ARRAY_INSERT(J2, CONCAT('$[',I2,']'), Result + Result2);
    
                    SET I2 = I2 + 1;

                END WHILE;

                SET J = JSON_ARRAY_INSERT(J, CONCAT('$[',I2,']'), J2);
                SET I = I + 2;

            END WHILE;


        END IF;

        SELECT J AS 'REDUCE_SUM'; 

    END IF;


 
    IF CMD = 'REDUCE_DIFF' THEN

        SELECT JSON_EXTRACT(JA, CONCAT('$[0]')) INTO J5  
        FROM Cyber_Lock.CyberMatrix
        WHERE JPK = IndiceA;

        SET J = JSON_ARRAY();

        IF JSON_LENGTH(J5) %2 = 0 THEN

            SET I = 0;

            WHILE I < JSON_LENGTH(J5) DO

                SET I2 = 0;
        
                SET J2 = JSON_ARRAY();

                WHILE I2 < JSON_LENGTH(J5) DO

                    SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I2,']')) INTO Result  
                    FROM Cyber_Lock.CyberMatrix
                    WHERE JPK = IndiceA;

                    SELECT JSON_EXTRACT(JA, CONCAT('$[',I + 1,']', '[',I2,']')) INTO Result2  
                    FROM Cyber_Lock.CyberMatrix
                    WHERE JPK = IndiceA;

                    SET J2 = JSON_ARRAY_INSERT(J2, CONCAT('$[',I2,']'), ABS(Result - Result2));
    
                    SET I2 = I2 + 1;

                END WHILE;

                SET J = JSON_ARRAY_INSERT(J, CONCAT('$[',I2,']'), J2);
                SET I = I + 2;

            END WHILE;

        END IF;

        SELECT J AS 'REDUCE_DIFF'; 
    
    END IF;
    

    IF CMD = 'DISTANCE' THEN

        SELECT JSON_EXTRACT(JA, CONCAT('$[0]')) INTO J5  
        FROM Cyber_Lock.CyberMatrix
        WHERE JPK = IndiceA;

        SET J = JSON_ARRAY();

        IF JSON_LENGTH(J5) %2 = 0 THEN

            SET I = 0;

            WHILE I < JSON_LENGTH(J5) DO

                SET I2 = 0;
        
                SET J3 = 0;

                WHILE I2 < JSON_LENGTH(J5) DO

                    SELECT JSON_EXTRACT(JA, CONCAT('$[',I,']', '[',I2,']')) INTO Result  
                    FROM Cyber_Lock.CyberMatrix
                    WHERE JPK = IndiceA;

                    SELECT JSON_EXTRACT(JA, CONCAT('$[',I + 1,']', '[',I2,']')) INTO Result2  
                    FROM Cyber_Lock.CyberMatrix
                    WHERE JPK = IndiceA;

                    
                    SET J3 = J3 + POW(ABS(Result - Result2), 2);
                    SET I2 = I2 + 1;

                END WHILE;

                SET J = JSON_ARRAY_INSERT(J, CONCAT('$[',I2,']'), CONVERT(FLOOR(SQRT(J3)),DECIMAL(3,0)));
                SET I = I + 2;

            END WHILE;

        END IF;

        SELECT J AS 'DISTANCE';


    END IF;
    
    
END //
DELIMITER ;
CALL CypherMatrixSolver('ADD', 1, 2);    # Add the first and the second matrixes 5 x 5
CALL CypherMatrixSolver('ADD', 6, 7);       # Add the sixth and the seventh matrixes 4 x 4
CALL CypherMatrixSolver('SUM_COLUMN', 1, 2);  #  matrixes 5 x 5
CALL CypherMatrixSolver('SUM_COLUMN', 6, 2);  # matrixes 4 x 4
CALL CypherMatrixSolver('SUM_ROW', 1, 2);  # matrixes 5 x 5
CALL CypherMatrixSolver('SUM_ROW', 6, 2);  # matrixes 4 x 4
CALL CypherMatrixSolver('SUM_DIAGONAL', 1, 2);  # matrixes 5 x 5
CALL CypherMatrixSolver('SUM_DIAGONAL', 6, 2);  # matrixes 4 x 4
CALL CypherMatrixSolver('REORDER_EVEN', 1, 2);  # matrixes 5 x 5
CALL CypherMatrixSolver('REORDER_EVEN', 6, 2);  # matrixes 4 x 4
CALL CypherMatrixSolver('REORDER_ODD', 1, 2);  # matrixes 5 x 5
CALL CypherMatrixSolver('REORDER_ODD', 6, 2);  # matrixes 4 x 4
CALL CypherMatrixSolver('FLATTEN', 1, 2);  # matrixes 5 x 5
CALL CypherMatrixSolver('FLATTEN', 6, 2);  # matrixes 4 x 4
CALL CypherMatrixSolver('REDUCE_SUM', 6, 2);  # matrixes 4 x 4
CALL CypherMatrixSolver('REDUCE_DIFF', 6, 2);  # matrixes 4 x 4
CALL CypherMatrixSolver('DISTANCE', 6, 2);  # matrixes 4 x 4
  


