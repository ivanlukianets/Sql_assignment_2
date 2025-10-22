#fake.lexify("??????????")

import random
import uuid
import mysql.connector
from faker import Faker

def generate_student_record(fake: Faker) -> tuple:
    """Generate a single student record with UUID id."""
    company_name = fake.company()
    company_address = fake.address()
    website = fake.url()
    country = fake.country()
    postcode = fake.postcode()
    city = fake.city()
    return (company_name, company_address, website, country, postcode, city)

def insert_students(
    host: str,
    user: str,
    password: str,
    database: str,
    total_rows: int = 1_000_000,
    batch_size: int = 10_000
) -> None:
    """
    Generate and insert synthetic student performance data into MySQL.

    Args:
        host (str): MySQL host
        user (str): MySQL user
        password (str): MySQL password
        database (str): Database name
        total_rows (int): Number of rows to insert
        batch_size (int): Rows per batch insert
    """
    connection = mysql.connector.connect(
        host='127.0.0.1',
        user='root',
        password='MySQL_Student123',
        database='Assignment_2_DB'
    )
    cursor = connection.cursor()

    fake = Faker()

    insert_query = """
        INSERT INTO companies
        (company_name, company_address, website, country, postcode, city)
        VALUES (%s, %s, %s, %s, %s, %s)
    """

    for i in range(0, total_rows, batch_size):
        batch = [generate_student_record(fake) for _ in range(batch_size)]
        cursor.executemany(insert_query, batch)
        connection.commit()
        print(f"Inserted {min(i + batch_size, total_rows)} / {total_rows} rows")

    cursor.close()
    connection.close()
    print("✅ Data insertion complete!")

if __name__ == "__main__":
    insert_students(
        host="localhost",
        user="root",
        password="your_password",
        database="your_database",
        total_rows=3_000_000,  # Change here if needed
        batch_size=50_000
    )
