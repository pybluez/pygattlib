FROM ubuntu:16.04
ARG PYTHON_VERSION=3

COPY src /pygattlib/src
COPY setup.py /pygattlib/setup.py
WORKDIR /pygattlib

RUN apt-get -qq update \
    && [[ $PYTHON_VERSION = 3 ]] && export PYTHON_PACKAGE_SUFFIX=3 || export PYTHON_PACKAGE_SUFFIX= \
    && echo "Python Version:\t$PYTHON_VERSION\t\tPackage Suffix:\t$PYTHON_PACKAGE_SUFFIX" \
    && apt-get -y install libbluetooth-dev libboost-python-dev libboost-thread-dev libglib2.0-dev \
        python$PYTHON_PACKAGE_SUFFIX-dev build-essential python$PYTHON_PACKAGE_SUFFIX-virtualenv \
        python$PYTHON_PACKAGE_SUFFIX \
    && virtualenv -p `which python$PYTHON_VERSION` venv \
    && venv/bin/python setup.py install

CMD ["/pygattlib/venv/bin/python", "-c", "import gattlib"]