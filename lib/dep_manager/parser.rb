require 'gemnasium/parser'
module DepManager
  # Module responsible for:
  # - loading packages
  # - parsing packages
  module Parser
    class << self
      def run(langauge = :ruby)
        @file_name = Configuration::LANGUAGE_FILE[langauge]
        @content   = load_file
        send Configuration::LANGUAGE_PACKAGE[langauge]
      end

      private

      def load_file
        File.open(@file_name).read
      rescue
        raise LoadError, @file_name
      end

      def gems
        Gemnasium::Parser.gemfile(@content).dependencies.map(&:name)
      rescue
        raise SyntaxError, @file_name
      end

      def npms
        raise 'Npms Not supported yet'
      end
    end
  end
end
