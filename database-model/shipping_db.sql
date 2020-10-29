CREATE SCHEMA shipping_db AUTHORIZATION postgres;


--shipping_db.state--

--definition
CREATE TABLE shipping_db.state (
	state_id int4 NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT state_pk PRIMARY KEY (state_id)
);


--shipping_db.status_catalog--

--definition
CREATE TABLE shipping_db.status_catalog (
	status_catalog_id int4 NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT status_catalog_pk PRIMARY KEY (status_catalog_id)
);

--shipping_db.package_type--

--definition
CREATE TABLE shipping_db.package_type (
	package_type_id int4 NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT package_type_pk PRIMARY KEY (package_type_id)
);

--shipping_db.shipment_type--

--definition
CREATE TABLE shipping_db.shipment_type (
	shipment_type_id int4 NOT NULL,
	"name" varchar NOT NULL,
	delivery_time interval(0) NOT NULL,
	CONSTRAINT shipment_type_pk PRIMARY KEY (shipment_type_id)
);

--shipping_db.city--

--definition
CREATE TABLE shipping_db.city (
	city_id int4 NOT NULL,
	"name" varchar NOT NULL,
	state_id int4 NOT NULL,
	CONSTRAINT city_pk PRIMARY KEY (city_id)
);

--foreign keys
ALTER TABLE shipping_db.city ADD CONSTRAINT fk_city_state_id FOREIGN KEY (state_id) REFERENCES shipping_db.state(state_id);


--shipping_db.neighborhood--

--definition
CREATE TABLE shipping_db.neighborhood (
	nbhd_id int4 NOT NULL,
	"name" varchar NOT NULL,
	city_id int4 NOT NULL,
	zip_code int4 NOT NULL,
	CONSTRAINT neighborhood_pk PRIMARY KEY (nbhd_id)
);

--foreign keys
ALTER TABLE shipping_db.neighborhood ADD CONSTRAINT fk_neighborhood_city_id FOREIGN KEY (city_id) REFERENCES shipping_db.city(city_id);

--shipping_db.address_orders--

--definition
CREATE TABLE shipping_db.address_orders (
	address_id bigserial NOT NULL,
	street varchar NULL,
	"number" varchar NULL,
	address_string varchar NULL,
	address_details varchar NULL,
	nbhd_id int4 NOT NULL,
	CONSTRAINT address_orders_pk PRIMARY KEY (address_id)
);

--foreign keys
ALTER TABLE shipping_db.address_orders ADD CONSTRAINT fk_address_nbhd_id FOREIGN KEY (nbhd_id) REFERENCES shipping_db.neighborhood(nbhd_id);

--indexes
CREATE INDEX address_orders_nbhd_id_idx ON shipping_db.address_orders USING btree (nbhd_id);

--shipping_db.shipment_order--

--definition
CREATE TABLE shipping_db.shipment_order (
	order_id bigserial NOT NULL,
	weight float4 NOT NULL,
	dimension varchar NOT NULL,
	package_type_id int4 NOT NULL,
	sender_name varchar NOT NULL,
	receiver_name varchar NOT NULL,
	sender_address_id int8 NOT NULL,
	receiver_address_id int8 NOT NULL,
	shipment_type_id int4 NOT NULL,
	CONSTRAINT shipment_order_pk PRIMARY KEY (order_id)
);

--foreign keys
ALTER TABLE shipping_db.shipment_order ADD CONSTRAINT fk_shipment_order_package_type_id FOREIGN KEY (package_type_id) REFERENCES shipping_db.package_type(package_type_id);
ALTER TABLE shipping_db.shipment_order ADD CONSTRAINT fk_shipment_order_sender_address_id FOREIGN KEY (sender_address_id) REFERENCES shipping_db.address_orders(address_id);
ALTER TABLE shipping_db.shipment_order ADD CONSTRAINT fk_shipment_order_receiver_address_id FOREIGN KEY (receiver_address_id) REFERENCES shipping_db.address_orders(address_id);
ALTER TABLE shipping_db.shipment_order ADD CONSTRAINT fk_shipment_order_shipment_type_id FOREIGN KEY (shipment_type_id) REFERENCES shipping_db.shipment_type(shipment_type_id);

--indexes
CREATE INDEX shipment_order_sender_address_id_idx ON shipping_db.shipment_order USING btree (sender_address_id);
CREATE INDEX shipment_order_receiver_address_id_idx ON shipping_db.shipment_order USING btree (receiver_address_id);


--shipping_db.status--

--definition
CREATE TABLE shipping_db.status (
	status_id bigserial NOT NULL,
	status_catalog_id int4 NOT NULL,
	order_id int8 NOT NULL,
	registered_at timestamp(0) NOT NULL,
	notes varchar NULL,
	CONSTRAINT status_pk PRIMARY KEY (status_id)
);

--foreign keys
ALTER TABLE shipping_db.status ADD CONSTRAINT fk_status_order_id FOREIGN KEY (order_id) REFERENCES shipping_db.shipment_order(order_id);
ALTER TABLE shipping_db.status ADD CONSTRAINT fk_status_status_catalog_id FOREIGN KEY (status_catalog_id) REFERENCES shipping_db.status_catalog(status_catalog_id);
