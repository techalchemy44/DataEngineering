create database if not exists nexamart;
use nexamart;

/*
TABLE CREATION 
*/
-- create Users table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create categories table

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);


-- create products table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

-- create orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- create order_items table
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_time DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- create payments table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Net Banking') NOT NULL,
    payment_status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

-- create reviews
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- create cart table

CREATE TABLE Cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

/* 
INSERT DATA
*/


-- insert Users data
INSERT INTO Users (first_name, last_name, email, password) VALUES
('Aarav', 'Sharma', 'aarav.sharma@example.com', 'Passw0rd1!'),
('Vivaan', 'Patel', 'vivaan.patel@example.com', 'Passw0rd2@'),
('Aditya', 'Mehta', 'aditya.mehta@example.com', 'Passw0rd3#'),
('Vihaan', 'Verma', 'vihaan.verma@example.com', 'Passw0rd4$'),
('Arjun', 'Singh', 'arjun.singh@example.com', 'Passw0rd5%'),
('Sai', 'Iyer', 'sai.iyer@example.com', 'Passw0rd6^'),
('Kian', 'Bhat', 'kian.bhat@example.com', 'Passw0rd7&'),
('Rohan', 'Nair', 'rohan.nair@example.com', 'Passw0rd8*'),
('Riya', 'Patel', 'riya.patel@example.com', 'Passw0rd9('),
('Ananya', 'Sharma', 'ananya.sharma@example.com', 'Passw0rd10)'),
('Saanvi', 'Mehta', 'saanvi.mehta@example.com', 'Passw0rd11-'),
('Diya', 'Verma', 'diya.verma@example.com', 'Passw0rd12_'),
('Maya', 'Singh', 'maya.singh@example.com', 'Passw0rd13='),
('Isha', 'Nair', 'isha.nair@example.com', 'Passw0rd14+'),
('Nisha', 'Iyer', 'nisha.iyer@example.com', 'Passw0rd15{'),
('Pooja', 'Bhat', 'pooja.bhat@example.com', 'Passw0rd16}'),
('Tanvi', 'Sharma', 'tanvi.sharma@example.com', 'Passw0rd17|'),
('Shruti', 'Mehta', 'shruti.mehta@example.com', 'Passw0rd18;'),
('Simran', 'Verma', 'simran.verma@example.com', 'Passw0rd19:'),
('Sneha', 'Iyer', 'sneha.iyer@example.com', 'Passw0rd20"'),
('Aanya', 'Patel', 'aanya.patel@example.com', 'Passw0rd21\''),
('Ira', 'Sharma', 'ira.sharma@example.com', 'Passw0rd22<'),
('Misha', 'Nair', 'misha.nair@example.com', 'Passw0rd23>'),
('Tara', 'Bhat', 'tara.bhat@example.com', 'Passw0rd24?'),
('Neha', 'Iyer', 'neha.iyer@example.com', 'Passw0rd25.'),
('Siddharth', 'Patel', 'siddharth.patel@example.com', 'Passw0rd26,'),
('Kavya', 'Mehta', 'kavya.mehta@example.com', 'Passw0rd27/'),
('Dev', 'Verma', 'dev.verma@example.com', 'Passw0rd28~'),
('Kabir', 'Singh', 'kabir.singh@example.com', 'Passw0rd29`'),
('Shiv', 'Iyer', 'shiv.iyer@example.com', 'Passw0rd30!'),
('Aanya', 'Patil', 'aanya.patil@example.com', 'Passw0rd31@'),
('Tanisha', 'Mehta', 'tanisha.mehta@example.com', 'Passw0rd32#'),
('Aditi', 'Verma', 'aditi.verma@example.com', 'Passw0rd33$'),
('Dhruva', 'Iyer', 'dhruva.iyer@example.com', 'Passw0rd34%'),
('Lakshmi', 'Bhat', 'lakshmi.bhat@example.com', 'Passw0rd35^'),
('Tanay', 'Patel', 'tanay.patel@example.com', 'Passw0rd36&'),
('Nitin', 'Mehta', 'nitin.mehta@example.com', 'Passw0rd37*'),
('Siddhi', 'Sharma', 'siddhi.sharma@example.com', 'Passw0rd38('),
('Neel', 'Verma', 'neel.verma@example.com', 'Passw0rd39)'),
('Ved', 'Singh', 'ved.singh@example.com', 'Passw0rd40-'),
('Chaitanya', 'Iyer', 'chaitanya.iyer@example.com', 'Passw0rd41_'),
('Riddhi', 'Nair', 'riddhi.nair@example.com', 'Passw0rd42='),
('Aarushi', 'Patel', 'aarushi.patel@example.com', 'Passw0rd43+'),
('Naina', 'Singh', 'naina.singh@example.com', 'Passw0rd44{'),
('Shreya', 'Mehta', 'shreya.mehta@example.com', 'Passw0rd45}'),
('Ansh', 'Iyer', 'ansh.iyer@example.com', 'Passw0rd46|'),
('Shivani', 'Bhat', 'shivani.bhat@example.com', 'Passw0rd47;'),
('Om', 'Sharma', 'om.sharma@example.com', 'Passw0rd48:'),
('Ayaan', 'Verma', 'ayaan.verma@example.com', 'Passw0rd49"'),
('Esha', 'Patel', 'esha.patel@example.com', 'Passw0rd50\''),
('Meera', 'Nair', 'meera.nair@example.com', 'Passw0rd51<'),
('Ragini', 'Iyer', 'ragini.iyer@example.com', 'Passw0rd52>'),
('Kamya', 'Bhat', 'kamya.bhat@example.com', 'Passw0rd53?'),
('Anika', 'Singh', 'anika.singh@example.com', 'Passw0rd54.'),
('Rohan', 'Patel', 'rohan.patel@example.com', 'Passw0rd55,'),
('Riya', 'Verma', 'riya.verma@example.com', 'Passw0rd56/'),
('Vasudha', 'Sharma', 'vasudha.sharma@example.com', 'Passw0rd57~'),
('Dhruv', 'Iyer', 'dhruv.iyer@example.com', 'Passw0rd58`'),
('Kiran', 'Mehta', 'kiran.mehta@example.com', 'Passw0rd59!'),
('Kartik', 'Nair', 'kartik.nair@example.com', 'Passw0rd60@'),
('Devika', 'Patel', 'devika.patel@example.com', 'Passw0rd61#'),
('Harsh', 'Verma', 'harsh.verma@example.com', 'Passw0rd62$'),
('Vivek', 'Singh', 'vivek.singh@example.com', 'Passw0rd63%'),
('Tanushree', 'Iyer', 'tanushree.iyer@example.com', 'Passw0rd64^'),
('Pankaj', 'Sharma', 'pankaj.sharma@example.com', 'Passw0rd65&'),
('Shravan', 'Bhat', 'shravan.bhat@example.com', 'Passw0rd66*'),
('Gauri', 'Nair', 'gauri.nair@example.com', 'Passw0rd67('),
('Siddharth', 'Patil', 'siddharth.patil@example.com', 'Passw0rd68)'),
('Riya', 'Iyer', 'riya.iyer@example.com', 'Passw0rd69-'),
('Ananya', 'Singh', 'ananya.singh@example.com', 'Passw0rd70_'),
('Shivendra', 'Verma', 'shivendra.verma@example.com', 'Passw0rd71='),
('Arnav', 'Sharma', 'arnav.sharma@example.com', 'Passw0rd72+'),
('Radha', 'Patel', 'radha.patel@example.com', 'Passw0rd73{'),
('Uday', 'Iyer', 'uday.iyer@example.com', 'Passw0rd74}'),
('Sahana', 'Bhat', 'sahana.bhat@example.com', 'Passw0rd75|'),
('Samaira', 'Verma', 'samaira.verma@example.com', 'Passw0rd76;'),
('Tanya', 'Nair', 'tanya.nair@example.com', 'Passw0rd77:'),
('Prisha', 'Mehta', 'prisha.mehta@example.com', 'Passw0rd78"'),
('Kartik', 'Singh', 'kartik.singh@example.com', 'Passw0rd79\''),
('Aditi', 'Patel', 'aditi.patel@example.com', 'Passw0rd80<'),
('Naina', 'Sinha', 'naina.sinha@example.com', 'Passw0rd81>'),
('Krishna', 'Sharma', 'krishna.sharma@example.com', 'Passw0rd82?'),
('Suryakant', 'Nair', 'suryakant.nair@example.com', 'Passw0rd83.'),
('Anika', 'Iyer', 'anika.iyer@example.com', 'Passw0rd84,'),
('Shilpa', 'Patel', 'shilpa.patel@example.com', 'Passw0rd85/'),
('Kaveri', 'Mehta', 'kaveri.mehta@example.com', 'Passw0rd86~'),
('Harsha', 'Verma', 'harsha.verma@example.com', 'Passw0rd87`'),
('Chandra', 'Singh', 'chandra.singh@example.com', 'Passw0rd88!'),
('Riya', 'Bhat', 'riya.bhat@example.com', 'Passw0rd89@'),
('Vidya', 'Sharma', 'vidya.sharma@example.com', 'Passw0rd90#'),
('Prisha', 'Nair', 'prisha.nair@example.com', 'Passw0rd91$'),
('Shubh', 'Iyer', 'shubh.iyer@example.com', 'Passw0rd92%'),
('Kamya', 'Patel', 'kamya.patel@example.com', 'Passw0rd93^'),
('Leela', 'Mehta', 'leela.mehta@example.com', 'Passw0rd94&'),
('Amit', 'Verma', 'amit.verma@example.com', 'Passw0rd95*'),
('Vasudha', 'Singh', 'vasudha.singh@example.com', 'Passw0rd96('),
('Raj', 'Bhat', 'raj.bhat@example.com', 'Passw0rd97)'),
('Bhanu', 'Sharma', 'bhanu.sharma@example.com', 'Passw0rd98-'),
('Ragini', 'Nair', 'ragini.nair@example.com', 'Passw0rd99_'),
('Kavya', 'Iyer', 'kavya.iyer@example.com', 'Passw0rd100!');

