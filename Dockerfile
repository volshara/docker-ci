FROM python:3.8

ENV PYTHONUNBUFFERED 1


WORKDIR /sepulkariy

COPY ./requirements.txt .

RUN pip install --no-cache-dir pip-tools -r requirements.txt uwsgi

COPY /src .  

RUN ./manage.py collectstatic --noinput

USER nobody

CMD uwsgi --master --http :8000 --module app.wsgi --processes 5 --harakiri 20 
