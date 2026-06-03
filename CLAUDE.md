# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A **Rails 7.1 SSR boilerplate** (Hotwire + Tailwind + PostgreSQL) used as the starting point for freelance client projects. It is meant to be cloned and built on, not run as-is.

Stack: Rails 7.1, Ruby 3.3.5, PostgreSQL, Hotwire (Turbo + Stimulus), Tailwind CSS v4, esbuild (JS bundling), Puma.

## Important: gems are installed but NOT wired up

The Gemfile declares the intended toolkit, but most generators have **not** been run yet. As of the initial commit there is:
- no `db/migrate/` and no schema (run `rails db:create` first)
- no `spec/` directory — RSpec is in the Gemfile but `rails generate rspec:install` has not run (the default Minitest `test/` scaffold is still present)
- no Devise config/User model, no Pundit `ApplicationPolicy`, no GoodJob/Rack::Attack/SecureHeaders initializers
- a bare `ApplicationController < ActionController::Base`

When a feature needs one of these, run the gem's installer first (`rails g devise:install`, `rails g pundit:install`, `rails g good_job:install`, etc.). Don't assume the integration exists — check.

Note: the app module is `BoilerplateRails` in `config/application.rb` — rename it when starting a real project.

## Commands

```bash
bin/dev                  # full dev stack (Rails + esbuild JS watch + Tailwind CSS watch) via Procfile.dev
bin/rails server         # Rails only
npm run dev:js           # esbuild watch only
npm run dev:css          # Tailwind watch only

rails db:create db:migrate db:seed

bundle exec rspec                          # all specs (once rspec:install has run)
bundle exec rspec spec/path/to_spec.rb     # one file
bundle exec rspec spec/path/to_spec.rb:42  # one example by line

bundle exec brakeman        # static security scan
bundle exec bundler-audit   # dependency CVE scan
bundle exec annotate        # write schema comments into models

npm run build && npm run build:css   # production asset bundles
```

## Asset pipeline

JS and CSS are **bundled, not imported via importmap**:
- `npm run build` → esbuild bundles `app/javascript/*.*` into `app/assets/builds/` (ESM).
- `npm run build:css` → Tailwind CLI compiles `app/assets/stylesheets/application.tailwind.css` → `app/assets/builds/application.css`.
- Sprockets serves the files in `app/assets/builds/`. After editing JS/CSS, the relevant watcher (run by `bin/dev`) must be running, or the build is stale.
- Stimulus controllers live in `app/javascript/controllers/`.

## Testing convention

Per the user's global workflow: write and run tests **after** finishing a feature (so the UI can be tested manually first without surprises). Tooling intended for tests: RSpec + factory_bot + Faker (back), Capybara + Cuprite/headless Chrome (system). shoulda-matchers for model one-liners.

## Deployment

Heroku by default; Scalingo when French hosting is required (both CLIs available locally). A `Dockerfile` is also present. Production expects `DB_HOST`/`DB_USERNAME`/`DB_PASSWORD`/`DB_NAME`, `SECRET_KEY_BASE`, `RAILS_LOG_TO_STDOUT`. Lograge provides structured logs; `/up` is the health endpoint (`rails/health#show`).
