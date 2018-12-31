CREATE TABLE PROJECT2.MALE_EMPLOYMENT_TRANSPOSED (CountryName varchar(50), IndicatorCode varchar(30), YearsByCountry INTEGER, DATA FLOAT );

DELIMITER $$
CREATE PROCEDURE PROJECT2.MALE_EMPLOYMENT_TRANSPOSED(MIN_VALUE INTEGER, MAX_VALUE INTEGER)
BEGIN

DECLARE YEAR INTEGER;
DECLARE COLNAME varchar(50);
SET YEAR = MIN_VALUE;

WHILE YEAR <= MAX_VALUE 
DO

SET @COLNAME = CONCAT('`',YEAR,'`');
SET @STATEMENT = CONCAT(
    'INSERT INTO PROJECT2.MALE_EMPLOYMENT_TRANSPOSED (CountryName, IndicatorCode, YearsByCountry, Data)',
    ' SELECT CountryName, IndicatorCode, ', YEAR,',', @COLNAME,
    ' FROM PROJECT2.gender_data2',
    ' WHERE ', @COLNAME,
    ' IS NOT NULL'
);

PREPARE STMT FROM @STATEMENT;
EXECUTE STMT;
DEALLOCATE PREPARE STMT;

SET YEAR = YEAR + 1;
END WHILE;
END$$
DELIMITER ;

CALL PROJECT2.MALE_EMPLOYMENT_TRANSPOSED(2010,2016);



CREATE VIEW Q3_MALE_EMP AS
SELECT CountryName, IndicatorCode, YearsByCountry, Data
FROM MALE_EMPLOYMENT_TRANSPOSED
WHERE IndicatorCode = 'SL.EMP.SELF.MA.ZS';