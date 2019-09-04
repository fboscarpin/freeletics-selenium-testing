# frozen_string_literal: true

require 'selenium-webdriver'
require 'appium_lib'

desired_caps = {
  caps: {
    platformName: 'Android',
    platformVersion: '9',
    deviceName: 'emulator-5554',
    browserName: 'Chrome'
  }
}

# Android driver
$appium_driver = Appium::Driver.new(desired_caps, true)
$driver = $appium_driver.start_driver
Appium.promote_appium_methods Object

# Instance the driver
# Selenium::WebDriver::Chrome::Service.driver_path='/usr/local/bin/chromedriver'
# options = Selenium::WebDriver::Chrome::Options.new
# $driver = Selenium::WebDriver.for :chrome, options: options
# $driver.manage.window.maximize
# $driver.manage.timeouts.implicit_wait = 10 #seconds

# Hook
After ('@CloseTest') do
  $driver.quit
end
