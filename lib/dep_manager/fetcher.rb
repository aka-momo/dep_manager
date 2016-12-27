require 'json'
module DepManager
  # Module responsible for:
  # - sending:
  # => - packages
  # => - os
  # - fetching:
  # => - System Dependencies
  class Fetcher
    attr_reader :server_dependencies, :language, :packages, :parsed_response
    attr_reader :server_packages, :missing_packages, :uri, :res, :os

    def initialize(packages, language = :ruby)
      @os       = DepManager::Configuration.os
      @language = language
      @packages = packages
      @uri      = URI(Configuration::DEP_MANGER_URL)
      @server_packages     = []
      @server_dependencies = []
      fetch
    end

    private

    def fetch
      start_request
      parse_response
      return handle_server_response if res.is_a? Net::HTTPSuccess
      handle_server_errors
    end

    def start_request
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = { packages: packages, language: language, os: os }.to_json
      @res = https.request(req)
    rescue
      Logger.error StandardError, 'Server Not Reachable'
    end

    def parse_response
      @parsed_response = JSON.parse(res.body)
    rescue
      Logger.error StandardError, 'Failed To Parse Server Response'
    end

    def handle_server_response
      @parsed_response.each do |pack|
        @server_packages << pack['name']
        pack['system_dependencies'].each do |d|
          @server_dependencies << d['name']
        end
      end
      handle_missing_packages
      @server_dependencies.uniq!
    end

    def handle_missing_packages
      @missing_packages = packages - server_packages
      return if missing_packages.empty?
      msg = missing_packages.join(',') + ' are not listed on the server'
      Logger.warn(msg)
      Logger.separate
    end

    def handle_server_errors
      msg = parsed_response['error_message']
      Logger.error(StandardError, msg) unless msg.nil?
    end
  end
end
