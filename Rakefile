require 'rake'
require 'yaml'
require 'resque'
require 'resque/tasks'
require './lib/job'

resque_config = YAML.load_file('config/resque.yml')
Resque.redis = Redis.new(:host => resque_config['host'], :port => resque_config['port'])

task :default do
  exec("irb -r ./lib/irb/bootstrap.rb")
end
