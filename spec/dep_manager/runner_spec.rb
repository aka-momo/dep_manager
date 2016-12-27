require 'spec_helper'

describe DepManager::Runner do
  let(:success_response_body) do
    {
      mac: [
        { name: 'nokogiri', system_dependencies: [{ name: 'libxml2' }] }
      ].to_json,
      linux: [
        { name: 'nokogiri', system_dependencies: [{ name: 'zlib1g-dev' }] }
      ].to_json
    }
  end

  let(:os) do
    DepManager::Configuration.os
  end

  describe '#new' do
    before do
      stub_request(:post, DepManager::Configuration::DEP_MANGER_URL)
        .to_return(status: 200, body: success_response_body[os])
    end
    it 'should succeed' do
      expect(DepManager::Runner.new(nil)).to be_a DepManager::Runner
    end
  end
end
