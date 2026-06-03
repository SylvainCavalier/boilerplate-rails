# Production process types for Heroku / Scalingo (buildpack deploy).
# `release` runs once per deploy, before the new release boots.
release: bundle exec rails db:prepare
web: bundle exec puma -C config/puma.rb
worker: bundle exec ./bin/jobs
