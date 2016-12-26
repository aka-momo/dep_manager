require 'dep_manager/version'
require 'dep_manager/logger'
require 'dep_manager/runner'
require 'rbconfig'

# Main Module
module DepManager
  def self.os
    case RbConfig::CONFIG['host_os']
    when /darwin|mac os/
      :mac
    when /linux/
      :linux
    else
      Logger.error Error::WebDriverError, "Unknown OS: #{host_os.inspect}"
    end
  end
end
