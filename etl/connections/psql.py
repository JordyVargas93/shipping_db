import configparser
import os
import pandas as pd
import psycopg2


class Psql:

    def __init__(self):
        self.config = configparser.ConfigParser()
        self.config.read('../config/psql.ini')

    def get_result_set(self, sql, **params):
        success = False
        attempts = 10

        while not success and attempts > 0:
            try:
                # Create a database connection
                conn = psycopg2.connect(
                    database=self.config['configuration']['database'],
                    host=self.config['configuration']['host'],
                    user=self.config['configuration']['user'],
                    password=self.config['configuration']['password'],
                    port=self.config['configuration']['port'],
                )
                # Get SQL query
                query = self.__get_sql_query(sql, **params)
                result_set = pd.read_sql_query(
                    query,
                    conn
                )
                # Close the connection and tunnel
                conn.close()
                success = True

                return result_set
            except Exception as error:
                print('Exception in connection or database. \n' + str(error))

            attempts -= 1

    def __get_sql_query(self, sql, **params):
        file = open('../sql/' + sql + '.sql', 'r')
        sql_query = " ".join(file.readlines())

        if params is not None:
            sql_query = sql_query.format(**params)

        return sql_query

    def save_data(self, data, table):
        success = False
        attempts = 10

        while not success and attempts > 0:
            try:
                # Create a database connection
                conn = psycopg2.connect(
                    database=self.config['configuration']['database'],
                    host=self.config['configuration']['host'],
                    user=self.config['configuration']['user'],
                    password=self.config['configuration']['password'],
                    port=self.config['configuration']['port'],
                )
                from sqlalchemy import create_engine
                engine = create_engine(
                    'postgresql+psycopg2://' +
                    self.config['configuration']['user'] + ':' +
                    self.config['configuration']['password'] + '@' +
                    self.config['configuration']['host'] + ':' +
                    self.config['configuration']['port'] + '/' +
                    self.config['configuration']['database']
                )
                # Save data
                data.to_sql(table,
                            schema='shipping_db',
                            con=engine,
                            if_exists='replace',
                            index=False)
                # Close the connection and tunnel
                conn.close()
                success = True

                return
            except Exception as error:
                print('Exception in connection or database. \n' + str(error))

            attempts -= 1
