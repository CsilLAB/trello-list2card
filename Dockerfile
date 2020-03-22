ARG RUBY_VERSION=2.5-alpine

FROM ruby:${RUBY_VERSION} as build
WORKDIR /src
# normally I'd install from the offical gem repo, but my fix has not been released
# RUN gem install trello-list2card
# I have a forked repo instead and build the image from that.

RUN apk add --update-cache \
  alpine-sdk \
  git \
  libstdc++

COPY . .
RUN gem build trello-list2card.gemspec &&  gem install trello-list2card-0.1.2.gem

CMD sleep 1

FROM ruby:${RUBY_VERSION}
WORKDIR /src
COPY --from=build /usr/local/bundle/ /usr/local/bundle/
CMD list2card -c etc/config.toml
