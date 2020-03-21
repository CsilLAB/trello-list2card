FROM ruby:2.5
WORKDIR /src
# normally I'd install from the offical repo, but my fix has not been released
# RUN gem install trello-list2card

# this is the locally built gem as a workaround
COPY . .
RUN gem build trello-list2card.gemspec &&  gem install trello-list2card-0.1.2.gem

# CMD list2card -c etc/config.toml
CMD sleep 1

FROM ruby:2.5
WORKDIR /src
COPY --from=0 /src/trello-list2card-0.1.2.gem .
RUN gem install trello-list2card-0.1.2.gem
CMD sleep 1000
