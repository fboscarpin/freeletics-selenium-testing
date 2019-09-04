require 'selenium-webdriver'

#Instance the driver
Selenium::WebDriver::Chrome::Service.driver_path='/usr/local/bin/chromedriver'
options = Selenium::WebDriver::Chrome::Options.new
$driver = Selenium::WebDriver.for :chrome, options: options
$driver.manage.window.maximize
$driver.manage.timeouts.implicit_wait = 10 #seconds

#Hook
After ('@CloseTest') do
	$driver.quit
end
