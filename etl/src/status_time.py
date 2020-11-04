import pandas as pd

from connections.psql import Psql

psql = Psql()


def extract():
    status = psql.get_result_set('status_time')

    return status


def transform(raw_data):
    status = pd.DataFrame()

    for order_id in raw_data.order_id.unique():
        orders = raw_data[raw_data.order_id == order_id]. \
            sort_values('status_catalog_id').reset_index()

        for idx, order in orders.iterrows():
            if idx < len(orders) - 1:
                hour_diff = (orders.iloc[idx + 1].registered_at - order.registered_at) / pd.Timedelta(hours=1)
                status = status.append({'status_id': order.status_catalog_id,
                                        'status_name': order.status_name,
                                        'hour_diff': hour_diff},
                                       ignore_index=True)

    status = status.groupby(['status_id', 'status_name'])['hour_diff'].mean().reset_index()

    return status


def load(processed_data):
    psql.save_data(processed_data, 'status_time')
