require 'spec_helper'

describe DepManager::Configuration do
  describe '.install_command' do
    subject { DepManager::Configuration.install_command('package1') }

    context 'with os as mac' do
      it 'return brew install package_name' do
        allow(DepManager::Configuration).to receive(:os) { :mac }
        expect(subject).to eq('brew install package1')
      end
    end

    context 'with os as linux' do
      it 'return sudo apt-get install package_name' do
        allow(DepManager::Configuration).to receive(:os) { :linux }
        expect(subject).to eq('sudo apt-get install package1')
      end
    end
  end

  describe '.os' do
    subject { DepManager::Configuration.os }
    it 'returns the name of the OS' do
      expect(subject).to satisfy { |value| [:mac, :linux].include?(value) }
    end

    it 'returns linux OS' do
      stub_const(
        'RbConfig::CONFIG',
        RbConfig::CONFIG.merge('host_os' => 'linux')
      )
      expect(subject).to eq(:linux)
    end

    it 'returns an error' do
      stub_const(
        'RbConfig::CONFIG',
        RbConfig::CONFIG.merge('host_os' => 'windows')
      )
      expect { DepManager::Configuration.os }.to raise_error(StandardError)
    end
  end
end
