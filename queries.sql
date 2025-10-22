use Assignment_2_DB;

-- Non-optimized query version
EXPLAIN SELECT
    r.name AS rose_name,
    r.color,
    r.petal_size,
    c.company_name,
    c.country,
    c.city AS company_city,
    f.floral_name,
    f.number_of_workers
FROM roses r
JOIN companies c
    ON r.company_producer = c.company_name
JOIN florals f
    ON c.city = f.city
WHERE r.color IN (
        SELECT color
        FROM roses
        WHERE thorns = TRUE
    )
  AND f.working = 1
  AND c.country LIKE '%a%'
  AND r.petal_size > (
        SELECT AVG(petal_size)
        FROM roses
        WHERE pinnation > 10
    )
ORDER BY c.city, r.name;

# - No space left on device( System data 100 gigabytes. Executed more than 15 minutes

# 🧩 Result description
#
# This query returns:
#
# Each rose (with color and petal size),
#
# The company that produces it,
#
# The floral shop in the same city,
#
# But only for:
#
# Working florals,
#
# Companies with “a” in their country name,
#
# Roses whose petal size is above the average for roses with pinnation > 10,
#
# And whose color appears among thorny roses.

create index idx_petal_size on roses(petal_size);

create index idx_pinnation on roses(pinnation);
--
-- create index idx_thorns on roses(thorns);
-- create index idx_working on florals(working);
-- drop index idx_thorns on roses;
-- drop index idx_working on florals;



with companies_filtered as(
    select company_name, city, country
    from companies
    where company_name like '%a%'
    ),
    florals_filtered as(
        select floral_name, number_of_workers, city
        from florals
        where working = 1
    ),
    roses_filtered as(
        select name, color, petal_size, company_producer
        from roses
        use index (idx_petal_size) -- MySQL optimizer hints
        use index (idx_pinnation)
        where petal_size > (select avg(a.petal_size) from roses a) and pinnation > 10
        and color in (select b.color from roses b where b.thorns = 1 ) -- SUBQUERY(MATERIALIZATION)
    )
select r.name,r.color,r.petal_size, c.company_name, c.country, c.city, f.floral_name,f.number_of_workers
from roses_filtered r
join companies_filtered c on c.company_name = r.company_producer
join florals_filtered f on f.city = c.city;


-- SUBQUERY(MATERIALIZATION)
/*explain analyze select * from roses
where petal_size > (select avg(a.petal_size) from roses a) and pinnation > 10
        and color in (select b.color from roses b where b.thorns = 1 );*/