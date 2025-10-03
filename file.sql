
-- Create Database
CREATE DATABASE kensa_scents_db;
USE kensa_scents_db;

-- Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    fragrance_notes VARCHAR(255),
    size_ml DECIMAL(5,2),
    price DECIMAL(10,2),
    stock_quantity INT,
    sku_code VARCHAR(50) UNIQUE,
    launch_date DATE,
    status ENUM('Active', 'Discontinued') DEFAULT 'Active',
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAP ON UPDATE CURRENT_TIMESTAP
);

-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    gender ENUM('Male','Female','Other'),
    date_of_birth DATE,
    address TEXT,
    city VARCHAR(50),
    country VARCHAR(50),
    loyalty_points INT DEFAULT 0,
    join_date DATE,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAP ON UPDATE CURRENT_TIMESTAP
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    payment_method ENUM('Card','Cash','Transfer','Wallet'),
    total_amount DECIMAL(10,2),
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Suppliers Table
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    supply_type VARCHAR(100),
    rating INT CHECK(rating BETWEEN 1 AND 5)
);

-- Raw_Materials Table
CREATE TABLE Raw_Materials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(100),
    category VARCHAR(50),
    unit VARCHAR(20),
    quantity_in_stock DECIMAL(10,2),
    reorder_level DECIMAL(10,2),
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Employees Table
CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE,
    salary DECIMAL(10,2),
    department VARCHAR(50),
    status ENUM('Active','Resigned','Suspended') DEFAULT 'Active'
);

-- Marketing Campaigns Table
CREATE TABLE Marketing_Campaigns (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12,2),
    channel ENUM('Social Media','Billboard','TV','Radio','Influencer','Other'),
    target_audience VARCHAR(100),
    status ENUM('Planned','Ongoing','Completed') DEFAULT 'Planned'
);

-- Finance Table
CREATE TABLE Finance (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    type ENUM('Revenue','Expense'),
    category VARCHAR(50),
    amount DECIMAL(12,2),
    description TEXT,
    related_order INT,
    FOREIGN KEY (related_order) REFERENCES Orders(order_id)
);

-- Admin Table
CREATE TABLE Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password_hash VARCHAR(255),
    role ENUM('Owner','Manager','Staff') DEFAULT 'Staff',
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAP ON UPDATE CURRENT_TIMESTAP
);


-- Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Customer','Employee','Supplier','BrandPartner','Admin') DEFAULT 'Customer',
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('Male','Female','Other'),
    phone VARCHAR(20),
    date_of_birth DATE,
    profile_picture VARCHAR(255),
    address TEXT,
    city VARCHAR(50),
    country VARCHAR(50),
    company_name VARCHAR(100),
    brand_name VARCHAR(100),
    website VARCHAR(255),
    business_type VARCHAR(100),
    tax_id VARCHAR(50),
    partnership_status ENUM('Pending','Approved','Rejected') DEFAULT 'Pending',
    is_active BOOLEAN DEFAULT TRUE,
    last_login DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Add user_id to Orders (link orders to Users)
ALTER TABLE Orders
ADD user_id INT,
ADD FOREIGN KEY (user_id) REFERENCES Users(user_id);


-- Insert Sample Products
INSERT INTO Products (product_name, category, fragrance_notes, size_ml, price, stock_quantity, sku_code, launch_date)
VALUES
('Eternal Bloom', 'Perfume', 'Rose, Jasmine, Musk', 50, 75.00, 100, 'P001', '2025-01-01'),
('Midnight Aura', 'Perfume', 'Vanilla, Oud, Amber', 100, 120.00, 80, 'P002', '2025-01-15'),
('Ocean Petals','Body Mist','Rasberry,Oud,Vanilla',20,150.00,200,'P003','2025-03-13'),
('Citrus Whisper', 'Body Spray', 'Orange, Lemon, Mint', 150, 25.00, 200, 'P003', '2025-02-01');

-- Insert Sample Customers
INSERT INTO Customers (first_name, last_name, email, phone, gender, date_of_birth, address, city, country, join_date)
VALUES
('Mercy', 'Osato', 'mercy@example.com', '+2348012345678', 'Female', '1998-06-15', '12 Palm Street', 'Lagos', 'Nigeria', '2025-01-20'),
('John', 'Doe', 'johndoe@example.com', '+2348098765432', 'Male', '1992-03-10', '45 Ocean Avenue', 'Abuja', 'Nigeria', '2025-01-25');

