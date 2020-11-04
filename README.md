# shipping_db
### Database (PostgreSQL) 

- In a PostgreSQL server/instance run [DDL file](https://github.com/JordyVargas93/shipping_db/blob/main/database-model/shipping_db_ddl.sql). 
- Once, the schema and the tables are created, you can run the [test data](https://github.com/JordyVargas93/shipping_db/blob/main/database-model/test_data.sql) file.
- The entity-relation model of the database is described below:



![](database-model/er_diagram.png)

### ETLs (Python)

- You can find the code of the ETLs [here](https://github.com/JordyVargas93/shipping_db/tree/main/etl)

- **Requirements**

  - Python 3
  - Install the [requirements](https://github.com/JordyVargas93/shipping_db/blob/main/etl/requirements.txt) with *pip*
    > pip install -r requirements.txt
  - Add your PostgreSQL credentials in the [config file](https://github.com/JordyVargas93/shipping_db/blob/main/etl/config/psql.ini)
  
- Run it!
  - Go to etl/src
  - Use the *etl* param to indicate the ETL to execute:
  
  > python run.py --etl=routes_recurrency
  
  > python run.py --etl=routes_time
  
  > python run.py --etl=status_time

- Aggregated tables:
  - You can find [example queries](https://github.com/JordyVargas93/shipping_db/blob/main/sql/analysis.sql) for analysis using aggregated tables and dimensions: origin, destination, package_type and shipment_type
