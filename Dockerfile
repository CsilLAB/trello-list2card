FROM ruby:2.5
WORKDIR /src
# normally I'd install from the offical gem repo, but my fix has not been released
# RUN gem install trello-list2card
# I have a forked repo instead and build the image from that.
COPY . .
RUN gem build trello-list2card.gemspec &&  gem install trello-list2card-0.1.2.gem

CMD sleep 1

FROM ruby:2.5
WORKDIR /src
COPY --from=0 /src/trello-list2card-0.1.2.gem .
RUN gem install trello-list2card-0.1.2.gem
CMD list2card -c etc/config.toml
