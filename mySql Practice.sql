USE school

CREATE TABLE parents(nic INT (6),NAMES VARCHAR (30),Job CHAR (20));

INSERT INTO parents VALUES(1,'abc','manager'),(2,'def','notman'),(3,'ghi','clerk'),(4,'jkl','sports');

SELECT CHAR_LENGTH(NAME) FROM students LIMIT 1 #character Length

SELECT NAME, INSTR(NAME,gender) FROM students #same count

SELECT NAME,STRCMP(NAME,gender) FROM students #compare less= -1 , 0=0, greater = 1

SELECT CONCAT(NAME," EMAIL = ",email) FROM students #concatination

SELECT REVERSE(NAME) FROM students #reverse

SELECT LEFT(NAME,4) FROM students #4 from lest side

SELECT RIGHT(NAME,4) FROM students #4 from right side

SELECT LOWER(NAME) FROM students #Lower case

SELECT UPPER(NAME) FROM students# upper case

SELECT LPAD(NAME,8,".") FROM students# add . to left

SELECT RPAD(NAME,8,".") FROM students#add . to right

SELECT TRIM(NAME) FROM students #trim spaces

SELECT TRIM(LEADING 'a' FROM NAME) FROM students #trim all a from begining

SELECT SUBSTRING(NAME, 3) FROM students #start selecting from third onward

SELECT SUBSTRING(NAME, 2,1) FROM students#start from 2 inclusive

SELECT SUBSTRING_INDEX(email,'@',1) FROM students#divide select from left

SELECT SUBSTRING_INDEX(email,'@',-1) FROM students# divide select from right

SELECT ABS(phone_no) FROM students#absolute

SELECT SIGN(phone_no) FROM students # -1 for negative ,, 1 for positive,, 0 for zero

SELECT IF(1>0,'yes','no') AS con

SELECT NAME,gender,
CASE WHEN gender='m' THEN 'boy'
WHEN gender ='f' THEN 'girl'
ELSE 'unknown'
END AS 'gender2.0'
FROM students

SELECT NAME,gender,age
FROM students HAVING gender='f'

SELECT NAME,gender FROM students WHERE age IN (20,19)

SELECT NAME,age FROM students WHERE gender = 'm'

SELECT NAME,age FROM students WHERE age BETWEEN 10 AND 20

SELECT NAME,age FROM students WHERE age < (SELECT AVG(age) FROM students ) LIMIT 1

DELETE FROM parents WHERE nic = 4

USE school

DELIMITER #
CREATE PROCEDURE all_data()
BEGIN
SELECT * FROM students;
END #
DELIMITER ;

CALL all_data();


DELIMITER //
CREATE PROCEDURE NAME(IN a VARCHAR (20))
BEGIN
SELECT NAME,age,gender FROM students WHERE NAME = a;
END

CALL NAME("azhar")

DELIMITER //
CREATE PROCEDURE DATA(IN a INT (20),IN b INT (20))
BEGIN
SELECT * FROM students WHERE age BETWEEN a AND b;
END //

CALL DATA(10,20)



DELIMITER $$
 
DROP PROCEDURE IF EXISTS sp_nested_loop$$
CREATE PROCEDURE sp_nested_loop(IN i INT, IN j INT, OUT X INT, OUT Y INT, INOUT z INT)
BEGIN
    DECLARE a INTEGER DEFAULT 0;
    DECLARE b INTEGER DEFAULT 0;
    DECLARE c INTEGER DEFAULT 0;
    WHILE a < i DO
        WHILE b < j DO
            SET c = c + 1;
            SET b = b + 1;
        END WHILE;    
        SET a = a + 1;
        SET b = 0;        
    END WHILE;
    SET X = a, Y = c;
    SET z = X + Y + z;
END $$
DELIMITER ;

SET @z = 30;
CALL sp_nested_loop(10, 20, @x, @y, @z);
SELECT @x, @y, @z;


ALTER TABLE parents ADD FOREIGN KEY(nic) REFERENCES students(id)

SELECT students.id,parents.names FROM students LEFT JOIN parents ON students.id = parents.nic;

SELECT students.id,parents.names FROM students RIGHT JOIN parents ON students.id = parents.nic;


SELECT a.name,b.NAmes FROM students AS a INNER JOIN  parents AS b ON a.id = b.nic
UNION ALL 
SELECT  a.id,b.names FROM students AS a LEFT JOIN parents AS b ON a.id = b.nic;

SELECT id,NAME FROM students 
UNION ALL
SELECT nic,NAMES FROM parents;


SELECT NAME,SUM(gender)AS gender,SUM(age) AS age,SUM(phone_no) AS p_no
FROM students GROUP BY NAME WITH ROLLUP


USE lab10

SELECT NAME,job,dept,AVG(salary) AS salary FROM employee GROUP BY NAME WITH ROLLUP


SELECT CURDATE(),CURTIME(),YEAR(NOW()),DAY(NOW()),DAYNAME(NOW()),TIME(NOW());

SELECT DAYNAME('1999-8-10')

SELECT ADDDATE('2004-10-01',15);

SELECT SUBDATE('2004-10-01',15)

SELECT DATE_ADD('1992-12-31 23:59:59.000002',INTERVAL '1.999999' SECOND_MICROSECOND)

SELECT NOW(), DATE_FORMAT(NOW(), '%W the %D of %M')

SELECT FLOOR(3.6)

SELECT CEIL(3.6)

SELECT ROUND (2.123)

SELECT SIGN(-41),SIGN(41),SIGN(1-1)

SELECT NAME,age,GROUP_CONCAT(email)  FROM students GROUP BY id


USE lab10

SELECT NAME,SUM(salary),AVG(salary) FROM employee GROUP BY id WITH ROLLUP

SELECT SUM(69 * 69)

SELECT ABS(PI())