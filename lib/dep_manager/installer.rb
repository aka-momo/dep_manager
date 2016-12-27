module DepManager
  # Module responsible for:
  # - Installing Dependencies
  class Installer
    attr_reader :number_of_installed_dep

    def initialize(dependencies)
      @number_of_installed_dep = 0
      @dependencies = dependencies
      puts 'Installing Dependencies:'
      puts dependencies
      Logger.separate
      install_system_dependencies
    rescue
      Logger.error StandardError, 'Failed to install dependencies :('
    end

    private

    def install_system_dependencies
      @dependencies.each do |d|
        puts "installing #{d}"
        system DepManager::Configuration.install_command(d)
        @number_of_installed_dep += 1
      end
      Logger.log 'Thank you for using DepManager ;)'
    end
  end
end
