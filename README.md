# Pluoa Mapper

Pluoa Mapper is a lib to manage easily elements mapped inside pages.  
Just keep your files organized and clean with Pluoa Mapper

## Installation
In https://rubygems.org/gems/pluoa-mapper you find the gem or just install:

```
gem install pluoa-mapper
```


## Configuration
After installed, you have to require the gem and include the class in your env.rb file:

```
require 'yaml'
require 'pluoa-mapper'

include PluoaMapper
```


You need to set the following value to inform where is your mapping(YML files) in your env.rb file:

```
ENV["PAGES_MAPPING_PATH"] = ""

# Example:
ENV["PAGES_MAPPING_PATH"] = "features/support/pages_mapping/"

# Inside the folder pages_mapping contains YML files with elements mapped
```

## How it works?
Easy, just create your directory where you will put your mapping files, I suggest you name the folder **"pages_mapping"**.

Once you created the folder you are able to create the YML files, like:

```
> pages_mapping   
  > home_page.yml   
  > login_page.yml   
  > ...   
```

```
 # home_page.yml
 
  sign_in_button: "AppCompatButton id:'sign_in_button'"
  sign_out_button: "AppCompatButton id:'sign_out_button'"
  title_text: "CustomFontTextView id:'app_title'"
```

When you wanto to use in your code, just do it:
```
 # home_page.rb
 
 class HomePage
    def touch_on_sign_in
      # You are able to use Meglish gem:
      touch_and_keyboard_text_element(get_mapping(self, "sign_in_button"), "root")

      # or just Calabash:
      wait_for_element_exists(get_mapping "LoginPage", "username")
      touch(get_mapping "LoginPage", "username")
      keyboard_enter_text("root")
      hide_soft_keyboard
    end
 end
```

Pluoa Mapper is really good when you are working with Cucumber, because you may create your pattern to work easily. Like:

```
Feature: Search
  
  Scenario: Search for a generic product
    Given I am on HomePage
    When I touch on search button in HomePage
    And I fill "Shoes" in search field in HomePage
    When I enter
    Then I should see products related to my search
```

```
Steps Generated:

  Given(/^I am on HomePage$/) do
    pending # Write code here that turns the phrase above into concrete actions
  end

  # Step updated:
  When(/^I touch on ([\w\s]+) in ([\w]+Page)$/) do |_field, _page|
    touch_element(get_mapping(_page, _field))
  end

  When(/^I fill "([^"]*)" in ([\w\s]+) in ([\w]+Page)$/) do |_value, _field, _page|
    touch_and_keyboard_text_element(get_mapping(_page, _field), _value)
  end

  When(/^I enter$/) do
    pending # Write code here that turns the phrase above into concrete actions
  end

  Then(/^I should see products related to my search$/) do
    pending # Write code here that turns the phrase above into concrete actions
  end
``` 

Just keep in mind, if you want to use self in the PageObject file, your file name must be the same than YML file.  
For instance:  

``` 
  Page Object: HomePage.rb
  Mapping File: home_page.yml
``` 
