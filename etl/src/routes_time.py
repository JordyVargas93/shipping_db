import pandas as pd
from connections.psql import Psql

psql = Psql()


def extract():
    origin = psql.get_result_set('routes_origin')
    destination = psql.get_result_set('routes_destination')
    orders = pd.merge(origin, destination, on='order_id')

    return orders


def transform(raw_data):
    raw_data['hour_diff'] = (raw_data.dest_time - raw_data.origin_time) / pd.Timedelta(hours=1)
    routes_time = raw_data.groupby([
        'sender_state',
        'receiver_state',
        'package_type',
        'shipment_type'])['hour_diff'].mean().reset_index()
    routes_time.rename(columns={0: 'avg_hours'}, inplace=True)

    return routes_time


def load(processed_data):
    psql.save_data(processed_data, 'routes_time')
