CREATE TABLE city(
	city_id INTEGER PRIMARY KEY,
	city_name VARCHAR(255) UNIQUE NOT NULL,
	location POINT NOT NULL
);

CREATE TABLE users(
	user_id SERIAL PRIMARY KEY,
	city_id INTEGER NOT NULL,
	username VARCHAR(255) UNIQUE NOT NULL,
	first_name VARCHAR(255) NOT NULL, 
	last_name VARCHAR(255),
	email VARCHAR(255) UNIQUE NOT NULL,
	phone_number VARCHAR(20) NOT NULL,
	address TEXT,
	location POINT,
	is_verified BOOLEAN,
	UNIQUE (first_name, last_name),
	CONSTRAINT fk_city_user
		FOREIGN KEY(city_id)
		REFERENCES city(city_id)
);

CREATE TABLE product(
	product_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	brand VARCHAR(255) NOT NULL,
	model VARCHAR(255) NOT NULL,
	colour VARCHAR(20) NOT NULL,
	body_type VARCHAR(50) NOT NULL,
	transmission VARCHAR(20) NOT NULL,
	year INTEGER NOT NULL,
	price INTEGER NOT NULL CHECK (price > 0),
	picture TEXT NOT NULL,
	CONSTRAINT fk_user_product
		FOREIGN KEY(user_id)
		REFERENCES users(user_id)
);

CREATE TABLE advertisement(
	advertisement_id SERIAL PRIMARY KEY,
	product_id INTEGER NOT NULL,
	title TEXT NOT NULL,
	description TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL,
	is_bid_allowed BOOLEAN NOT NULL,
	CONSTRAINT fk_product_advertisement
		FOREIGN KEY(product_id)
		REFERENCES product(product_id)
);
ALTER TABLE advertisement 
ADD CONSTRAINT unique_product_id UNIQUE(product_id);

CREATE TABLE bid(
	bid_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	advertisement_id INTEGER NOT NULL,
	bid_price INTEGER NOT NULL CHECK (bid_price > 0),
	CONSTRAINT fk_user_bid
		FOREIGN KEY(user_id)
		REFERENCES users(user_id),
	CONSTRAINT fk_advertisement_bid
		FOREIGN KEY(advertisement_id)
		REFERENCES advertisement(advertisement_id)
);

CREATE TABLE bid_status_log(
	bid_status_log_id SERIAL PRIMARY KEY,
	bid_id INTEGER NOT NULL,
	bid_status VARCHAR(20) NOT NULL DEFAULT 'Sent',
	created_at TIMESTAMP NOT NULL,
	CONSTRAINT fk_bid_bidstatus
		FOREIGN KEY(bid_id)
		REFERENCES bid(bid_id)
);


SELECT * FROM city;
SELECT * FROM users;
SELECT * FROM product;
SELECT * FROM advertisement;
SELECT * FROM bid;
SELECT * FROM bid_status_log;