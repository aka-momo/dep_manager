require 'dep_manager/configuration'
require 'dep_manager/parser'
require 'dep_manager/fetcher'
require 'dep_manager/installer'
module DepManager
  # Class responsible for the flow:
  # 1. Parse
  # 2. Fetch
  # 3. Install
  class Runner
    attr_reader :packages, :dependencies, :installed

    def initialize(argv)
      language      = (argv == 'node' ? :node : :ruby)
      @packages     = DepManager::Parser.new(language).packages
      @dependencies = DepManager::Fetcher.new(@packages).server_dependencies
      DepManager::Installer.new(@dependencies)
    end
  end
end
