module DepManager
  # Module including Gem Configuration
  module Configuration
    DEP_MANGER_URL = 'http://localhost:3000/path_to_url.json'.freeze

    LANGUAGE_FILE = {
      ruby: 'GemFile',
      node: 'package.json'
    }.freeze

    LANGUAGE_PACKAGE = {
      ruby: 'gems',
      node: 'npms'
    }.freeze

    INSTALL_FOR_OS = {
      mac: 'brew install {package_name}',
      linix: 'apt-get install {package_name}'
    }.freeze

    def self.install_command(os, package_name)
      INSTALL_FOR_OS[os].gsub('{package_name}', package_name)
    end
  end
end
