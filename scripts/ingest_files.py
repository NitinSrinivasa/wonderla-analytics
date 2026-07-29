import os
from pathlib import Path

import snowflake.connector
from dotenv import load_dotenv


BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR / "data"

load_dotenv(BASE_DIR / ".env")


FILES = {
    "customer_feedbacks.csv": "CUSTOMER_FEEDBACKS",
    "rides.csv": "RIDES",
    "ops_rides.csv": "OPS_RIDES",
    "marketing_rides.csv": "MARKETING_RIDES",
    "ticket_types.csv": "TICKET_TYPES",
    "merchandise_products.csv": "MERCHANDISE_PRODUCTS",
    "weather_data.csv": "WEATHER_DATA",
    "checkins.csv": "CHECKINS",
    "safety_incidents.csv": "SAFETY_INCIDENTS",
    "electricity_costs.csv": "ELECTRICITY_COSTS",
    "maintenance_costs.csv": "MAINTENANCE_COSTS",
    "staff_costs.csv": "STAFF_COSTS",
    "supplies_costs.csv": "SUPPLIES_COSTS",
}


def connect_to_snowflake():
    return snowflake.connector.connect(
        user=os.getenv("SNOWFLAKE_USER"),
        password=os.getenv("SNOWFLAKE_PASSWORD"),
        account=os.getenv("SNOWFLAKE_ACCOUNT"),
        warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
        database=os.getenv("SNOWFLAKE_DATABASE"),
        role=os.getenv("SNOWFLAKE_ROLE"),
    )


def find_table_schema(cursor, database_name, table_name):
    cursor.execute(f"SHOW TABLES LIKE '{table_name}' IN DATABASE {database_name}")
    results = cursor.fetchall()

    if not results:
        raise RuntimeError(
            f"Could not find table {table_name} anywhere in {database_name}."
        )

    # SHOW TABLES returns the schema name in column index 3.
    exact_matches = [
        row for row in results
        if str(row[1]).upper() == table_name.upper()
    ]

    if not exact_matches:
        raise RuntimeError(
            f"Could not find an exact match for table {table_name}."
        )

    if len(exact_matches) > 1:
        schemas = [str(row[3]) for row in exact_matches]
        raise RuntimeError(
            f"Table {table_name} exists in multiple schemas: {schemas}"
        )

    return str(exact_matches[0][3])


def load_csv(cursor, database_name, file_name, table_name):
    file_path = DATA_DIR / file_name

    if not file_path.exists():
        raise FileNotFoundError(f"Missing CSV file: {file_path}")

    schema_name = find_table_schema(
        cursor=cursor,
        database_name=database_name,
        table_name=table_name,
    )

    full_table_name = (
        f'"{database_name}"."{schema_name}"."{table_name}"'
    )

    print()
    print(f"Loading {file_name}")
    print(f"Target: {full_table_name}")

    # Set the current schema because @%TABLE_NAME refers to the table stage
    # in the current database and schema.
    cursor.execute(
        f'USE SCHEMA "{database_name}"."{schema_name}"'
    )

    cursor.execute(f'TRUNCATE TABLE "{table_name}"')

    cursor.execute(
        f"""
        PUT 'file://{file_path}'
        @%"{table_name}"
        AUTO_COMPRESS=TRUE
        OVERWRITE=TRUE
        """
    )

    cursor.execute(
        f"""
        COPY INTO "{table_name}"
        FROM @%"{table_name}"
        FILE_FORMAT=(
            TYPE=CSV
            SKIP_HEADER=1
            FIELD_OPTIONALLY_ENCLOSED_BY='"'
            EMPTY_FIELD_AS_NULL=TRUE
        )
        ON_ERROR='ABORT_STATEMENT'
        PURGE=TRUE
        """
    )

    cursor.execute(f'SELECT COUNT(*) FROM "{table_name}"')
    row_count = cursor.fetchone()[0]

    print(f"Success: {full_table_name} has {row_count} rows.")


def main():
    database_name = os.getenv("SNOWFLAKE_DATABASE")

    if not database_name:
        raise ValueError("SNOWFLAKE_DATABASE is missing from .env")

    connection = None
    cursor = None
    successful = []
    failed = []

    try:
        connection = connect_to_snowflake()
        cursor = connection.cursor()

        print("Connected to Snowflake.")
        print(f"Database: {database_name}")

        for file_name, table_name in FILES.items():
            try:
                load_csv(
                    cursor=cursor,
                    database_name=database_name,
                    file_name=file_name,
                    table_name=table_name,
                )
                successful.append(table_name)

            except Exception as error:
                print(f"Failed: {file_name}")
                print(error)
                failed.append((file_name, str(error)))

        print()
        print("=" * 50)
        print("PYTHON INGESTION SUMMARY")
        print("=" * 50)
        print(f"Successful: {len(successful)}")
        print(f"Failed: {len(failed)}")

        if successful:
            print("\nSuccessfully loaded:")
            for table_name in successful:
                print(f"  - {table_name}")

        if failed:
            print("\nFailed files:")
            for file_name, error in failed:
                print(f"  - {file_name}: {error}")

            raise RuntimeError(
                f"{len(failed)} file(s) failed to load."
            )

        print("\nAll Python-ingested files loaded successfully.")

    finally:
        if cursor:
            cursor.close()

        if connection:
            connection.close()


if __name__ == "__main__":
    main()
