FROM python:3.6-slim-stretch
RUN apt update
RUN apt install -y python3-dev gcc wget
ADD metadata.json metadata.json
RUN wget -nv "https://static.simonwillison.net/static/2018/russian-troll-tweets.db"
RUN pip install datasette datasette-vega datasette-block-robots datasette-graphql
RUN datasette inspect russian-troll-tweets.db --inspect-file inspect-data.json

EXPOSE $PORT

CMD datasette serve russian-troll-tweets.db --host 0.0.0.0 --cors --port $PORT --inspect-file inspect-data.json -m metadata.json --setting default_page_size 50 --setting sql_time_limit_ms 3000 --setting facet_time_limit_ms 3000 --setting force_https_urls on
