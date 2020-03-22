FROM ruby:2.5-alpine AS build
WORKDIR /src
# normally I'd install from the offical repo, but my fix has not been released
# RUN gem install trello-list2card

# this is the locally built gem as a workaround
RUN apk add --update-cache \
  alpine-sdk \
  git \
  libstdc++

COPY . .
RUN gem build trello-list2card.gemspec &&  gem install trello-list2card-0.1.2.gem

# CMD list2card -c etc/config.toml
CMD sleep 1

FROM ruby:2.5-alpine
WORKDIR /src
COPY --from=build /usr/local/bundle/ /usr/local/bundle/
CMD sleep 1000
