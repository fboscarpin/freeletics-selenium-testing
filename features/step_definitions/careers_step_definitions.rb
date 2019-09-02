#GIVEN STEPS

Given(/^the user opens the website Freeletics$/) do
  $driver.navigate.to("https://www.freeletics.com/en/")
end

Given(/^the user accessed the Careers area$/) do
  $driver.navigate.to("https://www.freeletics.com/en/corporate/")
end

Given(/^the user accessed the Vacancies list$/) do
  $driver.navigate.to("https://www.freeletics.com/en/corporate/jobs/")
end


#WHEN STEPS

#Generic click on a footer link by text
When(/^the user clicks on the footer link "([^"]*)"$/) do |text|
  $driver.find_element(:xpath,"//a[span[contains(.,'"+text+"')] and @data-analytics-ga-subcategory='footer-links']").click()
end

#Generic click on a button/menu by text
When(/^the user clicks on "([^"]*)"$/) do |text|
  $driver.find_element(:xpath,"//a[contains(.,'"+text+"')]").click()  
end

#Switches to the next browser tab
When(/^the user switches tabs$/) do
  $driver.switch_to.window($driver.window_handles.last)
end


#THEN STEPS

#Assert a text on the page
Then(/^the user sees the text "([^"]*)" on the page$/) do |expected_text|
  #First, wait for an element containing the text in the HTML code. It ensures the page has loaded the element
  wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  wait.until {
    element = $driver.find_element(:xpath,"//*[contains(.,'"+expected_text+"')]")
    element if element.displayed?
    #Assert if the expected text is being shown
    expect($driver.page_source).to include(expected_text)
  }    
end

#Assert a text on the Position title field
Then(/^the user sees the job title "([^"]*)"$/) do |expected_text|
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  text = wait.until {
    element = $driver.find_element(:xpath,"//h1[@itemprop='title']")
    element if element.displayed?
  }.text
  expect(text).to eq(expected_text)
end

#Assert a text on the Position location field
Then(/^the user sees the job location "([^"]*)"$/) do |expected_text|
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  text = wait.until {
    element = $driver.find_element(:xpath,"//span[@itemprop='jobLocation']")
    element if element.displayed?
  }.text
  expect(text).to eq(expected_text)
end

#Assert the amount of responsibilities listed
Then(/^the user sees "([^"]*)" items in the Your Responsibilities section$/) do |expected_amount|
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  wait.until {
    amount_items = $driver.find_elements(:xpath => "//section[@itemprop='responsibilities']/ul/li").length
    expect(amount_items.to_s).to eq(expected_amount)
  } 
end

#Assert the amount of experience requirements listed
Then(/^the user sees "([^"]*)" items in the Your Profile section$/) do |expected_amount|
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  wait.until {
    amount_items = $driver.find_elements(:xpath => "//section[@itemprop='experienceRequirements']/ul/li").length
    expect(amount_items.to_s).to eq(expected_amount)
  }  
end