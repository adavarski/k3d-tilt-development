FROM python:3.10.5-alpine3.16

COPY ./scripts/start.sh /start.sh
RUN chmod +x /start.sh

RUN mkdir -p /app
WORKDIR /app

COPY ./requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

COPY ./app /app
ENV PYTHONPATH=/app

ENTRYPOINT /start.sh
