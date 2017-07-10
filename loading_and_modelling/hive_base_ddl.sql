DROP TABLE effective_care;
CREATE EXTERNAL TABLE effective_care
(
    Provider_ID INT,
    Hospital_Name STRING,
    Address STRING,
    City STRING,
    State STRING,
    ZIP_Code INT,
    County_Name STRING,
    Phone_Number INT,
    Condition STRING,
    Measure_ID STRING,
    Measure_Name STRING,
    Score FLOAT,
    Sample STRING,
    Footnote STRING,
    Measure_Start_Date STRING,
    Measure_End_Date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

DROP TABLE hospitals;
CREATE EXTERNAL TABLE hospitals
(
    Provider_ID INT,
    Hospital_Name STRING,
    Address STRING,
    City STRING,
    State STRING,
    ZIP_Code INT,
    County_Name STRING,
    Phone_Number INT,
    Hospital_Type STRING,
    Hospital_Ownership STRING,
    Emergency_Services STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';

DROP TABLE readmissions;
CREATE EXTERNAL TABLE readmissions
(
    Provider_ID INT,
    Hospital_Name STRING,
    Address STRING,
    City STRING,
    State STRING,
    ZIP_Code INT,
    County_Name STRING,
    Phone_Number INT,
    Measure_Name STRING,
    Measure_ID STRING,
    Compared_to_National STRING,
    Denominator INT,
    Score FLOAT,
    Lower_Estimate FLOAT,
    Higher_Estimate FLOAT,
    Footnote STRING,
    Measure_Start_Date STRING,
    Measure_End_Date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';

DROP TABLE star_ratings;
CREATE EXTERNAL TABLE star_ratings
(
    Provider_ID INT,
    Hospital_Name STRING,
    Address STRING,
    City STRING,
    State STRING,
    ZIP_Code INT,
    County_Name STRING,
    Phone_Number INT,
    HCAHPS_Measure_ID STRING,
    HCAHPS_Question STRING,
    HCAHPS_Answer_Description STRING,
    Patient_Survey_Star_Rating INT,
    Patient_Survey_Star_Rating_Footnote STRING,
    HCAHPS_Answer_Percent FLOAT,
    HCAHPS_Answer_Percent_Footnote STRING,
    Number_of_Completed_Surveys INT,
    Number_of_Completed_Surveys_Footnote STRING,
    Survey_Response_Rate_Percent FLOAT,
    Survey_Response_Rate_Percent_Footnote STRING,
    Measure_Start_Date STRING,
    Measure_End_Date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/star_ratings';
