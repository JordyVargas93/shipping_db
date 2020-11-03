import pandas as pd
from connections.psql import Psql

psql = Psql()


def extract():
    senders = psql.get_result_set('orders_senders')
    receivers = psql.get_result_set('orders_receivers')
    orders = pd.merge(senders, receivers, on='order_id')

    return orders


def transform(raw_data):
    recurrency = raw_data.groupby([
        'sender_state',
        'receiver_state',
        'package_type',
        'shipment_type']).size().reset_index()
    recurrency.rename(columns={0: 'total'}, inplace=True)

    return recurrency


def load(processed_data):
    psql.save_data(processed_data, 'routes_recurrency')
