-- Create Data Warehouse Tables
CREATE TABLE sales_dw.Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category_id INT,
    brand_id INT,
    price DECIMAL(10, 2)
);

CREATE TABLE sales_dw.Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
	street VARCHAR,
	city VARCHAR,
	state VARCHAR,
	zip_code VARCHAR
);

CREATE TABLE sales_dw.Stores (
    store_id INT PRIMARY KEY,
	phone VARCHAR,
	email VARCHAR,
	street VARCHAR,
	city VARCHAR,
	state VARCHAR,
    store_name VARCHAR(255) NOT NULL,
	zip_code VARCHAR,
    location VARCHAR(255),
    manager_id INT
);

CREATE TABLE sales_dw.Staffs (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    active INT NOT NULL,
    store_id INT
);

CREATE TABLE sales_dw.Sales_Fact (
    fact_id SERIAL PRIMARY KEY,  
    product_id INT,
    customer_id INT,
    store_id INT,
    staff_id INT,
    order_date DATE
);


CREATE TABLE sales_dw.Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE sales_dw.Brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);






-- Products Table Constraints
ALTER TABLE sales_dw.Products
ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES sales_dw.Categories(category_id);

ALTER TABLE sales_dw.Products
ADD CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES sales_dw.Brands(brand_id);

-- Stores Table Constraints
ALTER TABLE sales_dw.Stores
ADD CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES sales_dw.Staffs(staff_id);

-- Staffs Table Constraints
ALTER TABLE sales_dw.Staffs
ADD CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES sales_dw.Stores(store_id);

-- Sales_Fact Table Constraints
ALTER TABLE sales_dw.Sales_Fact
ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES sales_dw.Products(product_id);

ALTER TABLE sales_dw.Sales_Fact
ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES sales_dw.Customers(customer_id);

ALTER TABLE sales_dw.Sales_Fact
ADD CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES sales_dw.Stores(store_id);

ALTER TABLE sales_dw.Sales_Fact
ADD CONSTRAINT fk_staff FOREIGN KEY (staff_id) REFERENCES sales_dw.Staffs(staff_id);

ALTER TABLE sales_dw.Sales_Fact
ADD CONSTRAINT fk_date FOREIGN KEY (date_id) REFERENCES sales_dw.Date_Dimension(date_id);





-- fill Data Warehouse Tables
-- Insert data into Dim_Categories
INSERT INTO sales_dw.Categories (category_id, category_name)
SELECT DISTINCT category_id, category_name
FROM raw_data.categories;
select * from sales_dw.Categories;


-- Insert data into Dim_Brands
INSERT INTO sales_dw.Brands (brand_id, brand_name)
SELECT DISTINCT brand_id, brand_name
FROM raw_data.brands;
select * from sales_dw.Brands;

-- Insert data into sales_dw.Products from raw_data.products
ALTER TABLE sales_dw.Products ADD COLUMN list_price int;
ALTER TABLE sales_dw.Products ADD COLUMN model_year smallint;
INSERT INTO sales_dw.Products (product_id, product_name, category_id, brand_id, list_price,model_year)
SELECT 
    product_id, 
    product_name, 
    category_id, 
    brand_id, 
    list_price,
	model_year
FROM raw_data.products;

select * FROM raw_data.products;
-- Insert data into Dim_Stores
INSERT INTO sales_dw.Stores (store_id, store_name, phone, email, street, city, state, zip_code)
SELECT DISTINCT store_id, store_name, phone, email, street, city, state, zip_code
FROM raw_data.stores;
select * from sales_dw.Stores;

ALTER TABLE sales_dw.Customers ADD COLUMN street VARCHAR;
ALTER TABLE sales_dw.Customers ADD COLUMN city VARCHAR;
ALTER TABLE sales_dw.Customers ADD COLUMN state VARCHAR;
ALTER TABLE sales_dw.Customers ADD COLUMN zip_code VARCHAR;

-- Insert data into Dim_Customers
-- Insert data into Sales_Fact, excluding fact_id which is auto-generated
INSERT INTO sales_dw.Sales_Fact (order_id, order_status, order_date, required_date, shipped_date, product_id, store_id, customer_id, staff_id, quantity, list_price, model_year)
SELECT 
    o.order_id,
    o.order_status,
    o.order_date,
    o.required_date,
    o.shipped_date,
    p.product_id,
    o.store_id,
    o.customer_id,
    o.staff_id,
    st.quantity,
    p.list_price,
    p.model_year
FROM raw_data.orders AS o
JOIN raw_data.stocks AS st ON o.store_id = st.store_id
JOIN raw_data.products AS p ON st.product_id = p.product_id;


ALTER TABLE sales_dw.Sales_Fact ADD COLUMN order_id INT;
ALTER TABLE sales_dw.Sales_Fact ADD COLUMN order_status INT;
ALTER TABLE sales_dw.Sales_Fact ADD COLUMN required_date DATE;
ALTER TABLE sales_dw.Sales_Fact ADD COLUMN shipped_date DATE;
ALTER TABLE sales_dw.Sales_Fact ADD COLUMN quantity INT;
ALTER TABLE sales_dw.Sales_Fact ADD COLUMN list_price INT;
ALTER TABLE sales_dw.Sales_Fact ADD COLUMN model_year smallint;

select * from raw_data.orders;










