SELECT
   order_id,
   state."name" as sender_state,
   pt."name" as package_type,
   st."name" as shipment_type,
   status.registered_at AS origin_time
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
   JOIN
      shipping_db.package_type pt
      ON pt.package_type_id = so.package_type_id
   JOIN
      shipping_db.shipment_type st
      ON st.shipment_type_id = so.shipment_type_id
WHERE
   sc.status_catalog_id = 1