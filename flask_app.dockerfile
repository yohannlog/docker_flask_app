FROM ubuntu:18.04

RUN apt-get update && \
	apt-get install -y python3 python3-pip &&\
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY app/ /opt/app

WORKDIR /opt/app

RUN pip3 install -r requirements.txt
EXPOSE 5000

ENV PYTHONUNBUFFERED=1
ENV FLASK_APP=myapp
ENV VERSION=1
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN flask init-db

RUN useradd flask 
USER flask
CMD ["gunicorn","-b", "0.0.0.0:5000", "myapp:create_app()"]