-- insert categories
INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Fashion'),
('Home & Living'),
('Health & Beauty'),
('Sports & Outdoors'),
('Books'),
('Toys & Games'),
('Automotive'),
('Jewelry'),
('Grocery');

-- insert into products
INSERT INTO Products (name, description, price, stock, category_id) VALUES
('Smartphone', 'Latest model smartphone with advanced features.', 699.99, 50, 1),
('Laptop', 'High-performance laptop for gaming and work.', 1299.99, 30, 1),
('Bluetooth Headphones', 'Wireless headphones with noise cancellation.', 199.99, 100, 1),
('Fashionable T-Shirt', 'Trendy t-shirt in various sizes and colors.', 29.99, 200, 2),
('Leather Jacket', 'Stylish leather jacket for all seasons.', 149.99, 80, 2),
('Sofa Set', 'Comfortable sofa set for living room.', 799.99, 20, 3),
('Coffee Maker', 'Automatic coffee maker for fresh brews.', 89.99, 70, 3),
('Face Cream', 'Moisturizing face cream for healthy skin.', 39.99, 150, 4),
('Running Shoes', 'Lightweight running shoes for athletes.', 89.99, 100, 5),
('Yoga Mat', 'Eco-friendly yoga mat for your workouts.', 25.99, 50, 5),
('Novel Book', 'Best-selling novel of the year.', 19.99, 120, 6),
('Children’s Toy', 'Fun and educational toy for kids.', 34.99, 200, 7),
('Action Figure', 'Collectible action figure from popular series.', 15.99, 150, 7),
('Car Cleaning Kit', 'Complete cleaning kit for your vehicle.', 49.99, 80, 8),
('Gold Necklace', 'Elegant gold necklace for special occasions.', 499.99, 25, 9),
('Organic Snacks', 'Healthy snacks made from organic ingredients.', 14.99, 300, 10),
('Tablet', 'Portable tablet with high-resolution display.', 499.99, 40, 1),
('Smartwatch', 'Feature-rich smartwatch for fitness tracking.', 249.99, 60, 1),
('Gaming Console', 'Latest gaming console with top games.', 399.99, 35, 1),
('Men’s Casual Shoes', 'Comfortable casual shoes for everyday wear.', 69.99, 90, 2),
('Women’s Handbag', 'Stylish handbag for every occasion.', 79.99, 70, 2),
('Dining Table', 'Elegant dining table for family meals.', 599.99, 15, 3),
('Blender', 'High-speed blender for smoothies and more.', 59.99, 55, 3),
('Sunscreen Lotion', 'Protective sunscreen lotion for skin.', 24.99, 200, 4),
('Fitness Tracker', 'Track your fitness goals with this device.', 99.99, 50, 5),
('Bicycle', 'Mountain bike for adventurous rides.', 299.99, 20, 5),
('Cookbook', 'Delicious recipes for every meal.', 29.99, 80, 6),
('Board Game', 'Fun board game for family nights.', 39.99, 100, 7),
('Car Vacuum Cleaner', 'Portable vacuum cleaner for car interiors.', 49.99, 45, 8),
('Silver Ring', 'Stylish silver ring for everyday wear.', 29.99, 90, 9),
('Pasta Sauce', 'Homemade-style pasta sauce in a jar.', 5.99, 200, 10),
('4K Television', 'Ultra HD television for an immersive experience.', 1499.99, 25, 1),
('Digital Camera', 'High-quality digital camera for photography.', 799.99, 15, 1),
('Wireless Earbuds', 'Compact and powerful wireless earbuds.', 149.99, 100, 1),
('Graphic Tee', 'Cool graphic t-shirt for casual wear.', 19.99, 200, 2),
('Jeans', 'Classic denim jeans for everyday wear.', 49.99, 150, 2),
('Bed Frame', 'Sturdy bed frame for a good night’s sleep.', 399.99, 20, 3),
('Vacuum Cleaner', 'Powerful vacuum cleaner for home cleaning.', 199.99, 30, 3),
('Moisturizer', 'Hydrating moisturizer for all skin types.', 34.99, 120, 4),
('Tennis Racket', 'Professional-grade tennis racket.', 89.99, 50, 5),
('Dumbbells', 'Adjustable dumbbells for home workouts.', 79.99, 60, 5),
('Self-Help Book', 'Inspiring book for personal development.', 15.99, 150, 6),
('Puzzle Game', 'Challenging puzzle game for all ages.', 24.99, 100, 7),
('Car Wax', 'Protective wax for your car’s finish.', 29.99, 75, 8),
('Diamond Earrings', 'Elegant diamond earrings for special occasions.', 599.99, 10, 9),
('Snack Box', 'Assorted snacks in a convenient box.', 19.99, 200, 10),
('Desktop Computer', 'High-performance desktop for work and play.', 1099.99, 15, 1),
('VR Headset', 'Virtual reality headset for immersive gaming.', 299.99, 25, 1),
('Action Camera', 'Durable action camera for outdoor adventures.', 199.99, 30, 1),
('Casual Hoodie', 'Comfortable hoodie for cool weather.', 39.99, 100, 2),
('Skirt', 'Trendy skirt for fashionable outings.', 49.99, 80, 2),
('Coffee Table', 'Stylish coffee table for your living room.', 199.99, 20, 3),
('Rice Cooker', 'Automatic rice cooker for perfect rice.', 49.99, 40, 3),
('Anti-Aging Cream', 'Cream for youthful skin.', 59.99, 100, 4),
('Gym Bag', 'Durable gym bag for workouts.', 39.99, 60, 5),
('Treadmill', 'Foldable treadmill for home workouts.', 699.99, 15, 5),
('Mystery Novel', 'Suspenseful mystery novel for thrill seekers.', 19.99, 100, 6),
('Family Card Game', 'Fun card game for family gatherings.', 29.99, 120, 7),
('Car Air Freshener', 'Long-lasting air freshener for your car.', 9.99, 150, 8),
('Platinum Bracelet', 'Stylish bracelet in platinum.', 499.99, 10, 9),
('Instant Noodles', 'Quick and easy instant noodles.', 1.99, 200, 10),
('Smart TV', 'Smart TV with streaming capabilities.', 799.99, 20, 1),
('Photo Printer', 'Compact printer for printing photos.', 129.99, 30, 1),
('Fitness Mat', 'Non-slip mat for yoga and exercises.', 29.99, 80, 5),
('Windbreaker Jacket', 'Lightweight windbreaker for outdoor activities.', 69.99, 50, 2),
('Formal Shirt', 'Stylish formal shirt for office wear.', 49.99, 100, 2),
('Entertainment Center', 'Spacious entertainment center for media.', 399.99, 15, 3),
('Slow Cooker', 'Versatile slow cooker for easy meals.', 79.99, 40, 3),
('Hydrating Serum', 'Serum for deep hydration.', 49.99, 100, 4),
('Baseball Glove', 'Durable glove for baseball players.', 59.99, 30, 5),
('Jump Rope', 'Speed jump rope for cardio workouts.', 15.99, 150, 5),
('Cookware Set', 'Complete cookware set for home chefs.', 199.99, 20, 3),
('Wireless Charger', 'Fast wireless charger for devices.', 29.99, 100, 1);


