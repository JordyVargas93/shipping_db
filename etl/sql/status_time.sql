SELECT
   so.order_id,
   MAX(sc."name") AS status_name,
   status.status_catalog_id,
   MAX(status.registered_at) AS registered_at
FROM
   shipping_db.shipment_order so
   JOIN
      shipping_db.status USING(order_id)
   JOIN
      shipping_db.status_catalog sc USING(status_catalog_id)
GROUP BY
   so.order_id,
   status.status_catalog_id
