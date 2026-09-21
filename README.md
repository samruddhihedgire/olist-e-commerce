# Olist E-Commerce ETL Pipeline

An end-to-end ETL pipeline built on the [Olist Brazilian E-Commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). Raw CSV data is ingested into MySQL, transformed with dbt through a layered staging → intermediate → marts architecture, and served from an analytics database for downstream BI consumption.

## Architecture

```text
Olist CSV Files
      │
      ▼
Python / Pandas          (extract & load)
      │
      ▼
MySQL — olist_raw
      │
      ▼
dbt Core                 (transform)
   staging → intermediate → marts
      │
      ▼
MySQL — olist_analytics
      │
      ▼
Power BI / Analytics
```

## Tech Stack

| Layer          | Tools                          |
|----------------|---------------------------------|
| Ingestion      | Python, Pandas                  |
| Storage        | MySQL                           |
| Transformation | dbt Core, dbt-mysql adapter     |
| BI / Reporting | Power BI                        |
| Version Control| Git / GitHub                    |

## Project Structure

```text
olist-ecommerce-project/
├── data/
│   └── raw/                     # Source CSV files
│
├── olist_analytics_dbt/
│   ├── models/
│   │   ├── sources/
│   │   ├── staging/
│   │   ├── intermediate/
│   │   └── marts/
│   ├── macros/
│   ├── seeds/
│   ├── snapshots/
│   ├── tests/
│   └── dbt_project.yml
│
├── README.md
└── .gitignore
```

## ETL Workflow

1. **Extract** — Olist CSV files are read using Python and Pandas.
2. **Load** — Raw data is loaded into the MySQL `olist_raw` database.
3. **Transform** — dbt transforms `olist_raw` into `olist_analytics` through three layers:
   `sources → staging → intermediate → marts`
4. **Consume** — The `olist_analytics` database connects to Power BI (or any BI tool) for reporting.

---

## Setup

### Prerequisites

- Python 3.x
- MySQL Server + MySQL Workbench
- Git
- Power BI Desktop
- dbt Core

### 1. Clone the repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd olist-ecommerce-project
```

### 2. Create a Python virtual environment

```powershell
python -m venv dbt-env
.\dbt-env\Scripts\activate
```

### 3. Install dependencies

```powershell
pip install pandas sqlalchemy pymysql
pip install dbt-core==1.7.20 dbt-mysql==1.7.0
```

Verify the install:

```powershell
dbt --version
```

### 4. Create the MySQL databases

In MySQL Workbench, run:

```sql
CREATE DATABASE olist_raw;
CREATE DATABASE olist_analytics;
```

### 5. Load the raw data

Place the Olist CSV files in `data/raw/`, then run the Python ingestion scripts included in this repository to load them into `olist_raw`.

### 6. Configure dbt

Create `~/.dbt/profiles.yml`:

```yaml
olist_analytics_dbt:
  target: dev
  outputs:
    dev:
      type: mysql
      server: localhost
      port: 3306
      username: root
      password: YOUR_MYSQL_PASSWORD
      database: olist_analytics
      schema: olist_analytics
      threads: 1
```

Replace `YOUR_MYSQL_PASSWORD` with your actual MySQL password.

### 7. Test the dbt connection

```powershell
cd olist_analytics_dbt
dbt debug
```

The connection test should pass.

### 8. Check dbt sources

```powershell
dbt ls --resource-type source
```

### 9. Build the pipeline

```powershell
dbt build
```

Expected result:

```text
PASS=19  WARN=0  ERROR=0  SKIP=0
```

### 10. Generate dbt documentation

```powershell
dbt docs generate
dbt docs serve
```

This opens the dbt documentation and lineage graph locally.

---

## Useful Commands

| Command                              | Description                     |
|---------------------------------------|----------------------------------|
| `dbt build`                          | Build the complete pipeline      |
| `dbt run --select model_name`        | Run a specific model             |
| `dbt run --select staging`           | Run the staging layer only       |
| `dbt ls --resource-type model`       | List all models                  |
| `dbt ls --resource-type source`      | List all sources                 |
| `dbt docs generate`                  | Generate documentation           |

---

## Key Skills Demonstrated

- ETL pipeline development
- Python data ingestion (Pandas)
- SQL & MySQL
- dbt transformations and layered data modeling
- dbt testing and data lineage
- Power BI integration
- Git / GitHub workflow

## Author

**Samruddhi Hedgire**