FROM ruby:latest
MAINTAINER Jonathan Claudius
RUN apt-get update && \
    apt-get install -y nmap
COPY ./lib/nmap_agent/version.rb /app/lib/nmap_agent/version.rb
COPY ./nmap_agent.gemspec /app/nmap_agent.gemspec
COPY ./Gemfile /app/Gemfile
RUN cd /app && \
    gem install bundler && \
    bundle install
COPY ./bin /app/bin
COPY ./lib /app/lib
RUN chmod +x /app/bin/scan