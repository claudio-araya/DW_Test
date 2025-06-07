CREATE TABLE customer (
    username VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    address TEXT,
    birthdate TEXT,
    email VARCHAR(100)
);

CREATE TABLE account (
    account_id BIGINT PRIMARY KEY,
    limit_amount NUMERIC
);

CREATE TABLE customer_account (
    username VARCHAR(50) REFERENCES customer(username),
    account_id BIGINT REFERENCES account(account_id),
    PRIMARY KEY (username, account_id)
);

CREATE TABLE product (
    product_name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE account_product (
    account_id BIGINT REFERENCES account(account_id),
    product_name VARCHAR(50) REFERENCES product(product_name),
    PRIMARY KEY (account_id, product_name)
);

CREATE TABLE tier (
    tier_id UUID PRIMARY KEY,  
    username VARCHAR(50) REFERENCES customer(username),
    tier_name VARCHAR(50),  
    active BOOLEAN
);

CREATE TABLE benefit (
    benefit_name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE tier_benefit (
    tier_id UUID REFERENCES tier(tier_id),
    benefit_name VARCHAR(100) REFERENCES benefit(benefit_name),
    PRIMARY KEY (tier_id, benefit_name)
);

CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id BIGINT NOT NULL,
    transaction_date TEXT NOT NULL,
    amount INT NOT NULL,
    transaction_code VARCHAR(4) CHECK (transaction_code IN ('buy', 'sell')),
    symbol VARCHAR(10),
    price DECIMAL(20, 40),
    total DECIMAL(20, 40),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);



