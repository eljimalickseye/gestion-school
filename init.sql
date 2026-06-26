-- Create database if not exists (MySQL 8.0)
CREATE DATABASE IF NOT EXISTS school_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create user if not exists
CREATE USER IF NOT EXISTS 'utilisateur_apiRest1'@'%' IDENTIFIED BY 'Security@21';

-- Grant privileges
GRANT ALL PRIVILEGES ON school_db.* TO 'utilisateur_apiRest1'@'%';

-- Flush privileges
FLUSH PRIVILEGES;