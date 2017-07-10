CREATE TABLE survey_ratings_transform
AS SELECT
    Provider_ID,
    HCAHPS_Measure_ID,
    Patient_Survey_Star_Rating
FROM star_ratings
WHERE UPPER(HCAHPS_Answer_Description) LIKE '%SUMMARY%' AND
    NOT Patient_Survey_Star_Rating = 'Not Available';
