import os
import snowflake.connector
import pandas as pd
from dotenv import load_dotenv

def query_housing_prices(query= 'select * from mart_housing_prices'):
    load_dotenv()
    
    with snowflake.connector.connect(
        user=os.getenv("SNOWFLAKE_USER"),
        password=os.getenv("SNOWFLAKE_PASSWORD"),
        account=os.getenv("SNOWFLAKE_ACCOUNT"),
        warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
        database=os.getenv("SNOWFLAKE_DATABASE"),
        schema=os.getenv("SNOWFLAKE_SCHEMA"),
        role=os.getenv("SNOWFLAKE_ROLE"),
    ) as conn:

        df = pd.read_sql(query, conn)

        return df

