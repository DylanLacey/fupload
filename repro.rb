require "selenium-webdriver"

def un
  ENV["SAUCE_USERNAME"]
end

def pw
	ENV["SAUCE_ACCESS_KEY"]
end

def auth
	"#{un}:#{pw}"
end

def server
	"ondemand.saucelabs.com"
end

def port
	80
end

def endpoint
	"http://#{auth}@#{server}:#{port}/wd/hub"
end

def caps
	{
		"platform" => "WINDOWS 7",
		"browserName" => "Firefox",
		"version" => 47
	}
end

driver = Selenium::WebDriver.for :remote, :url => endpoint,  :desired_capabilities => caps


driver.navigate.to "http://localhost:3000/users/new"

driver.file_detector = lambda do |args|
   # args => ["/path/to/file"]
   str = args.first.to_s    
   str if File.exist?(str)
end

upload = driver.find_element :css, "#user_profile_image"
upload_path = File.join Dir.pwd, 'sample.txt'
upload.send_keys upload_path

clicky = driver.find_element :css, '#new_user > input[type="submit"]:nth-child(5)'
clicky.click

driver.quit