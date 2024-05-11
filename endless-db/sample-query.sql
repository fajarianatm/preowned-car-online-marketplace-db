-- Transactional Query -- 
-- Case 1. Show a list of cars that were manufactured in 2015 or later.
SELECT 	product_id,
		brand,
		model,
		year,
		price
FROM product
WHERE year >= 2015
ORDER BY year;

-- Case 2. Adds one new bid data.
INSERT INTO bid(bid_id, user_id, advertisement_id, bid_price)
	VALUES(201, 17, 27, 200000000 );

INSERT INTO bid_status_log(bid_status_log_id, bid_id, bid_status, created_at)
	VALUES(259, 201, 'Sent', '2024-04-25 00:31:15.28701');
	
-- Case 3. Show all cars sold by one account from the last entered.
SELECT	user_id, 
		CONCAT(first_name, ' ', last_name) AS full_name,
		brand,
		model,
		created_at
FROM advertisement
JOIN product USING(product_id)
JOIN users USING(user_id)
WHERE CONCAT(first_name, ' ', last_name) = 'Titi Anggriawan'
GROUP BY user_id, full_name, brand, model, created_at
ORDER BY created_at DESC;

--Case 4. Search for the cheapest pre-owned car based on the keyword 'Agya'
SELECT	product_id,
		brand,
		model,
		year,
		price
FROM product
WHERE model ILIKE '%Agya%'
ORDER BY price ASC
LIMIT 1;

--Case 5. Search for the closest pre-owned car based on a city ID; 
--the nearest distance is calculated based on latitude and longitude. 
--Distance calculations can be calculated using the Euclidean distance 
--formula based on latitude and longitude.

-- Create function to measure the distance between Yogyakarta City and product
CREATE FUNCTION haversine_distance(point1 POINT, point2 POINT)
RETURNS float AS $$
DECLARE
	lon1 float := radians(point1[0]); 
	lat1 float := radians(point1[1]); 
	lon2 float := radians(point2[0]); 
	lat2 float:= radians(point2[1]);
	
	dlon float:= lon2 - lon1; 
	dlat float:= lat2 - lat1;
	a float; 
	c float;
	r float := 6371; 
	jarak float;
BEGIN
	-- haversine formula
	a := sin(dlat/2) ^2 + cos(lat1) * cos(lat2) * sin(dlon/2)^2;
	c := 2 * asin(sqrt(a));
	jarak := r * c;
	RETURN jarak;
END;
$$ LANGUAGE plpgsql;

-- Search for the closest pre-owned car
SELECT 	a.advertisement_id,
    	p.product_id,
    	p.brand,
    	p.model,
		p.year,
		p.price,
		u.username AS seller_username,
		u.location AS seller_location,
		c.location AS city_location,
		haversine_distance((SELECT location from city where city_id = 3471), u.location) AS distance
FROM advertisement AS a
JOIN product AS p USING (product_id)
JOIN users AS u USING(user_id)
JOIN city AS c USING(city_id)
ORDER BY distance
LIMIT 1;

-- Analytical Query --
-- Case 1. Ranking the popularity of car models based on the number of bids.
SELECT *
FROM bid
JOIN advertisement USING (advertisement_id)
JOIN product USING (product_id);

SELECT 	model,
		COUNT(bid_id) AS total_bid
FROM bid
JOIN advertisement USING (advertisement_id)
JOIN product USING (product_id)
GROUP BY brand, model
ORDER BY total_bid DESC;

-- Case 2. Comparing car prices based on average prices per city.
SELECT 	city_name,
   		brand,
   		model,
   		year,
   		price,
   		TRUNC(AVG(price) OVER(PARTITION BY city_name)) AS avg_car_city
FROM product
JOIN users u USING(user_id)
JOIN city USING(city_id)
GROUP BY 1,2,3,4,5;

-- Case 3. From the offer of a car model (in this case, the Toyota Agya), 
--look for a comparison of the date the user made the bid with the next bid, 
--along with the bid price given.
SELECT 	p.model,
        b.user_id,
        bs.created_at AS first_bid_date,
        b.bid_price AS first_bid_price,
        LEAD(bs.created_at) OVER (PARTITION BY p.model ORDER BY bs.created_at) AS second_bid_date,
        LEAD(b.bid_price) OVER (PARTITION BY p.model ORDER BY bs.created_at) AS second_bid_price
FROM bid_status_log AS bs
JOIN bid AS b USING (bid_id)
JOIN advertisement AS a USING (advertisement_id)
JOIN product AS p USING (product_id)
WHERE p.model = 'Toyota Agya'


