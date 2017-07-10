CREATE TABLE best_hospitals_tmp
AS SELECT
    Provider_ID,
    AVG(Adj_Score) AS Procedure_Average,
    STDDEV_POP(Adj_Score) AS Procedure_Variability
FROM procedures_transform
GROUP BY Provider_ID;

CREATE TABLE stats_tmp
AS SELECT
    AVG(Procedure_Variability) AS Procedure_Variability_Avg
FROM best_hospitals_tmp;

CREATE TABLE best_hospitals_cross
AS SELECT * FROM best_hospitals_tmp CROSS JOIN stats_tmp;

CREATE TABLE best_hospitals_scoring
AS SELECT
    Provider_ID,
    Procedure_Average,
    Procedure_Variability,
    (Procedure_Variability/Procedure_Variability_Avg) AS Variability_Delta,
    (Procedure_Average/(Procedure_Variability/Procedure_Variability_Avg)) AS Quality_Score
FROM best_hospitals_cross;

CREATE TABLE best_hospitals_output
AS SELECT
    best_hospitals_scoring.Provider_ID,
    hosp_transform.hospital_name,
    hosp_transform.state,
    best_hospitals_scoring.Procedure_Average,
    best_hospitals_scoring.Procedure_Variability,
    best_hospitals_scoring.Variability_Delta,
    best_hospitals_scoring.Quality_Score
FROM best_hospitals_scoring
LEFT OUTER JOIN hosp_transform
ON best_hospitals_scoring.Provider_ID = hosp_transform.provider_id
ORDER BY best_hospitals_scoring.Quality_Score DESC
LIMIT 10;

DROP TABLE best_hospitals_tmp;
DROP TABLE stats_tmp;
DROP TABLE best_hospitals_cross;
