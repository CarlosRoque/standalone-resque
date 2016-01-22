require 'resque'
require 'yaml'
require "./lib/app"
require "./lib/job"

# configure resque
resque_config = YAML.load_file('config/resque.yml')
Resque.redis = resque_config

@app = App.new


def info
  Resque.info
end
