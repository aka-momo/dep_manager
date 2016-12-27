require 'spec_helper'

describe DepManager::Parser do
  let(:gems) do
    ['bootstrap', 'cocoon', 'coffee-rails', 'jquery-rails', 'mysql2',
     'puma', 'rails', 'sass-rails', 'uglifier', 'jbuilder', 'turbolinks',
     'haml-rails', 'kaminari', 'nokogiri', 'rails-assets-tether', 'byebug',
     'listen', 'spring', 'spring-watcher-listen', 'web-console', 'tzinfo-data']
  end

  let(:npms) do
    ['bower', 'browser-sync', 'browser-sync-spa', 'chalk',
     'concat-stream', 'del', 'gulp', 'gulp-angular-filesort',
     'gulp-angular-templatecache', 'gulp-autoprefixer',
     'gulp-consolidate', 'gulp-csso', 'gulp-filter',
     'gulp-flatten', 'gulp-inject', 'gulp-jshint', 'gulp-load-plugins',
     'gulp-minify-html', 'gulp-ng-annotate', 'gulp-ng-config',
     'gulp-protractor', 'gulp-rename', 'gulp-replace', 'gulp-rev',
     'gulp-rev-replace', 'gulp-ruby-sass', 'gulp-sass', 'gulp-size',
     'gulp-sourcemaps', 'gulp-uglify', 'gulp-useref', 'gulp-util',
     'http-proxy-middleware', 'jade', 'jshint-stylish', 'karma',
     'karma-angular-filesort', 'karma-jasmine',
     'karma-ng-html2js-preprocessor', 'karma-phantomjs-launcher',
     'lodash', 'main-bower-files', 'merge-stream', 'node-sass',
     'require-dir', 'uglify-save-license', 'wiredep', 'wrench',
     'yargs']
  end

  describe '#new' do
    context 'with a valid gemfile path' do
      it 'should load the gems' do
        allow_any_instance_of(DepManager::Parser).to receive(:file_name) do
          'spec/support/Gemfile'
        end
        expect(DepManager::Parser.new.packages).to eq(gems)
      end
    end

    context 'with a valid package.json path' do
      it 'should load the gems' do
        allow_any_instance_of(DepManager::Parser).to receive(:file_name) do
          'spec/support/package.json'
        end
        expect(DepManager::Parser.new(:node).packages).to eq(npms)
      end
    end

    context 'with an invalid gemfile path' do
      it 'should raise LoadError' do
        allow_any_instance_of(DepManager::Parser).to receive(:file_name) do
          'wrong/path/Gemfile'
        end
        expect { DepManager::Parser.new }.to raise_error(LoadError)
      end
    end
  end

  describe '#gems' do
    it 'should raise standard error' do
      allow_any_instance_of(DepManager::Parser).to receive(:file_name) do
        'spec/support/Gemfile'
      end
      allow_any_instance_of(DepManager::Parser).to receive(:content) { nil }
      expect { DepManager::Parser.new.gems }.to raise_error(StandardError)
    end
  end

  describe '#npms' do
    it 'should raise standard error' do
      allow_any_instance_of(DepManager::Parser).to receive(:file_name) do
        'spec/support/Gemfile'
      end
      expect { DepManager::Parser.new(:node).npms }
        .to raise_error(StandardError)
    end
  end
end