-- insert into orders
INSERT INTO Orders (user_id, order_date, status, total)
SELECT 
    user_id, 
    NOW() - INTERVAL FLOOR(RAND() * 100) DAY AS order_date, 
    CASE 
        WHEN RAND() < 0.25 THEN 'Pending' 
        WHEN RAND() < 0.5 THEN 'Shipped' 
        WHEN RAND() < 0.75 THEN 'Delivered' 
        ELSE 'Cancelled' 
    END AS status,
    ROUND(RAND() * 300, 2) AS total
FROM Users
ORDER BY RAND()
LIMIT 100;

-- insert into order_items
INSERT INTO Order_Items (order_id, product_id, quantity, price_at_time)
SELECT 
    o.order_id,
    p.product_id,
    FLOOR(RAND() * 5) + 1 AS quantity,  -- Random quantity between 1 and 5
    ROUND(p.price, 2) AS price_at_time  -- Price from the Products table
FROM 
    Orders o
JOIN 
    Products p ON TRUE  -- Cross join to combine each order with each product
ORDER BY 
    RAND()
LIMIT 100;


-- insert into payments

INSERT INTO Payments (order_id, payment_date, amount, payment_method, payment_status)
SELECT 
    o.order_id,
    NOW() - INTERVAL FLOOR(RAND() * 30) DAY AS payment_date,  -- Random date within the last 30 days
    ROUND(RAND() * 300, 2) AS amount,  -- Random amount between 0 and 300
    CASE 
        WHEN RAND() < 0.25 THEN 'Credit Card' 
        WHEN RAND() < 0.5 THEN 'Debit Card' 
        WHEN RAND() < 0.75 THEN 'PayPal' 
        ELSE 'Net Banking' 
    END AS payment_method,
    CASE 
        WHEN RAND() < 0.7 THEN 'Completed' 
        WHEN RAND() < 0.9 THEN 'Pending' 
        ELSE 'Failed' 
    END AS payment_status
FROM 
    Orders o
ORDER BY 
    RAND()
LIMIT 100;

-- insert into reviews

INSERT INTO Reviews (product_id, user_id, rating, review_text, review_date)
SELECT 
    p.product_id,
    u.user_id,
    FLOOR(RAND() * 5) + 1 AS rating,  -- Random rating between 1 and 5
    CONCAT('Review for product ', p.name, ': ', 
           SUBSTRING('This is a sample review text to provide feedback about the product. ', 1, 
           FLOOR(RAND() * 100) + 1)) AS review_text,  -- Random review text
    NOW() - INTERVAL FLOOR(RAND() * 30) DAY AS review_date  -- Random date within the last 30 days
FROM 
    Products p
JOIN 
    Users u ON TRUE  -- Cross join to combine each product with each user
ORDER BY 
    RAND()
LIMIT 100;


-- insert into cart
INSERT INTO Cart (user_id, product_id, quantity)
SELECT 
    u.user_id,
    p.product_id,
    FLOOR(RAND() * 5) + 1 AS quantity  -- Random quantity between 1 and 5
FROM 
    Users u
JOIN 
    Products p ON TRUE  -- Cross join to combine each user with each product
ORDER BY 
    RAND()
LIMIT 100;


