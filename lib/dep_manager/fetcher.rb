module DepManager
  # Module responsible for:
  # - sending:
  # => - packages
  # => - os
  # - fetching:
  # => - System Dependencies
  module Fetcher
    class << self
      def run(packages, language = :ruby)
        @language = language
        fetch(packages)
      end

      private

      def fetch(packages)
        os  = DepManager.os
        uri = URI(Configuration::DEP_MANGER_URL)
        res = Net::HTTP.post_form(
          uri,
          packages: packages,
          os: os,
          language: @language
        )
        return res.body if res.is_a? Net::HTTPSuccess
        raise 'Server Error'
      end
    end
  end
end
