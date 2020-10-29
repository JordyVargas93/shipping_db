-- Add test state
INSERT INTO shipping_db.state
(state_id, "name")
VALUES(1, 'CDMX');

-- Add test city
INSERT INTO shipping_db.city
(city_id, "name", state_id)
VALUES(1, 'Cuauhtémoc', 1);

-- Add test neighborhood
INSERT INTO shipping_db.neighborhood 
(nbhd_id , "name", zip_code, city_id)
VALUES(1, 'Juárez', 06600, 1);

-- Add tests address
INSERT INTO shipping_db.address_orders
(street, "number", address_string, address_details, nbhd_id)
VALUES('Londres', '49', 'Edificio Riva Palacio, Piso 5 entre Manuel González y Flores Magón', 'Entrada A, la del oxxo', 1);

INSERT INTO shipping_db.address_orders
(street, "number", address_string, address_details, nbhd_id)
VALUES('Sonora', '113', 'Edificio Fondeadora', 'Edificio Fondeadora', 1);

-- Add test package type
INSERT INTO shipping_db.package_type
(package_type_id, "name")
VALUES(1, 'Caja');

-- Add test shipment type
INSERT INTO shipping_db.shipment_type
(shipment_type_id, "name", delivery_time)
VALUES(1, 'Estándar', '2 days');

-- Add test order
INSERT INTO shipping_db.shipment_order
(weight, dimension, package_type_id, sender_name, receiver_name, sender_address_id, receiver_address_id, shipment_type_id)
VALUES(5.6, '9x10x25', 1, 'Jordy Vargas', 'Fondeadora', 1, 2, 1);

-- Add test status_catalog
INSERT INTO shipping_db.status_catalog
(status_catalog_id, "name")
VALUES(1, 'Orden recibida');

-- Add test status
INSERT INTO shipping_db.status
(status_catalog_id, order_id, registered_at, notes)
VALUES(1, 1, '2020-04-12 04:05:06', 'EMPTY');
