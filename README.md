# Part I - The automated test suite

Using Selenium WebDriver to create a test suite that ensures the Freeletics Career
website is displaying the QA Engineer job description properly.


## How this test suite is organized

This testing framework uses Cucumber, Selenium em Ruby.

The test cases written in BDD format can be found in the file "features/careers.feature". The implementation of these test cases can be found in the file "features/step_definitions/careers_step_definitions.rb". The file "features/support/env.rb" has the driver initialization code.

The Gemfile is the configuration file that will tell Bundler what gems to install.

The folder "drivers" has the chromedriver.



## Instructions to setup on Ubuntu (Linux)

1. Download/clone the project

2. Install Ruby. In Ubuntu, you can do that by executing the following command on the terminal:

        sudo apt-get install ruby-full

3. Install Bundler using the command:
    
        sudo gem install bundler

4. In order to use Bundler with the current version of Ruby (2.5.1 in Ubuntu), you need to update RubyGems. You can do that by running the command:
        
        gem update --system

5. Install the dependencies (gems) using the command in the project's root folder:
    
        bundler install

6. Run the tests by executing the following command in the project's root folder:
        
        cucumber

The Chrome browser will launch and the tests will be executed.


## Instructions to create a Report (it's optional):

If you want to generate a report, run the following command in the project' root folder:
        
        cucumber --format pretty --expand --format json -o "reports/report.json" && ruby reports/report_builder.rb

Then, the file "cucumber_web_report.html" will be generated in the folder "reports".




# Part II - Using Appium

### 1. Which parts of the code you provided would need to be adapted to run the same tests in an Android phone, using the same browser, in the tool you chose?

I would use the Appium tool for this purpose.

The first change would be in the env.rb file. Instead of setting up the "chromedriver", we need to configure the call for the Appium Server. To do that, we need to add the Desired Capabilities for an Android device. We also need to set the drivers for Appium and Selenium, and require the library "appium_lib".

Therefore, the env.rb file should be:
    
    require 'selenium-webdriver'
    require 'appium_lib'

    desired_caps = {
        caps:  {
            platformName:  'Android',
            platformVersion: '9.0',
            deviceName:    'Pixel 2 API 28',
            browserName:   'Chrome',
        }
    }    
    
    $appium_driver = Appium::Driver.new(desired_caps)   
    $driver = @appium_driver.start_driver  
    Appium.promote_appium_methods Object 

    After ('@CloseTest') do
	    $driver.quit
    end

We need to use "promote_appium_methods" to make calls without using "@appium_driver" before the commands. It's not mandatory, but if we don't do that, we would need to use "$appium_driver" before every Selenium command, like this: $appium_driver.$driver.navigate.to("https://www.freeletics.com/en/")
    

Besides the changes in our code, we also would need to add the following steps to the setup process:

- Ensure you have Java installed (it's required for Android SDK)

- Install Android Studio

- Install Android SDK Manager    

- Install Node.js (to support the Appium Client)

- Install the Appium Client. We can add the following line in our Gemfile: gem 'appium_lib', '~> 10.4'

- Create an Android Virtual Device with Android Virtual Device Manager



### 2. How could we run these tests in a physical android phone connected to your laptop? Does the laptop need any extra software/hardware to run them properly?

To run our test suite in a real device, we need to specify the "deviceName" in the desired capabilities.

We can find the device's name by executing the following command on the terminal:
        
    adb devices

In my case, I got the following output:
        
    List of devices attached
    J6AXB764Y690Y3M	device

Then, we need to change the deviceName (in the env.rb file) as follows:

    desired_caps = {
        caps:  {
            platformName:  'Android',
            platformVersion: '9.0',
            deviceName:    'J6AXB764Y690Y3M',
            browserName:   'Chrome',
        }
    }

The computer doesn't need any additional software. We only need to have the device connected to the computer when we run the tests.



### 3. What would be the main changes if the website was now part of a hybrid android app?

If some parts of our application have webview or native contexts, we need to set the proper context before running a test command. 

For example, our application may have the webview context "WEBVIEW_1" in a specific area. So, we need to specify this context before running a command in the areas where this context exists.

We can use two approaches to set the native/webview contexts:

1. We can set the context during the implementation of the test steps. In our code to access the website Freeletics, we could switch to the WEBVIEW_1 context, for example:

        Given(/^the user opens the website Freeletics$/) do
            $driver.switch_to.context("WEBVIEW_1")
            <command to access the website. It can be a tap on a button, for example>
        end

2. If the application already starts in the webview area, we can set this context as default in the desired capabilities configuration:

    autoWebview: true

This mode will always use the webview context when we launch the tests. We can switch to the native context when needed.    


### 4. And if it was a native app?

To run the tests for a native app, the desired capabilities need to specify "app", "appPackage" and "appActivity". 

For a native app, we don't need to require "selenium-webdriver", and we don't set the Selenium driver. 

The env.rb file shoud be:

    require 'appium_lib'

    desired_caps = {
        caps:  {
            platformName:  'Android',
            platformVersion: '9.0',
            deviceName:    'Pixel 2 API 28',
            app: (File.join(File.dirname(_FILE_), "app_name.apk")),
            appPackage: com.ab.app_name,
            appActivity: AppActivityName
        }
    }    
    
    Appium::Driver.new(desired_caps)   
    Appium.promote_appium_methods Object 

    After ('@CloseTest') do
	    $driver.driver_quit
    end

We also need to change the test implementations, because we interact with the elements in a different way in the native app. On the mobile browser, we used the Selenium driver ($driver) to run a command. In a native application, we can run the commands without specifying the driver. For example, to click on a button, we can use the following instruction:

    find_element(:id,"button_id").click() 