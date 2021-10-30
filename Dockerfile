
FROM ruby:3.0.2-alpine

WORKDIR /app

RUN apk update \
  && apk upgrade \
  && apk add \
    bash \
    build-base \
    tzdata \
    postgresql-client \
    postgresql-dev \
  && rm -rf /var/cache/apk/*

RUN gem install bundler -v 2.2.30
COPY . /app/
