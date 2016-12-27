require 'spec_helper'

describe DepManager::Fetcher do
  before do
    stub_const('RbConfig::CONFIG', RbConfig::CONFIG.merge('host_os' => 'linux'))
  end

  let(:packages) do
    %w(nokogiri missing_package)
  end

  let(:dependencies) do
    %w(ruby-dev zlib1g-dev liblzma-dev)
  end

  let(:success_response_body) do
    [
      {
        name: 'nokogiri',
        system_dependencies: [
          { name: 'ruby-dev' },
          { name: 'zlib1g-dev' },
          { name: 'liblzma-dev' }
        ]
      }
    ].to_json
  end

  let(:corrupted_response_body) do
    '\"broken json:'
  end

  let(:error_response_body) do
    { error_message: 'error !!!!' }.to_json
  end

  describe '#new' do
    it 'fetchs dependencies' do
      stub_request(:post, DepManager::Configuration::DEP_MANGER_URL)
        .to_return(status: 200, body: success_response_body)
      expect(DepManager::Fetcher.new(packages).server_dependencies)
        .to eq(dependencies)
    end

    it 'should timeout and raise error' do
      stub_request(:any, DepManager::Configuration::DEP_MANGER_URL)
        .to_raise(StandardError)
      expect { DepManager::Fetcher.new(packages) }.to raise_error(StandardError)
    end

    it 'return missing_package in missing_packages' do
      stub_request(:post, DepManager::Configuration::DEP_MANGER_URL)
        .to_return(status: 200, body: success_response_body)
      expect(DepManager::Fetcher.new(packages).missing_packages)
        .to satisfy { |value| value.include?(packages.last) }
    end

    it 'fails parsing response and raise error' do
      stub_request(:post, DepManager::Configuration::DEP_MANGER_URL)
        .to_return(status: 200, body: corrupted_response_body)
      expect { DepManager::Fetcher.new(packages) }.to raise_error(StandardError)
    end

    it 'raises server errors' do
      stub_request(:post, DepManager::Configuration::DEP_MANGER_URL)
        .to_return(status: 422, body: error_response_body)
      expect { DepManager::Fetcher.new(packages) }.to raise_error(StandardError)
    end
  end
end
