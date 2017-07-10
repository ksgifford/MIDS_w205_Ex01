CREATE TABLE procedures_variability
AS SELECT
    Measure_ID,
    Measure_Name,
    AVG(Adj_Score) AS Procedure_Average,
    STDDEV_POP(Adj_Score) AS Procedure_Variability
FROM procedures_transform
WHERE NOT Score = 'Not Available'
GROUP BY Measure_ID, Measure_Name
ORDER BY Procedure_Variability DESC
LIMIT 10;
