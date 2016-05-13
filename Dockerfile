FROM ruby:2.2.1
MAINTAINER Bugs Bunny <bbunny@rubyplus.com>

RUN apt-get update && \
    apt-get install -y net-tools

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
ENV PORT 9292
EXPOSE 9292
CMD ["rackup"]
