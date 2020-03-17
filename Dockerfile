FROM ruby:2.5
WORKDIR /src
# normally I'd install from the offical repo, but my fix has not been released
# RUN gem install trello-list2card

# this is the locally built gem as a workaround
COPY trello-list2card-0.1.2.gem .
RUN gem install trello-list2card-0.1.2.gem

# CMD list2card -c etc/config.toml
CMD sleep 1000
