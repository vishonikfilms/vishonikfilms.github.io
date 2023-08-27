# Use an official Ruby runtime as the base image
FROM ruby:2.7

# Create a non-root user
RUN groupadd -r jekyll && useradd -r -g jekyll jekyll

# Set the working directory inside the container
WORKDIR /app

# Create the .jekyll-cache directory
RUN mkdir -p /app/.jekyll-cache
RUN chmod -R 777 /app/.jekyll-cache

# Install system dependencies
RUN apt-get update && \
    apt-get install -y build-essential nodejs

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Jekyll and Bundler
RUN gem install bundler:2.4.7
RUN bundle install

# Change ownership to the non-root user
RUN chown -R jekyll:jekyll /app

# Switch to the non-root user
USER jekyll

# Expose the default Jekyll port (4000) and BrowserSync port (3000)
EXPOSE 4000 3000

# Command to start Jekyll with BrowserSync for live reload
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload"]
