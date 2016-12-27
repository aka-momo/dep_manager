# DepManager Gem
[![Build Status](https://travis-ci.org/mohameddiaa27/dep_manager.svg?branch=master)](https://travis-ci.org/mohameddiaa27/dep_manager)
[![Test Coverage](https://codeclimate.com/github/mohameddiaa27/dep_manager/badges/coverage.svg)](https://codeclimate.com/github/mohameddiaa27/dep_manager/coverage)
[![Code Climate](https://codeclimate.com/github/mohameddiaa27/dep_manager/badges/gpa.svg)](https://codeclimate.com/github/mohameddiaa27/dep_manager)

DepManager gem provides the ability to determine system-level packages required to build native extensions. It collects all local gems (or npm packages) in your project and sends them to a web server to determine/install the system libraries you need.

##### Supported Languages & Operating Syetems:
The gem currently supports debian OS (like ubuntu) and Mac OS. It can either parse Gemfile (ruby) or package.json (node).

## Installation

To install a gem from githib, first you need to install `specific_install`

```ruby
$ gem install specific_install
```

Then you can install the gem (prefered in your global gemset) by:

```ruby
$ gem specific_install -l https://github.com/mohameddiaa27/dep_manager.git
```


## Usage

First you need to navigate to the project path containing the **Gemfile** or the **package.json** file.

```ruby
$ cd TO/PROJECT/PATH
```
Then all you need to do is run the following command.
Passing **OPTION** `ruby` or `node`

```ruby
$ dep_manage OPTION
```

For Example:

```ruby
$ dep_manage node
```

And Woohooo, Watch the Magic !!

(Note: if you don't provide the option, the gem will assume that you are using ruby)

## Development

### Intro

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Design

The gem consists of the following classes and modules (in the **lib** directory):

1. **Runner** Class: is the main class, responsible for the whole flow. It basically calls the classes in the folloing sequence:
	- **Parser**
	- **Fetcher**
	- **Installer**
2. **Parser** Class: responsible for parsing either a gemfile or packages.json file. Then collects the packages names.

3. **Fetcher** Class: responsible for collecting system dependencies by sending the following:
	- package names (collected by Fetcher)
	- operating system
	- language

	to the web server [Dependency Manager Portal](https://dep-manager.herokuapp.com). It also serves friendly messages (like stating what packages are not found in the server). The portal is also open source, and you can contribute through the repo [here](https://github.com/mohameddiaa27/dep_manager_server).

4. **Installer** Class: responsible for installing the fetched dependencies using homebrew or apt-get.

5. **Configuration** Module: contains static variables and helper functions related to the language and the operating system.

6. **Logger** Module: a helper module, responsible for logging friendly messages to the user.
	- Errors
	- Warnings
	- Messages

## Todo
- Auto detect language
- Support more languages
- Port the gem to nodejs npm package

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dep_manager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

