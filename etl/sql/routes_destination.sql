SELECT
   order_id,
   state."name" as receiver_state,
   status.registered_at AS dest_time
FROM
   shipping_db.shipment_order so
   JOIN
      shipping_db.status USING(order_id)
   JOIN
      shipping_db.status_catalog sc USING(status_catalog_id)
   JOIN
      shipping_db.address_orders ao
      ON so.sender_address_id = ao.address_id
   JOIN
      shipping_db.neighborhood nb
      ON ao.nbhd_id = nb.nbhd_id
   JOIN
      shipping_db.city
      ON nb.nbhd_id = city.city_id
   JOIN
      shipping_db.state
      ON city.state_id = state.state_id
WHERE
   sc.status_catalog_id = 9