## Converting a sample csv to sql insert statements

This will be helpful to load the csv data into a database
 - Create table script to create the sample table for testing - [MySQL](create-table-myssql) / [PostgreSQL](create-table-postgres.sql).  Run this sql if you want to create the table for testing purpose.
 - [Sample CSV file](`sample.csv`)
 - Run command `sh generate-sql.sh`
 - This will convert `sample.csv` into a SQL file `insert.sql`
 - Run `insert.sql` agains your database to load the data from CSV
 - Support added for String, date, decimals, etc.
 - Date needs to be in `YYYY-MM-DD` format

## Future optimizations
 - Add support for dynamic convertion - read csv and dynamically generate the columns in the sql script. Currently it is hardcoded for the 5 columns of the `sample.csv`
 - Add support for `NULL` values
