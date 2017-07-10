CREATE TABLE procedures_transform
AS SELECT
    Provider_ID,
    Measure_ID,
    Measure_Name,
    Score,
    CASE
        WHEN Measure_ID = 'VTE_6' OR Measure_ID = 'PC_01' THEN (100 - Score)
        WHEN Score = 'Not Available' THEN 0
        ELSE Score
        END AS Adj_Score
FROM effective_care
WHERE
    NOT Condition = 'Emergency Department' AND
    NOT Measure_Name LIKE '%Median%';

CREATE TABLE readmissions_transform
AS SELECT
    Provider_ID,
    Measure_ID,
    Measure_Name,
    Score,
    CASE
        WHEN Score = 'Not Available' THEN 0
        ELSE (100 - Score)
        END AS Adj_Score
FROM readmissions
ORDER BY Provider_ID;

INSERT INTO TABLE procedures_transform
SELECT
    Provider_ID,
    Measure_ID,
    Measure_Name,
    Score,
    Adj_Score
FROM readmissions_transform;
