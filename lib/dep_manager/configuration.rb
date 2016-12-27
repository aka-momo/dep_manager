module DepManager
  # Module including Gem Configuration
  module Configuration
    DEP_MANGER_URL = 'https://dep-manager.herokuapp.com/api/v1/packages/fetch.json'.freeze

    LANGUAGE_FILE = {
      ruby: 'Gemfile',
      node: 'package.json'
    }.freeze

    LANGUAGE_PACKAGE = {
      ruby: 'gems',
      node: 'npms'
    }.freeze

    INSTALL_FOR_OS = {
      mac: 'brew install {package_name}',
      linux: 'sudo apt-get install {package_name}'
    }.freeze

    def self.install_command(package_name)
      INSTALL_FOR_OS[os].gsub('{package_name}', package_name)
    end

    def self.os
      case RbConfig::CONFIG['host_os']
      when /darwin|mac os/
        :mac
      when /linux/
        :linux
      else
        Logger.error StandardError, "Unknown OS: #{RbConfig::CONFIG['host_os']}"
      end
    end
  end
end
