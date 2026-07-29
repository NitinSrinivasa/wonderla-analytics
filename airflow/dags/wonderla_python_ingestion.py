from datetime import datetime
from pathlib import Path

from airflow import DAG
from airflow.providers.standard.operators.bash import BashOperator


PROJECT_DIR = Path(__file__).resolve().parents[2]PROJECT_DIR = Path(__file__).resolve().parents[2]
PYTHON_EXECUTABLE = PROJECT_DIR / "venv" / "bin" / "python"
INGESTION_SCRIPT = PROJECT_DIR / "scripts" / "ingest_files.py"


with DAG(
    dag_id="wonderla_python_ingestion",
    description="Load Wonderla CSV files into Snowflake using Python",
    start_date=datetime(2026, 7, 28),
    schedule=None,
    catchup=False,
    tags=["wonderla", "snowflake", "python-ingestion"],
) as dag:

    run_python_ingestion = BashOperator(
        task_id="load_python_ingested_files",
        bash_command=(
            f'cd "{PROJECT_DIR}" && '
            f'"{PYTHON_EXECUTABLE}" "{INGESTION_SCRIPT}"'
        ),
        append_env=True,
    )
