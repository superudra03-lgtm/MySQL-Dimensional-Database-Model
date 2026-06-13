This project is based on the work for the star relational schema I created. 

1) I put typical data sources defined in MySQL. Making sure to store the two data sources in two separate databases. These two databases will serve as an operational database. 

2) Using the dimensional model, I built a data warehouse in MySQL in a separate database. I made sure to show the SQL code for building both the dimensional and fact tables. Additionally, I showed the SQL code to insert data from the two aforementioned data sources into the data warehouse.

So, in total, I created three databases: 
1. Big Z Inc. Order Database: This is an operational database that is designed to keep track of orders.
2. Human Resources Database: This is an operational database that contains a single table that keeps track of employee data
3. Big Z Data Warehouse is the analytical database, which will receive data from the two data sources detailed above. 
