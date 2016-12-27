module DepManager
  # Module responsible for:
  # - Logging Errors, Warnings, Messages
  module Logger
    class << self
      def error(e, message)
        puts 'Opsss !!'
        puts message
        raise e
      end

      def warn(message)
        puts 'Warning:'
        puts message
      end

      def log(message)
        puts message
      end

      def separate(char = '-')
        puts char * 100
      end
    end
  end
end
