$: << "integrity/lib"
require ".bundle/environment"

require "integrity"
require "integrity/notifier/irc"

db_config = YAML.load_file("config/database.yml").
  fetch(ENV["RACK_ENV"]).
  values_at("username", "password", "database")

Integrity.configure do |c|
  c.database  "postgres://%s:%s@localhost/%s" % db_config
  c.directory "/tmp/integrity-builds"
  c.log       File.expand_path("../log/integrity.log", __FILE__)
  c.builder :resque
  c.build_all!
end
