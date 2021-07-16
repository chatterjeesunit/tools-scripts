DROP TABLE IF EXISTS employee_data;

CREATE TABLE employee_data (
  id 		SERIAL primary key,
  name 	varchar(255) NOT NULL,
  city 		varchar(255) NOT NULL,
  state 	char(2) NOT NULL,
  joining_date	 date NOT NULL,
  review_score 	decimal(4,2) NOT NULL
);
