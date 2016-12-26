require 'json'
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
        @os       = DepManager.os
        @language = language
        @packages = packages
        @uri      = URI(Configuration::DEP_MANGER_URL)
        @server_packages     = []
        @server_dependencies = []
        fetch
      end

      private

      def fetch
        req = Net::HTTP::Post.new(@uri, 'Content-Type' => 'application/json')
        req.body = { packages: @packages, language: @language, os: @os }.to_json
        res = Net::HTTP.start(@uri.hostname, @uri.port) do |http|
          http.request(req)
        end
        return handle_server_response(res.body) if res.is_a? Net::HTTPSuccess
      rescue => e
        Logger.error e, 'Server Error'
      end

      def handle_server_response(response_body)
        parsed_response = JSON.parse(response_body)
        parsed_response.each do |pack|
          @server_packages << pack['name']
          pack['system_dependencies'].each do |d|
            @server_dependencies << d['name']
          end
        end
        handle_missing_packages
        @server_dependencies
      end

      def handle_missing_packahes
        missing_packages = @packages - @server_packages
        return if missing_packages.empty?
        msg = missing_packages.join(',') + 'are not listed in the server'
        Logger.warn(msg)
      end
    end
  end
end
