FROM python:3.6-slim-stretch
RUN apt update
RUN apt install -y python3-dev gcc wget
ADD metadata.json metadata.json
ADD templates templates
RUN wget "https://static.simonwillison.net/static/2018/russian-troll-tweets.db"
RUN pip install datasette
RUN pip install datasette-vega
RUN datasette inspect russian-troll-tweets.db --inspect-file inspect-data.json

EXPOSE 8001

CMD datasette serve russian-troll-tweets.db --host 0.0.0.0 --cors --port 8001 --inspect-file inspect-data.json -m metadata.json