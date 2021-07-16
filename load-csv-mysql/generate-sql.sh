#!/bin/sh

export csv_file_name=sample.csv

#cleanup
rm -f tmp*
rm -f insert.sql

# Add insert statement to final script
echo "INSERT INTO employee_data (name, city, state, joining_date, review_score) \n VALUES" >> insert.sql

# Remove CRLF from the CSV file
# awk 'gsub(/\r/,"")' sample.csv > tmp1.csv
sed $'s/\r$//' $csv_file_name > tmp1.csv

# Remove header line from the csv file
tail -n +2 tmp1.csv > tmp2.csv


# Generate insert values from the CSV 
awk -F, '{ print "('\''"$1"'\'', '\''"$2"'\'', '\''"$3"'\'', '\''"$4"'\'', '\''"$5"'\'' )" }' tmp2.csv > tmp3

# Add comma at end of all lines except last line
sed '$!s/$/,/' tmp3 > tmp4

# Add semicolon to terminate insert sql
echo ";" >> tmp4

# Add insert sql to final sql script
cat tmp4 >> insert.sql

#cleanup
rm -f tmp*