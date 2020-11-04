-- Routes Recurrency --
-- Using origin 
SELECT
   sender_state,
   SUM(total) 
FROM
   routes_recurrency 
GROUP BY
   sender_state 
ORDER BY
   SUM DESC;

-- Using destination
SELECT
   receiver_state,
   SUM(total) 
FROM
   routes_recurrency 
GROUP BY
   receiver_state 
ORDER BY
   SUM DESC;

-- Using package type
SELECT
   package_type,
   SUM(total) 
FROM
   routes_recurrency 
GROUP BY
   package_type 
ORDER BY
   SUM DESC;

-- Using shipment type
SELECT
   shipment_type,
   SUM(total) 
FROM
   routes_recurrency 
GROUP BY
   shipment_type 
ORDER BY
   SUM DESC;


-- Routes time --
-- Using origin 
SELECT
   sender_state,
   AVG(hour_diff) 
FROM
   routes_time
GROUP BY
   sender_state 
ORDER BY
   AVG DESC;

-- Using destination
SELECT
   receiver_state,
   AVG(hour_diff) 
FROM
   routes_time
GROUP BY
   receiver_state 
ORDER BY
   AVG DESC;

-- Using package type
SELECT
   package_type,
   AVG(hour_diff) 
FROM
   routes_time
GROUP BY
   package_type 
ORDER BY
   AVG DESC;

-- Using shipment type
SELECT
   shipment_type,
   AVG(hour_diff) 
FROM
   routes_time
GROUP BY
   shipment_type 
ORDER BY
   AVG DESC;


-- Status Time --
-- You can query directly at status_type dimension/level
SELECT * FROM status_time;