FROM python:3.12.4-bookworm as build-mysqlclient

RUN apt update && apt install -y build-essential default-libmysqlclient-dev git

RUN cd / && git clone https://github.com/PyMySQL/mysqlclient.git /mysqlclient && git checkout v2.2.4

WORKDIR /mysqlclient

RUN python3 setup.py bdist_wheel && find dist -name "*.whl" -exec cp {} dist/ \;

FROM python:3.12.4-slim-bookworm as python-with-mysqlclient

RUN mkdir -p /tmp/mysqlclient

COPY --from=build-mysqlclient /mysqlclient/dist/* /tmp/mysqlclient/

RUN apt update && apt install -y default-libmysqlclient-dev nginx-full vim && pip install /tmp/mysqlclient/*

CMD ["python3"]