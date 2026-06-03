source "https://rubygems.org"

ruby "3.4.8"

# Core Rails framework
gem "rails", "~> 8.1.3"

# Database - PostgreSQL adapter
gem "pg", ">= 1.5"

# Web server
gem "puma", ">= 5.0"

# Asset pipeline - Propshaft serves fingerprinted assets (Rails 8 default).
# Compilation/bundling is handled upstream by esbuild + Tailwind (see below).
gem "propshaft"

# JavaScript bundling - esbuild for fast builds
gem "jsbundling-rails"

# CSS bundling - Tailwind CSS integration
gem "cssbundling-rails"

# Hotwire: Turbo for fast navigation without full page reloads
gem "turbo-rails"

# Hotwire: Stimulus for lightweight JavaScript framework
gem "stimulus-rails"

# JSON rendering for API responses
gem "jbuilder"

# Standard library gems no longer bundled by default in recent Rubies
gem "ostruct"
gem "benchmark"

# Boot time optimization through caching
gem "bootsnap", require: false

# Environment variables management
gem "dotenv-rails"

# Timezone data for Windows systems
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Image processing for Active Storage variants
gem "image_processing", "~> 1.2"

# Clean, structured logging for production
gem "lograge"

# Authentication - user login/signup
gem "devise"

# Authorization - permission management
gem "pundit"

# Rate limiting and DDoS protection
gem "rack-attack"

# Security headers (CSP, X-Frame-Options, etc.)
gem "secure_headers"

# Lightweight pagination without unnecessary joins
gem "pagy"

# Full-text search on PostgreSQL
gem "pg_search"

# SEO-friendly URLs (e.g., /posts/my-post-title instead of /posts/1)
gem "friendly_id"

# Meta tags for SEO (title, description, OG tags)
gem "meta-tags"

# Model versioning and audit trail
gem "paper_trail"

# Rails 8 Solid stack: background jobs, cache and Action Cable backed by the
# database - no Redis required, runs on a single Postgres (Heroku/Scalingo).
gem "solid_queue"
gem "solid_cache"
gem "solid_cable"

# Web dashboard for Solid Queue jobs
gem "mission_control-jobs"

# Health check endpoint for monitoring and orchestration
gem "okcomputer"

group :development, :test do
  # Interactive debugger for development
  gem "debug", platforms: %i[ mri windows ]
  
  # RSpec testing framework
  gem "rspec-rails"
  
  # Factory fixtures for consistent test data
  gem "factory_bot_rails"
  
  # Fake data generation for tests
  gem "faker"
end

group :development do
  # Interactive error page with console
  gem "web-console"
  
  # Performance profiler for development
  gem "rack-mini-profiler"
  
  # Detect N+1 query problems in development
  gem "bullet"
  
  # Add comments in models with schema information
  gem "annotate"
  
  # Security vulnerability scanner for gems
  gem "bundler-audit"
  
  # Preview emails in development without sending
  gem "letter_opener"
end

group :test do
  # System testing framework
  gem "capybara"
  
  # Headless Chrome driver for faster system tests (replaces Selenium)
  gem "cuprite"
  
  # One-liners for testing validations and associations
  gem "shoulda-matchers"
end

group :development, :test do
  # Static code analyzer for Rails security issues
  gem "brakeman"
end