-- Insert Sample Orders
INSERT INTO Orders (customer_id, order_date, status, payment_method, total_amount, shipping_address)
VALUES
(1, NOW(), 'Delivered', 'Card', 75.00, '12 Palm Street, Lagos'),
(2, NOW(), 'Pending', 'Cash', 120.00, '45 Ocean Avenue, Abuja');

-- Insert Sample Order Items
INSERT INTO Order_Items (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 75.00),
(2, 2, 1, 120.00);

-- Insert Sample Suppliers
INSERT INTO Suppliers (supplier_name, contact_person, phone, email, address, supply_type, rating)
VALUES
('Aroma Oils Ltd', 'James Smith', '+2347001234567', 'james@aromaoils.com', '20 Industrial Road, Lagos', 'Fragrance Oils', 5),
('Crystal Packaging', 'Amaka Johnson', '+2347012349876', 'amaka@crystalpack.com', '5 Trade Fair Complex, Abuja', 'Bottles & Packaging', 4);

-- Insert Sample Raw Materials
INSERT INTO Raw_Materials (material_name, category, unit, quantity_in_stock, reorder_level, supplier_id)
VALUES
('Rose Oil', 'Fragrance Oil', 'ml', 5000, 1000, 1),
('Glass Perfume Bottle 50ml', 'Bottle', 'pcs', 2000, 500, 2);

-- Insert Sample Employees
INSERT INTO Employees (first_name, last_name, position, email, phone, hire_date, salary, department)
VALUES
('Sarah', 'Okafor', 'Sales Manager', 'sarah@kensascents.com', '+2348001112222', '2025-01-10', 2500.00, 'Sales'),
('David', 'Emeka', 'Perfumer', 'david@kensascents.com', '+2348003334444', '2025-01-05', 3000.00, 'Production');

-- Insert Sample Marketing Campaigns
INSERT INTO Marketing_Campaigns (campaign_name, start_date, end_date, budget, channel, target_audience, status)
VALUES
('Valentine Promo', '2025-02-01', '2025-02-14', 5000.00, 'Social Media', 'Young Adults', 'Planned');

-- Insert Sample Finance Transactions
INSERT INTO Finance (transaction_date, type, category, amount, description, related_order)
VALUES
(NOW(), 'Revenue', 'Sales', 75.00, 'Order #1 Payment', 1),
(NOW(), 'Expense', 'Raw Materials', 2000.00, 'Purchase of Rose Oil', NULL);

-- Insert Sample Admins
INSERT INTO Admin (username, password_hash, role)
VALUES
('admin', 'hashed_password_here', 'Owner');


-- Insert Sample Users
INSERT INTO Users (username, email, password_hash, role, first_name, last_name, gender, phone, date_of_birth, city, country, company_name, brand_name, website, business_type, partnership_status)
VALUES
('mercy_osato', 'mercy@example.com', 'hashed_pw1', 'Customer', 'Mercy', 'Osato', 'Female', '+2348012345678', '1998-06-15', 'Lagos', 'Nigeria', NULL, NULL, NULL, NULL, 'Approved'),
('john_doe', 'john@example.com', 'hashed_pw2', 'Customer', 'John', 'Doe', 'Male', '+2348098765432', '1992-03-10', 'Abuja', 'Nigeria', NULL, NULL, NULL, NULL, 'Approved'),
('sarah_okafor', 'sarah@kensascents.com', 'hashed_pw3', 'Employee', 'Sarah', 'Okafor', 'Female', '+2348001112222', '1990-05-20', 'Lagos', 'Nigeria', 'Kensa Scents Ltd', NULL, NULL, 'Internal', 'Approved'),
('luxury_fragrances', 'partner@luxperfume.com', 'hashed_pw4', 'BrandPartner', 'James', 'Smith', 'Male', '+1-202-555-1234', '1980-02-14', 'New York', 'USA', 'Luxury Fragrances LLC', 'LUX Perfumes', 'https://luxperfume.com', 'Perfume Manufacturing', 'Pending'),
('admin_kensa', 'admin@kensascents.com', 'hashed_pw5', 'Admin', 'Kensa', 'Admin', 'Other', '+2348009998888', '1985-01-01', 'Lagos', 'Nigeria', 'Kensa Scents Ltd', NULL, NULL, 'Management', 'Approved');
