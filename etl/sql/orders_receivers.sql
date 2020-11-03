SELECT
   so.order_id,
   state."name" as receiver_state
FROM
   shipping_db.shipment_order so
   JOIN
      shipping_db.address_orders ao
      ON so.receiver_address_id = ao.address_id
   JOIN
      shipping_db.neighborhood nb
      ON ao.nbhd_id = nb.nbhd_id
   JOIN
      shipping_db.city
      ON nb.nbhd_id = city.city_id
   JOIN
      shipping_db.state
      ON city.state_id = state.state_id
