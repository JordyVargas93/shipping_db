import argparse
import os

etl = None


def __set_arguments():
    global etl

    parser = argparse.ArgumentParser()
    parser.add_argument('--etl', type=str, nargs=1,
                        help='ETL to execute')

    args = parser.parse_args()

    if args.etl:
        etl = args.etl[0]


def init():
    __set_arguments()
    abspath = os.path.abspath(__file__)
    dname = os.path.dirname(abspath)
    os.chdir(dname)
