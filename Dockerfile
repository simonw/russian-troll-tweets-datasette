FROM python:3.6-slim-stretch
RUN apt update
RUN apt install -y python3-dev gcc wget
ADD metadata.json metadata.json
RUN wget -nv "https://static.simonwillison.net/static/2018/russian-troll-tweets.db"
RUN pip install datasette
RUN pip install datasette-vega
RUN datasette inspect russian-troll-tweets.db --inspect-file inspect-data.json

EXPOSE 8001

CMD datasette serve russian-troll-tweets.db --host 0.0.0.0 --cors --port $PORT --inspect-file inspect-data.json -m metadata.json --config default_page_size:50 --config sql_time_limit_ms:3000 --config num_sql_threads:10 --config facet_time_limit_ms:3000 --config allow_sql:off --config force_https_urls:1
