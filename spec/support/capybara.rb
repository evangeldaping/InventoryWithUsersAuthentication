# Overwrite the reistration of the default selenium_chrome_headless so we can specify additional options
# https://about.gitlab.com/2017/12/19/moving-to-headless-chrome/
# https://sites.google.com/a/chromium.org/chromedriver/capabilities
# https://peter.sh/experiments/chromium-command-line-switches/#silent-launch
#
Capybara.register_driver(:chrome_headless) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => {
      'args' => %w[--headless --disable-gpu --silent-launch --window-size=1280,1280]
    },
    'goog:loggingPrefs' => {
      'browser' => 'ALL',
      'driver' => 'WARNING'
    } # INFO level on browser logs to capture console.log()
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end
# Useful for debugging, will open a chrome window that you can fully interacte with that is helpful to use with pry.
# See after(:each) config below for js debbuging output to the console with this driver
Capybara.register_driver(:chrome) do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
# Configure rspec to use drivers.
RSpec.configure do |config|
  # Use rack_test for system tests without JS
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
  # Use selenium chrome headless for system tests having JS
  config.before(:each, type: :system, js: true) do
    driven_by :chrome_headless
  end
  config.before(:each, type: :system, chrome: true) do
    driven_by :chrome
  end
  # Log javascript errors to the console in the :chrome driver
  config.after(:each, type: :system, js: true, chrome: true) do
    errors = page.driver.browser.manage.logs.get(:browser)
    if errors.present?
      message = errors.map(&:message).join("\n")
      puts message
    end
  end
  # Clear the screenshot folder before the suite runs to make it
  # easier to see the failed screenshots.
  config.before(:suite) do
    directory = Rails.root.join('tmp/screenshots')
    FileUtils.remove_dir(directory) if File.directory?(directory)
  end
end
