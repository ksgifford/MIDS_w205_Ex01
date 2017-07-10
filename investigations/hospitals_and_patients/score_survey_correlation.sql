CREATE TABLE hospital_quality_tmp
AS SELECT
    Provider_ID,
    AVG(Adj_Score) AS Procedure_Average,
    STDDEV_POP(Adj_Score) AS Procedure_Variability
FROM procedures_transform
GROUP BY Provider_ID;

CREATE TABLE hospital_survey_join
AS SELECT
    hospital_quality_tmp.Provider_ID,
    hospital_quality_tmp.Procedure_Average,
    hospital_quality_tmp.Procedure_Variability,
    CAST(survey_ratings_transform.Patient_Survey_Star_Rating AS INT) AS Patient_Survey_Star_Rating
FROM hospital_quality_tmp
INNER JOIN survey_ratings_transform
ON hospital_quality_tmp.Provider_ID = survey_ratings_transform.Provider_ID;

CREATE TABLE hospital_survey_correlation
AS SELECT
    (CORR(Procedure_Average, Patient_Survey_Star_Rating)) AS Procedure_Correlation,
    (CORR(Procedure_Variability, Patient_Survey_Star_Rating)) AS Variability_Correlation
FROM hospital_survey_join;

DROP TABLE hospital_quality_tmp;
