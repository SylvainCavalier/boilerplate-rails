require "capybara/cuprite"

# Headless Chrome driver for system specs (faster than Selenium, no webdriver).
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [ 1400, 1400 ],
    headless: %w[0 false].exclude?(ENV["HEADLESS"]),
    process_timeout: 20,
    timeout: 15
  )
end

Capybara.default_max_wait_time = 5

RSpec.configure do |config|
  # Plain (non-JS) system specs use the fast rack_test driver...
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  # ...and specs tagged `js: true` get a real headless browser.
  config.before(:each, type: :system, js: true) do
    driven_by :cuprite
  end
end
