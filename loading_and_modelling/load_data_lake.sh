#Stripping headers from CSV files. I created a directory under the w205 user at
#home/w205/w205-3/exercise_1/hospitals_raw to store the raw CSV tables, which I
#uploaded from my laptop. From here, I created a subdirectory to hold the headerless
#CSV files called /noheader.

mkdir ./w205-3/exercise_1/hospitals_raw/noheader
cd ./w205-3/exercise_1/hospitals_raw

tail -n +2 ./effective_care.csv > ./noheader/effective_care_noHead.csv
tail -n +2 ./hospitals.csv > ./noheader/hospitals_noHead.csv
tail -n +2 ./readmissions.csv > ./noheader/readmissions_noHead.csv
tail -n +2 ./survey_responses.csv > ./noheader/survey_responses_noHead.csv
tail -n +2 ./star_ratings.csv > ./noheader/star_ratings_noHead.csv

#Loading stripped CSV files into HDFS
hdfs dfs -mkdir hospital_compare
hdfs dfs -mkdir hospital_compare/effective_care
hdfs dfs -put /home/w205/w205-3/exercise_1/hospitals_raw/noheader/effective_care_noHead.csv /user/w205/hospital_compare/effective_care

hdfs dfs -mkdir hospital_compare/hospitals
hdfs dfs -put /home/w205/w205-3/exercise_1/hospitals_raw/noheader/hospitals_noHead.csv /user/w205/hospital_compare/hospitals

hdfs dfs -mkdir hospital_compare/readmissions
hdfs dfs -put /home/w205/w205-3/exercise_1/hospitals_raw/noheader/readmissions_noHead.csv /user/w205/hospital_compare/readmissions

hdfs dfs -mkdir hospital_compare/survey_responses
hdfs dfs -put /home/w205/w205-3/exercise_1/hospitals_raw/noheader/survey_responses_noHead.csv /user/w205/hospital_compare/survey_responses

hdfs dfs -mkdir hospital_compare/star_ratings
hdfs dfs -put /home/w205/w205-3/exercise_1/hospitals_raw/noheader/star_ratings_noHead.csv /user/w205/hospital_compare/star_ratings
