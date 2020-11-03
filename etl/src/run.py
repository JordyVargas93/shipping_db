import argparse
import __init__ as app

app.init()
etl = __import__(app.etl)

# Extraction
raw_data = etl.extract()
# Transform
processed_data = etl.transform(raw_data)
# Load
etl.load(processed_data)
