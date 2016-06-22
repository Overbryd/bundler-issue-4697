FROM alpine:3.4
ENV ALPINE_RUBY_VERSION=2.3.1-r0

RUN apk update \
  && apk upgrade \
  && apk add --no-cache bash \
  tzdata \
  yaml \
  readline \
  ruby=$ALPINE_RUBY_VERSION \
  ruby-io-console=$ALPINE_RUBY_VERSION \
  ruby-irb=$ALPINE_RUBY_VERSION \
  && echo 'gem: --no-rdoc --no-ri' > /etc/gemrc \
  && gem update --system \
  && gem install bundler

RUN adduser -D -s /bin/bash app app \
  && mkdir /home/app/current \
  && chown app:app /home/app/current
WORKDIR /home/app/current

COPY Gemfile /home/app/current/Gemfile
COPY Gemfile.lock /home/app/current/Gemfile.lock

USER app

RUN mkdir ~/.bundle \
  && bundle config --global path ~/gems \
  && bundle install --retry=3 --no-cache --clean --frozen --jobs=4 \
  && rm -rf /home/app/current/.bundle

CMD /bin/bash

