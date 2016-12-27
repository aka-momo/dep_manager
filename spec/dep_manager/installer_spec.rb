require 'spec_helper'

describe DepManager::Installer do
  describe '#new' do
    let(:dependencies) do
      {
        mac: ['libxml2'],
        linux: ['zlib1g-dev']
      }
    end
    context 'installs dependencies' do
      it 'succeeds' do
        deps = dependencies[DepManager::Configuration.os]
        expect(DepManager::Installer.new(deps).number_of_installed_dep).to eq(1)
      end
      it 'fails' do
        expect { DepManager::Installer.new(nil) }
          .to raise_error(StandardError)
      end
    end
  end
end
