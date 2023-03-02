ARG  RUBY_VERSION="${./blog/.ruby-version}"
# FROM ruby:2.7.3
FROM ruby:$RUBY_VERSION
## Deal with it later.

## Install required OS packages for the existing dependencies
#RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=shared \
    --mount=type=cache,target=/var/lib/apt,sharing=shared \
    apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Create the application directory
RUN mkdir /myapp

WORKDIR /myapp

# Copy source code to the application directory
COPY blog/ /myapp

# Install all the application dependencies
RUN bundle install

# Run the rails server
CMD ["rails", "server"]
