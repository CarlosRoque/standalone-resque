# standalone-resque
Everything you need to start workers and queue up resque jobs.
Includes a bootstraped irb

## Setup
### Redis
Before you can start queueing jobs, you need to install [Redis|http://redis.io/].
For the sake of simplicity, this project assumes redis is running on localhost:6379

### Configuring
For simplicity I have provided a sample resque.yml file for configuring redis and resque.
See file ```config/resque.yml```. You can modify it with your Redis configuration

### Installing Gems
Run the following command from the project root
```bash
bundle install --path=vendor
```

## irb
The easiest way to see resque in action is to launch the irb:
```bash
bundle exec rake
```
This will configure resque with redis and load the sample files

### Queueing Jobs
I have provided an example class that queues a resque job that writes a simple message.
See lib/app.rb and lib/job.rb.
This should give you enough guidance on how to use resque as stand alone.

After starting the irb do:
```ruby
# use the provided @app
@app.async_message("Some Message")

# OR create a new instance
my_app = App.new
# enque some message in resque
my_app.async_message("Some Message")

```

Thats it! you have enqueued a reque job

## Starting Workers
Now that you have some jobs queued up, you probably want to process them.
To start a single worker do:
```bash
QUEUE=test bundle exec rake resque:work
```
To start more than one:
```bash
QUEUE=test COUNT=2 bundle exec rake resque:workers
```
If you had jobs queued up, then you now have the file myfile.out
in your root with a list of all the enqueued messages.

## The magic
What makes all of this work is this section in the Rakefile
```ruby
resque_config = YAML.load_file('config/resque.yml')
Resque.redis = Redis.new(:host => resque_config['host'], :port => resque_config['port'])
```

If you need to run your code with a rake task then you only need to add the task to the Rakefile.
If you want to run your code standalone then make sure your add that initialization on the calling class or file before you do any work.
