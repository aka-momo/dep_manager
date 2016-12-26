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

    def initialize
      @packages     = DepManager::Parser.run
      @dependencies = DepManager::Fetcher.run(@packages)
      @installed    = DepManager::Installer.run(@dependencies)
    end
  end
end
