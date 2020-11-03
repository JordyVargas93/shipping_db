SELECT
   order_id,
   status.registered_at AS last_ts
FROM
   shipping_db.shipment_order so
   JOIN
      status USING(order_id)
   JOIN
      status_catalog sc USING(status_catalog_id)
WHERE
   sc.status_catalog_id = 9