-- Case 4. Calculate the percentage difference between the average price of a car model
--and the average bid price offered for that model in the last six months. 
--The average price is denoted by the term 'avg_price' 
--while the average bid price is denoted by the term 'avg_bid_6month'. 
--The difference can be positive or negative. To calculate the percentage difference, 
--you should divide the difference by the average price of the car model (avg_price), 
--and then multiply this result by 100%. The resulting figure is the difference_percent, 
--which can also be either negative or positive.
SELECT 
    brand, 
    model,
    ROUND(AVG(p.price), 2) AS avg_price,
    ROUND(AVG(CASE WHEN EXTRACT(MONTH FROM bs.created_at) >= EXTRACT(MONTH FROM CURRENT_DATE) - 6 THEN b.bid_price END), 2) AS avg_bid_6month,
    ROUND((AVG(p.price) - AVG(CASE WHEN EXTRACT(MONTH FROM bs.created_at) >= EXTRACT(MONTH FROM CURRENT_DATE) - 6 THEN b.bid_price END)), 2) AS difference,
    ROUND(((AVG(p.price) - AVG(CASE WHEN EXTRACT(MONTH FROM bs.created_at) >= EXTRACT(MONTH FROM CURRENT_DATE) - 6 THEN b.bid_price END)) / AVG(p.price)) * 100, 2) AS difference_percent
FROM  bid_status_log AS bs
JOIN  bid AS b ON bs.bid_id = b.bid_id
JOIN  advertisement AS a ON b.advertisement_id = a.advertisement_id
JOIN  product AS p ON a.product_id = p.product_id
WHERE p.brand = 'Daihatsu' AND p.model = 'Daihatsu Ayla'
GROUP BY brand, model;



--Case 5. Create a window function that calculates the average bid price for 
--the Toyota Agya model from the Toyota brand over the last six months.

SELECT
    brand,
    model,
    AVG(CASE WHEN EXTRACT(MONTH FROM bs.created_at) = EXTRACT(MONTH FROM CURRENT_DATE) - 6 THEN bid_price END) AS m_min_6,
    AVG(CASE WHEN EXTRACT(MONTH FROM bs.created_at) = EXTRACT(MONTH FROM CURRENT_DATE) - 5 THEN bid_price END) AS m_min_5,
    AVG(CASE WHEN EXTRACT(MONTH FROM bs.created_at) = EXTRACT(MONTH FROM CURRENT_DATE) - 4 THEN bid_price END) AS m_min_4,
    AVG(CASE WHEN EXTRACT(MONTH FROM bs.created_at) = EXTRACT(MONTH FROM CURRENT_DATE) - 3 THEN bid_price END) AS m_min_3,
    AVG(CASE WHEN EXTRACT(MONTH FROM bs.created_at) = EXTRACT(MONTH FROM CURRENT_DATE) - 2 THEN bid_price END) AS m_min_2,
    AVG(CASE WHEN EXTRACT(MONTH FROM bs.created_at) = EXTRACT(MONTH FROM CURRENT_DATE) - 1 THEN bid_price END) AS m_min_1
FROM bid_status_log AS bs
JOIN bid USING(bid_id) 
JOIN advertisement USING(advertisement_id)
JOIN product USING(product_id)
WHERE product.brand = 'Daihatsu' AND product.model = 'Daihatsu Ayla'
GROUP BY brand, model;

SELECT brand, model, bs.created_at 
FROM bid_status_log AS bs
JOIN bid USING(bid_id) 
JOIN advertisement USING(advertisement_id)
JOIN product USING(product_id)
ORDER BY 3 DESC;
	
-- cara lain	
WITH avg_brand_cars AS(
    SELECT
        brand,
        model,
        bs.created_at,
        EXTRACT(MONTH FROM bs.created_at) AS bid_month,
        AVG(b.bid_price) OVER(PARTITION BY brand, model ORDER BY bs.created_at) AS avg_bid
	FROM bid_status_log AS bs
	JOIN bid AS b USING(bid_id) 
	JOIN advertisement AS a USING(advertisement_id)
	JOIN product AS p USING(product_id)
	WHERE p.brand = 'Toyota' AND p.model = 'Toyota Calya'
	ORDER BY 4
)
SELECT
   brand,
   model,
   AVG(CASE WHEN bid_month = 4 THEN avg_bid ELSE NULL END) AS m_min_1,
   AVG(CASE WHEN bid_month = 3 THEN avg_bid ELSE NULL END) AS m_min_2,
   AVG(CASE WHEN bid_month = 2 THEN avg_bid ELSE NULL END) AS m_min_3,
   AVG(CASE WHEN bid_month = 1 THEN avg_bid ELSE NULL END) AS m_min_4,
   AVG(CASE WHEN bid_month = 12 THEN avg_bid ELSE NULL END) AS m_min_5,
   AVG(CASE WHEN bid_month = 11 THEN avg_bid ELSE NULL END) AS m_min_6
FROM avg_brand_cars
GROUP BY 1,2;