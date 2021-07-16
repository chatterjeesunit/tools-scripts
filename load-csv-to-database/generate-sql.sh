#!/bin/bash

export headers=`head -n 1 sample.csv`
# echo "Header Columns = $headers"
IFS=','

echo
if [ $# -lt 3 ]
  then
    echo "Please provide csv file name as input. "
    echo "sh generate-sql.sh <csv-file> <destination-table-name> <comma-separated-list-columns"
    echo "sh generate-sql.sh sample.csv employee_data name,city,state,joining_date,review_score"
    exit 0
fi

header_count=0
echo "CSV Header Fields"
echo ---------------------------------
read -ra arr <<< "$headers"
for val in "${arr[@]}";
do
  printf "$val\n"
  header_count=$((header_count+1));
done
echo ---------------------------------
echo "Total CSV Header fields = $header_count"
echo ---------------------------------
echo

echo "Database column fields"
echo ---------------------------------

column_count=0
read -ra arr <<< "$3"
for val in "${arr[@]}";
do
  printf "$val\n"
  column_count=$((column_count+1));
done
echo ---------------------------------
echo "Total Database column count = $column_count"
echo ---------------------------------
echo

if [ $header_count -ne $column_count ]
  then
    echo "Database column counts do not match with CSV header field counts"
    exit 0
fi


export csv_file_name=$1
export destination_table=$2
export table_columns=$3
export final_sql_file_name=insert.sql

#cleanup
rm -f tmp*
rm -f $final_sql_file_name

# Add insert statement to final script
echo "INSERT INTO $destination_table \n($table_columns) \nVALUES" >> $final_sql_file_name

echo "Removing CRLF from input"
# Remove CRLF from the CSV file
# awk 'gsub(/\r/,"")' $csv_file_name > tmp1.csv
sed $'s/\r$//' $csv_file_name > tmp1.csv

echo "Removing header from input"
# Remove header line from the csv file
tail -n +2 tmp1.csv > tmp2.csv


# Generate insert values from the CSV 
# awk -F, '{ print "('\''"$1"'\'', '\''"$2"'\'', '\''"$3"'\'', '\''"$4"'\'', '\''"$5"'\'' )" }' tmp2.csv > tmp3
# Add comma at end of all lines except last line
# sed '$!s/$/,/' tmp3 > tmp4
# Add semicolon to terminate insert sql
# echo ";" >> tmp4

echo "Running awk script to generate sql"
awk -f csv-sql.awk tmp2.csv > tmp4


# Add insert sql to final sql script
cat tmp4 >> $final_sql_file_name

echo "Final script created - $final_sql_file_name"
#cleanup
rm -f tmp*