require 'gemnasium/parser'
module DepManager
  # Module responsible for:
  # - loading packages
  # - parsing packages
  class Parser
    attr_reader :packages, :file_name, :content

    def initialize(langauge = :ruby)
      @file_name = Configuration::LANGUAGE_FILE[langauge]
      load_file
      send Configuration::LANGUAGE_PACKAGE[langauge]
    end

    private

    def load_file
      @content = File.open(file_name).read
    rescue
      Logger.error LoadError, "Error Loading #{file_name}"
    end

    def gems
      @packages = Gemnasium::Parser.gemfile(content)
                                   .dependencies.map(&:name)
    rescue => e
      Logger.error e, "Error parsing #{file_name}"
    end

    def npms
      parsed_package_json = JSON.parse(content)
      @packages = parsed_package_json['devDependencies'].keys
    rescue
      Logger.error StandardError, "Error parsing #{file_name}"
    end
  end
end
