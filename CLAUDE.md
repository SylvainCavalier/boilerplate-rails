# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A **Rails 8.1 SSR boilerplate** (Hotwire + Tailwind + PostgreSQL) used as the starting point for freelance client projects. Clone it, rename the app module, and build on it.

Stack: Rails 8.1.3, Ruby 3.4.8, Node 22, PostgreSQL, Hotwire (Turbo + Stimulus), Tailwind CSS v4, esbuild (JS bundling), Propshaft (asset serving), Puma.

Pre-wired: **Devise** auth (`User` with an `admin` boolean), **Pundit** authorization (`ApplicationPolicy`), **Solid Queue/Cache/Cable**, **Mission Control – Jobs** dashboard, **RSpec** + FactoryBot + Cuprite, **RuboCop omakase**, GitHub Actions CI.

The app module is `BoilerplateRails` in `config/application.rb` — rename it when starting a real project.

## Commands

```bash
bin/setup                # install deps, prepare DB, then start bin/dev (use --skip-server to stop before booting)
bin/dev                  # full dev stack (Rails + esbuild watch + Tailwind watch) via Procfile.dev
bin/rails server         # Rails only

bin/ci                   # run the whole CI pipeline locally (see config/ci.rb)
bin/rubocop              # lint (omakase); add -A to autocorrect
bin/brakeman             # static security scan
bin/bundler-audit        # dependency CVE scan

bin/rails db:prepare     # create + migrate (idempotent); db:seed for the dev admin
bundle exec rspec                          # all specs
bundle exec rspec spec/path/to_spec.rb     # one file
bundle exec rspec spec/path/to_spec.rb:42  # one example by line

npm run build && npm run build:css         # production asset bundles
```

## Architecture notes

**Asset pipeline** — JS/CSS are *bundled* (no importmap), then *served* by Propshaft (no Sprockets):
- `npm run build` → esbuild bundles `app/javascript/*.*` into `app/assets/builds/` (ESM).
- `npm run build:css` → Tailwind v4 CLI compiles `app/assets/stylesheets/application.tailwind.css` → `app/assets/builds/application.css`.
- Propshaft fingerprints and serves everything under `app/assets/`. After editing JS/CSS, the relevant `bin/dev` watcher must be running or the build is stale.
- Stimulus controllers live in `app/javascript/controllers/`. JS deps are managed with **npm** (not yarn).

**Solid stack (single database)** — Solid Queue, Solid Cache and Solid Cable all run on the **primary** Postgres (no separate queue/cache/cable databases), so the app deploys to a single Postgres on Heroku/Scalingo. Their tables are created by regular migrations (`db/migrate/*_create_solid_*`), not separate schema files. Active Job uses `:solid_queue` in production only (development stays on `:async`/memory). Don't reintroduce `connects_to` overrides in `cache.yml`/`cable.yml`/`production.rb`.

**Jobs dashboard** — Mission Control is mounted at `/jobs`, restricted in `config/routes.rb` to signed-in admins via a Devise `authenticate :user, ->(u){ u.admin? }` constraint (non-admins get 404). `db:seed` creates `admin@example.com` / `password123` in development.

**Auth & authz** — Devise `User` (modules: database_authenticatable, registerable, recoverable, rememberable, validatable). Styled Devise views live in `app/views/devise/`. `ApplicationController` includes `Pundit::Authorization` and rescues `Pundit::NotAuthorizedError`. Write policies in `app/policies/`.

**Security headers** — CSP is configured natively in `config/initializers/content_security_policy.rb` (nonce-based for inline script/style; the `secure_headers` gem was removed). `rack-attack` is bundled but not yet configured.

## CI

`bin/ci` (Rails 8.1 `ActiveSupport::ContinuousIntegration`, defined in `config/ci.rb`) runs RuboCop → bundler-audit → Brakeman → RSpec → seeds. `.github/workflows/ci.yml` just sets up Ruby/Node/Postgres and runs `bin/ci` — keep `config/ci.rb` as the single source of truth.

## Testing convention

Per the user's global workflow: write and run tests **after** finishing a feature (so the UI can be tested manually first). RSpec + FactoryBot + Faker (back), Capybara + Cuprite/headless Chrome for system specs (tag examples `js: true` to drive a real browser; plain system specs use rack_test).

## Deployment

Heroku by default; Scalingo when French hosting is required (both CLIs available locally). Buildpack deploy uses `Procfile` (`release: rails db:prepare`, `web: puma`, `worker: bin/jobs`). A `Dockerfile` is also maintained. Production env vars: `DB_*`, `SECRET_KEY_BASE` (or `RAILS_MASTER_KEY`), `APP_HOST` (mailer URLs), `MISSION_CONTROL_JOBS_*` is no longer needed (admin-gated). See `.env.example`. Lograge gives structured logs; `/up` is the health endpoint.
