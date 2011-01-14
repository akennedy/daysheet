# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

namespace :db do
  task :bounce => :environment do
    puts 'Dropping db...'
    sh "rake db:drop"
    puts 'Creating db...'
    sh "rake db:create"
    puts 'Migrating db...'
    sh "rake db:migrate"
    puts 'Seeding db...'
    sh "rake db:seed"
    puts 'Cloning db...'
    sh "rake db:test:clone"
  end
end

Daysheet::Application.load_tasks

MetricFu::Configuration.run do |config|  
  config.rcov[:rcov_opts] << "-Ispec"  
end rescue nil
