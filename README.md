# Rails 7 + Hotwire + Tailwind CSS Boilerplate

A production-ready Rails boilerplate with Hotwire (Turbo + Stimulus), Tailwind CSS, PostgreSQL, and modern development tools.

## 📦 Stack

- **Framework**: Rails 7.1
- **Database**: PostgreSQL
- **Frontend**: Hotwire (Turbo + Stimulus)
- **Styling**: Tailwind CSS
- **JS Bundler**: esbuild
- **CSS Bundler**: Tailwind CLI
- **Authentication**: Devise
- **Authorization**: Pundit
- **Background Jobs**: GoodJob
- **Testing**: RSpec, FactoryBot, Capybara, Cuprite
- **Security**: Rack Attack, Secure Headers, Brakeman

## 🚀 Getting Started

### Prerequisites

- Ruby 3.3.5
- PostgreSQL 12+
- Node.js 18+
- npm or yarn

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd boilerplate
```

2. **Install Ruby dependencies**
```bash
bundle install
```

3. **Install JavaScript dependencies**
```bash
npm install
```

4. **Setup environment variables**
Copy `.env.example` to `.env` and configure your database and other settings:
```bash
cp .env.example .env
```

5. **Create and initialize the database**
```bash
rails db:create
rails db:migrate
rails db:seed
```

6. **Start the development server**
```bash
bin/dev
```

The application will be available at `http://localhost:3000`

## 📝 Development

### Running the full stack
```bash
bin/dev  # Runs Rails, JS watcher, and CSS watcher in parallel
```

### Individual components
```bash
# Rails server only
bin/rails server

# JavaScript watcher (esbuild)
npm run dev:js

# CSS watcher (Tailwind)
npm run dev:css
```

### Production builds
```bash
# Bundle JavaScript
npm run build

# Build Tailwind CSS
npm run build:css
```

## 🧪 Testing

### Run all tests
```bash
bundle exec rspec
```

### Run tests with coverage
```bash
bundle exec rspec --format coverage
```

### Run system tests (Capybara + Cuprite)
```bash
bundle exec rspec spec/system
```

## 🔒 Security

- **Rack Attack**: Rate limiting and DDoS protection
- **Secure Headers**: Content Security Policy, X-Frame-Options, etc.
- **Brakeman**: Static security analysis for Rails
- **Bundler Audit**: Checks for known vulnerabilities in dependencies

Run security checks:
```bash
bundle exec brakeman
bundle exec bundler-audit
```

## 🎨 Styling

Tailwind CSS is pre-configured and watched in development. Add custom styles in:
```
app/assets/stylesheets/application.tailwind.css
```

## 🔗 Frontend Structure

### Controllers (Stimulus)
Add Stimulus controllers in `app/javascript/controllers/`

```javascript
// app/javascript/controllers/hello_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello controller connected!")
  }
}
```

Use in views with `data-controller`:
```erb
<div data-controller="hello">
  <input type="text" data-action="input->hello#greet">
</div>
```

## 📚 Key Gems

| Gem | Purpose |
|-----|---------|
| `devise` | User authentication |
| `pundit` | Authorization & permissions |
| `good_job` | Background job processing |
| `lograge` | Structured logging |
| `pg_search` | Full-text search on PostgreSQL |
| `friendly_id` | SEO-friendly URLs |
| `paper_trail` | Model versioning & audit trail |
| `pagy` | Lightweight pagination |
| `meta-tags` | SEO meta tags |
| `rspec-rails` | Testing framework |

## 📊 Monitoring

### Health checks
```
GET /health
```

Powered by `okcomputer` gem.

### Query analysis
Install `bullet` to detect N+1 queries in development:
```bash
# Runs in development by default
# Check Rails logs for warnings
```

### Performance profiling
```ruby
# Add to controller/view
Rack::MiniProfiler.allow_authorization = true
```

## 🛠 Development Tools

- **Annotate**: Adds schema comments to models
  ```bash
  bundle exec annotate
  ```

- **Letter Opener**: Preview emails in development
  Automatically opens in browser when email is sent

- **Cuprite**: Headless Chrome for faster system tests

## 📦 Deployment

### Environment variables needed for production

```bash
DB_HOST=your-postgres-host
DB_USERNAME=postgres-user
DB_PASSWORD=secure-password
DB_NAME=boilerplate_production
RAILS_ENV=production
RAILS_LOG_TO_STDOUT=true
SECRET_KEY_BASE=<generate-with: rails secret>
```

### Build for production
```bash
npm run build
npm run build:css
bundle exec rails assets:precompile
```

## 📝 Additional Resources

- [Rails Guides](https://guides.rubyonrails.org)
- [Hotwire Documentation](https://hotwired.dev)
- [Tailwind CSS](https://tailwindcss.com)
- [Devise Wiki](https://github.com/heartcombo/devise/wiki)
- [Pundit Authorization](https://github.com/varvet/pundit)

## 📄 License

MIT
