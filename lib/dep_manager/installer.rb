module DepManager
  # Module responsible for:
  # - Installing Dependencies
  module Installer
    class << self
      def run(dependencies)
        # TODO
        puts 'Installing Dependencies:'
        puts dependencies
        Logger.separate
        dependencies.each do |d|
          puts "installing #{d}"
          system DepManager::Configuration.install_command(d)
        end
      end
    end
  end
end
