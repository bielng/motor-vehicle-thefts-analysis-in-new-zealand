-- OBJECTIVE 3Identify where vehicles are likely to be stolen
-- Find the number of vehicles that were stolen in each region
USE stolen_vehicles_db;

SELECT * FROM stolen_vehicles;
SELECT * FROM locations;

SELECT region, COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l
	ON sv.location_id = l.location_id
GROUP BY region;

-- Combine the previous output with the population and density statistics for each region

SELECT l.region, COUNT(sv.vehicle_id) AS num_vehicles,
	l.population, l.density
FROM stolen_vehicles sv LEFT JOIN locations l
	ON sv.location_id = l.location_id
GROUP BY l.region, l.population, l.density
ORDER BY num_vehicles DESC;

-- Do the types of vehicles stolen in the three most dense regions differ from the three least dense regions?

'Auckland', '1638', '1695200', '343.09'
'Nelson', '92', '54500', '129.15'
'Wellington', '420', '543500', '67.52'

'Otago', '139', '246000', '7.89'
'Gisborne', '176', '52100', '6.21'
'Southland', '26', '102400', '3.28'


SELECT l.region, COUNT(sv.vehicle_id) AS num_vehicles,
	l.population, l.density
FROM stolen_vehicles sv LEFT JOIN locations l
	ON sv.location_id = l.location_id
GROUP BY l.region, l.population, l.density
ORDER BY l.density DESC;

-- High density region , number of vehicle_type stolen (Auckland, Nelson and Wellington)
(SELECT 'High Density',sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l
	ON sv.location_id = l.location_id
WHERE l.region IN ('Auckland','Nelson','Wellington')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5)

UNION

-- Low density region , number of vehicle_type stolen (Auckland, Nelson and Wellington)
(SELECT 'Low Density', sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l
	ON sv.location_id = l.location_id
WHERE l.region IN ('Otago','Gisborne','Southland')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5);



-- Create a scatter plot of population versus density, and change the size of the points based on the number of vehicles stolen in each region

-- Create a map of the regions and color the regions based on the number of stolen vehicles