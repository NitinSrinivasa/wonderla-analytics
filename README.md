# Wonderla Analytics

This project builds a data pipeline for Wonderla using AWS S3, Snowflake, Python, Airflow, and dbt.

The goal of the project is to load raw CSV files into Snowflake, transform the data into an analytics model using dbt, and create tables that can be used for reporting and analysis.

---

## Project Components

### Data Ingestion

The project uses two ingestion methods.

**Snowpipe**
- Customers
- Online ticket sales
- Physical ticket sales
- Online merchandise sales
- Physical merchandise sales

**Python**
- Customer feedback
- Rides
- Operations rides
- Marketing rides
- Ticket types
- Merchandise products
- Weather data
- Check-ins
- Safety incidents
- Electricity costs
- Maintenance costs
- Staff costs
- Supplies costs

The Python ingestion script uploads each CSV file to its corresponding Snowflake table using `PUT` and `COPY INTO`.

---

## Airflow

Airflow is used to run the Python ingestion process.

The DAG:

```
wonderla_python_ingestion
```

executes the Python ingestion script and loads the 13 datasets into Snowflake.

---

## dbt

The dbt project performs the transformations after the data has been loaded.

It includes:

- 18 staging models
- 3 intermediate models
- 5 dimension tables
- 5 fact tables
- 3 data marts
- Customer SCD Type 2 snapshot
- 35 passing dbt tests

---

## Repository Structure

```
airflow/
    dags/

models/

snapshots/

scripts/

tests/

README.md
```

---

## Technologies Used

- AWS S3
- Snowflake
- Snowpipe
- Python
- Apache Airflow
- dbt

---

## Running the Python Ingestion

Create a `.env` file with your Snowflake credentials.

Then run:

```bash
python scripts/ingest_files.py
```

---

## Running dbt

```bash
dbt build
```

---

## Presentation

The project presentation is included in this repository.
