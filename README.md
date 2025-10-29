Repository of task: https://github.com/AngelShynk/AI_EBD_Practices/blob/main/Assignments/02_Assignment.md

✅ What Was Accomplished
🔹 Project Overview

The SQL Assignment 2 – MySQL Query Optimization project demonstrates the process of analyzing, optimizing, and comparing query performance in a MySQL database environment.
The work includes designing a relational schema, generating large-scale test data, constructing a complex multi-join query, and applying multiple optimization techniques to improve efficiency while maintaining identical query results.

🔹 Database Design and Data Generation

Three major tables were created (companies, roses, and florals) using the script create_tables.sql.

Each table contains over 1,000,000 records, meeting the data volume requirement for testing large-scale query performance.

Data population was automated through Python data generation scripts:

companies_generation.py – generates synthetic company data.

roses_generation.py – generates large rose dataset.

florals_generation.py – generates floral product data.

This ensured reproducible, high-volume datasets for realistic performance testing.

🔹 Query Development and Optimization

Two SQL query versions were developed in queries.sql:

Non-optimized query (AI-generated)

Constructed with multiple JOINs (3+ tables).

Used no indexing or optimization hints.

Represented a typical inefficient query performing full table scans and nested loops.

Optimized query (student-improved)

Rewritten using Common Table Expressions (CTEs) for better readability and modular processing.

Added indexes on frequently joined and filtered columns to reduce table scans.

Applied query rewriting techniques, simplifying subqueries and improving join order.

Optionally used optimizer hints such as USE INDEX and /*+ SUBQUERY(MATERIALIZATION) */ to guide the optimizer when beneficial.

Both queries returned identical results, verifying correctness after optimization.

🔹 Performance Evaluation

Used EXPLAIN and EXPLAIN ANALYZE to compare execution plans before and after optimization.

Key metrics compared:

Query cost and execution time.

Number of rows scanned.

Join strategy (nested loops vs index lookups).

The optimized query showed significant improvement in runtime and reduced I/O operations.


Documented their effect on the execution plan and performance:

Positive when guiding the optimizer toward efficient join paths.

Negative or neutral in cases where the optimizer’s native plan was already optimal.
