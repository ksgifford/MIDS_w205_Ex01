CREATE TABLE best_states_join
AS SELECT
    procedures_transform.Provider_ID,
    hosp_transform.hospital_name AS Hospital_Name,
    hosp_transform.state AS State,
    procedures_transform.Measure_ID,
    procedures_transform.Measure_Name,
    procedures_transform.Adj_Score
FROM procedures_transform
INNER JOIN hosp_transform
ON procedures_transform.Provider_ID = hosp_transform.provider_id;

CREATE TABLE best_states_tmp
AS SELECT
    State,
    AVG(Adj_Score) AS State_Average,
    STDDEV_POP(Adj_Score) AS State_Variability
FROM best_states_join
GROUP BY State;

CREATE TABLE stats_tmp
AS SELECT
    AVG(State_Variability) AS State_Variability_Avg
FROM best_states_tmp;

CREATE TABLE best_states_cross
AS SELECT * FROM best_states_tmp CROSS JOIN stats_tmp;

CREATE TABLE best_states_output
AS SELECT
    State,
    State_Average,
    State_Variability,
    (State_Variability/State_Variability_Avg) AS Variability_Delta,
    (State_Average/(State_Variability/State_Variability_Avg)) AS Quality_Score
FROM best_states_cross
ORDER BY Quality_Score DESC
LIMIT 10;

DROP TABLE best_states_join;
DROP TABLE best_states_tmp;
DROP TABLE stats_tmp;
DROP TABLE best_states_cross;
