FROM ruby:latest
MAINTAINER Jonathan Claudius
RUN apt-get update && \
    apt-get install -y nmap
COPY ./bin /app/bin
COPY ./lib /app/lib
COPY ./nmap_agent.gemspec /app/nmap_agent.gemspec
COPY ./Gemfile /app/Gemfile
RUN cd /app && \
    gem install bundler && \
    bundle install
RUN chmod +x /app/bin/scan