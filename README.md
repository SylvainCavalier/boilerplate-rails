# Rails 8 + Hotwire + Tailwind CSS Boilerplate

A production-ready Rails 8.1 SSR boilerplate: Hotwire (Turbo + Stimulus), Tailwind CSS v4, PostgreSQL, Devise + Pundit, the Solid stack, and a ready-to-run CI pipeline.

## 📦 Stack

- **Framework**: Rails 8.1 (Ruby 3.4)
- **Database**: PostgreSQL
- **Frontend**: Hotwire (Turbo + Stimulus)
- **Styling**: Tailwind CSS v4
- **Assets**: esbuild (JS bundling) + Tailwind CLI (CSS), served by Propshaft
- **Authentication**: Devise (`User` with an `admin` flag)
- **Authorization**: Pundit
- **Jobs / Cache / Cable**: Solid Queue, Solid Cache, Solid Cable (single database, no Redis)
- **Jobs dashboard**: Mission Control – Jobs (`/jobs`, admin-only)
- **Testing**: RSpec, FactoryBot, Faker, Capybara, Cuprite
- **Quality / Security**: RuboCop omakase, Brakeman, bundler-audit, Rack::Attack, native CSP

## 🚀 Getting Started

### Prerequisites

- Ruby 3.4.8
- PostgreSQL 14+
- Node.js 22

### Installation

```bash
git clone <repository-url>
cd boilerplate-rails

cp .env.example .env   # adjust DB credentials if needed
bin/setup              # installs gems + npm deps, prepares the DB, starts the dev server
```

`bin/setup` ends by launching `bin/dev`. Pass `--skip-server` to stop before booting. The app runs at http://localhost:3000.

A development admin (`admin@example.com` / `password123`) is created by `bin/rails db:seed`, giving access to the `/jobs` dashboard.

## 📝 Development

```bash
bin/dev            # Rails + JS watcher + CSS watcher (Procfile.dev)
bin/rails server   # Rails only
npm run dev:js     # esbuild watch
npm run dev:css    # Tailwind watch
```

JavaScript dependencies are managed with **npm**. Stimulus controllers live in `app/javascript/controllers/`.

## 🧪 Testing & CI

```bash
bundle exec rspec                       # all specs
bundle exec rspec spec/foo_spec.rb:42   # one example

bin/ci             # full pipeline locally: RuboCop, bundler-audit, Brakeman, RSpec, seeds
bin/rubocop -A     # lint + autocorrect
```

CI runs on GitHub Actions (`.github/workflows/ci.yml`) by invoking `bin/ci` — the pipeline is defined once in `config/ci.rb`.

System specs use headless Chrome via Cuprite; tag an example `js: true` to drive a real browser (plain system specs use the faster rack_test driver).

## 🎨 Styling

Tailwind v4 source lives in `app/assets/stylesheets/application.tailwind.css`; it compiles to `app/assets/builds/application.css`. Propshaft fingerprints and serves the built files.

## ⚙️ Background jobs (Solid Queue)

Active Job uses Solid Queue in production (development stays on the async adapter). Everything runs on the **primary** Postgres database — no Redis, no extra databases — so the app deploys to a single managed Postgres. The worker process is `bin/jobs`.

## 🔒 Security

- **Native CSP** in `config/initializers/content_security_policy.rb` (nonce-based)
- **Brakeman** static analysis and **bundler-audit** dependency CVE scan (both in `bin/ci`)
- **Rack::Attack** bundled (add your throttles in an initializer)

## 📦 Deployment

Buildpack deploy (Heroku / Scalingo) via `Procfile`:

```
release: bundle exec rails db:prepare
web: bundle exec puma -C config/puma.rb
worker: bundle exec ./bin/jobs
```

Production environment variables (see `.env.example`): `DB_*`, `SECRET_KEY_BASE` (or `RAILS_MASTER_KEY`), `APP_HOST` (used to build mailer URLs). `/up` is the health-check endpoint.

A multi-stage `Dockerfile` is also maintained for container deploys.

## 📄 License

MIT
