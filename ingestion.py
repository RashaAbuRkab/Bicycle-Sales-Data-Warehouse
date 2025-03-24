#!/usr/bin/env python
# coding: utf-8

# In[11]:


import pandas as pd
import psycopg2
from psycopg2 import sql
import os

DB_HOST = "localhost"
DB_NAME = "Bicycle_Sales"
DB_USER = "postgres"
DB_PASSWORD = "123456"
DB_PORT = "5432"

def connect_db():
    try:
        # Establish the connection to the database
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, host=DB_HOST, port=DB_PORT)
        print("Connection successful")
        return conn
    except Exception as e:
        print(f"Error connecting to database: {e}")
        return None

def preprocess_csv_data(df):
    # Remove BOM (Byte Order Mark) if it exists
    if df.columns[0].startswith('\ufeff'):
        df.columns = df.columns.str.lstrip('\ufeff')
    return df

def load_csv_to_postgres(file_path, table_name, schema="raw_data"):
    # Check if the file exists
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        return
    
    try:
        # Read the CSV file with utf-8-sig encoding to handle BOM properly
        df = pd.read_csv(file_path, encoding='utf-8-sig')  # Change encoding here
        
        # Preprocess the data before loading it
        df = preprocess_csv_data(df)
        
        # Connect to the database
        conn = connect_db()
        if not conn:
            return
        
        cur = conn.cursor()
        full_table_name = f"{schema}.{table_name}"
        
        # Check if the table exists in the database
        check_table_query = sql.SQL("SELECT to_regclass({})").format(sql.Literal(full_table_name))
        cur.execute(check_table_query)
        result = cur.fetchone()
        
        if result[0] is None:
            print(f"Table {full_table_name} does not exist in the database.")
            return
        
        # Insert the data into the table
        for index, row in df.iterrows():
            columns = ', '.join(df.columns)
            values_placeholders = ', '.join(['%s'] * len(row))
            insert_query = f"INSERT INTO {full_table_name} ({columns}) VALUES ({values_placeholders})"
            
            try:
                cur.execute(insert_query, tuple(row))
            except Exception as e:
                print(f"Error inserting row {index + 1}: {e}")
                conn.rollback()
                continue
        
        conn.commit()
        print(f"Data from {file_path} loaded into {full_table_name} successfully.")
    
    except Exception as e:
        print(f"Error processing file {file_path}: {e}")
    
    finally:
        if 'conn' in locals() and conn:
            cur.close()
            conn.close()

# List of files to load
files = [
    ("C:\\Users\\pc\\Downloads\\raw_data\\brands.csv", "Brands"),
    ("C:\\Users\\pc\\Downloads\\raw_data\\categories.csv", "Categories"),
    ("C:\\Users\\pc\\Downloads\\raw_data\\products.csv", "Products"),
    ("C:\\Users\\pc\\Downloads\\raw_data\\stores.csv", "Stores"),
    ("C:\\Users\\pc\\Downloads\\raw_data\\staffs.csv", "Staffs"),
    ("C:\\Users\\pc\\Downloads\\raw_data\\stocks.csv", "Stocks"),
    ("C:\\Users\\pc\\Downloads\\raw_data\\customers.csv", "Customers"),
    ("C:\\Users\\pc\\Downloads\\raw_data\\orders.csv", "Orders")
]

# Load data from CSV files to PostgreSQL
for file_path, table_name in files:
    load_csv_to_postgres(file_path, table_name, schema="raw_data")

