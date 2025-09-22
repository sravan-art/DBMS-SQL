
CREATE TABLE Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);


CREATE TABLE Permissions (
    permission_id INT PRIMARY KEY AUTO_INCREMENT,
    permission_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);


CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

CREATE TABLE Logins (
    login_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    status VARCHAR(20) CHECK (status IN ('SUCCESS', 'FAILED')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255)
);


CREATE TABLE Mobiles (
    mobile_id INT PRIMARY KEY AUTO_INCREMENT,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);


CREATE TABLE Sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    mobile_id INT NOT NULL,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (mobile_id) REFERENCES Mobiles(mobile_id)
);


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(12,2) NOT NULL,
    method VARCHAR(50) CHECK (method IN ('CASH','CARD','UPI','BANK_TRANSFER')),
    status VARCHAR(20) CHECK (status IN ('PENDING','COMPLETED','FAILED')),
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id)
);


INSERT INTO Roles (role_name, description) VALUES
('Admin', 'System administrator'),
('SalesExec', 'Handles sales'),
('Technician', 'Handles service');


INSERT INTO Permissions (permission_name, description) VALUES
('ADD_MOBILE', 'Add new mobile phones'),
('PROCESS_SALE', 'Handle customer sales'),
('VIEW_REPORTS', 'View sales reports');



INSERT INTO Users (username, email, password_hash, role_id) VALUES
('amit', 'amit@example.com', 'hashedpwd1', 1),
('priya', 'priya@example.com', 'hashedpwd2', 2);


INSERT INTO Customers (name, phone, email, address) VALUES
('Ravi Kumar', '9876543210', 'ravi@example.com', 'Delhi'),
('Neha Singh', '9123456789', 'neha@example.com', 'Mumbai');


INSERT INTO Mobiles (brand, model, price, stock) VALUES
('Samsung', 'Galaxy S23', 70000, 10),
('Apple', 'iPhone 15', 60000, 35),
('OnePlus', 'Nord CE 3 Lite', 25000, 20),
('Infinix','GT 30 Pro 5G', 24000, 50),
('Motorola', 'G86 Power', 17999, 20),
('Motorola', 'G96 5G', 17785, 20),
('Samsung', 'Galaxy Z Fold6 5G', 124999, 10),
('Apple', 'iPhone 16', 70000, 20),
('Vivo', 'Vivo X200', 95000, 20),
('Realme', '15T', 22200, 30),
('iQ', 'Neo 10', 41000, 15),
('OPPO','Reno14 5G',37998,4),
('OPPO', 'Reno14 Pro 5G', 50000,5);

INSERT INTO Sales (customer_id, mobile_id, quantity, total_amount) VALUES
(1, 1, 1, 70000.00),   
(2, 2, 2, 240000.00);  


INSERT INTO Payments (sale_id, amount, method, status) VALUES
(1, 70000.00, 'UPI', 'COMPLETED'),
(2, 240000.00, 'CARD', 'PENDING');

select *from Sales;
select * from Mobiles where brand LIKE 'S%';
select *from Mobiles where price < 50000;
select * from Payments where method = 'UPI';

