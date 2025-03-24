-- Raw Data Schema Tables
CREATE TABLE raw_data.Brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR NOT NULL
);

CREATE TABLE raw_data.Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR NOT NULL
);

CREATE TABLE raw_data.Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR NOT NULL,
    brand_id INT REFERENCES raw_data.Brands(brand_id),
    category_id INT REFERENCES raw_data.Categories(category_id),
    model_year SMALLINT NOT NULL,
    list_price DECIMAL NOT NULL
);

CREATE TABLE raw_data.Stocks (
    store_id INT REFERENCES raw_data.Stores(store_id),
    product_id INT REFERENCES raw_data.Products(product_id),
    quantity INT NOT NULL,
    PRIMARY KEY (store_id, product_id)
);

CREATE TABLE raw_data.Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    phone VARCHAR,
    email VARCHAR,
    street VARCHAR,
    city VARCHAR,
    state VARCHAR,
    zip_code VARCHAR
);

CREATE TABLE raw_data.Orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES raw_data.Customers(customer_id),
    order_status INT NOT NULL,
    order_date DATE NOT NULL,
    required_date DATE,
    shipped_date DATE,
    store_id INT REFERENCES raw_data.Stores(store_id),
    staff_id INT REFERENCES raw_data.Staffs(staff_id)
);

CREATE TABLE raw_data.Staffs (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR,
    phone VARCHAR,
    active INT NOT NULL,
    store_id INT REFERENCES raw_data.Stores(store_id),
    manager_id INT
);

CREATE TABLE raw_data.Stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR NOT NULL,
    phone VARCHAR,
    email VARCHAR,
    street VARCHAR,
    city VARCHAR,
    state VARCHAR,
    zip_code VARCHAR
);


-- Snowflake Schema