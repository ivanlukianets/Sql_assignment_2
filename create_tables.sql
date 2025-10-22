create database Assignment_2_DB;
use Assignment_2_DB;


create table roses(
    id int auto_increment primary key,
    name varchar(100) not null ,
    color varchar(100),
    leaves_length float,
    pinnation int,
    thorns boolean,
    company_producer varchar(300),
    petal_size int
);

create table companies(
    id int auto_increment primary key,
    company_name varchar(200),
    company_address text,
    website varchar(300),
    country varchar(100),
    postcode int,
    city varchar(200)
);

create table florals(
    id int auto_increment primary key,
    floral_name varchar(200),
    city varchar(200),
    number_of_workers int,
    working boolean
);