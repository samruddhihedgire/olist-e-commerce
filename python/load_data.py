import pandas as pd
from sqlalchemy import create_engine

# ============================================================
# 1. MYSQL CONNECTION
# ============================================================

engine = create_engine(
    "mysql+pymysql://root:Root@localhost/olist_raw"
)


# ============================================================
# 2. LOCATION OF CSV FILES
# ============================================================

DATA_DIR = r"C:\Users\samruddhi.hedgire\OneDrive - Nihilent Limited\Pipeline projects\olist-ecommerce-project"


# ============================================================
# 3. CSV FILES AND MYSQL TABLE NAMES
# ============================================================

files = {
    "olist_customers_dataset.csv": "customers",
    "olist_geolocation_dataset.csv": "geolocation",
    "olist_order_items_dataset.csv": "order_items",
    "olist_order_payments_dataset.csv": "order_payments",
    "olist_order_reviews_dataset.csv": "order_reviews",
    "olist_orders_dataset.csv": "orders",
    "olist_products_dataset.csv": "products",
    "olist_sellers_dataset.csv": "sellers",
    "product_category_name_translation.csv": "product_category_translation"
}


# ============================================================
# 4. LOAD ALL CSV FILES INTO MYSQL
# ============================================================

for csv_file, table_name in files.items():

    file_path = DATA_DIR + "\\" + csv_file

    print("\nLoading:", csv_file)

    try:

        # Read CSV
        df = pd.read_csv(file_path)

        print("Rows found:", len(df))

        # Load into MySQL
        df.to_sql(
            table_name,
            con=engine,
            if_exists="replace",
            index=False
        )

        print("SUCCESS:", table_name, "table created")

    except FileNotFoundError:

        print("ERROR: File not found:", file_path)

    except Exception as e:

        print("ERROR:", e)


# ============================================================
# 5. COMPLETED
# ============================================================

print("\n========================================")
print("DATA LOADING PROCESS COMPLETED")
print("========================================")