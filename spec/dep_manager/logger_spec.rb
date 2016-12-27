require 'spec_helper'

describe DepManager::Logger do
  describe '.error' do
    it 'prints error then raises it' do
      expect { DepManager::Logger.error(RuntimeError, 'msg') }
        .to raise_error(RuntimeError)
    end
  end

  describe '.warn' do
    it 'prints warning message' do
      expect(DepManager::Logger.warn('msg')).to eq((puts 'msg'))
    end
  end

  describe '.log' do
    it 'prints input message' do
      expect(DepManager::Logger.log('msg')).to eq((puts 'msg'))
    end
  end

  describe '.separate' do
    it 'prints 100 times of a string' do
      expect(DepManager::Logger.separate('+')).to eq((puts '+' * 100))
    end
  end
end
