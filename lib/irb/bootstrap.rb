require 'resque'
require 'yaml'
require "./lib/app"
require "./lib/job"

@app = App.new


def info
  Resque.info
end
