# Tutorial
# https://rethinkdb.com/docs/guide/ruby/
#

require 'yaml'
require 'pp'

require 'rethinkdb'
include RethinkDB::Shortcuts

r.connect(:host=>"localhost", :port=>28015).repl

r.db("test").table_create('hurricane').run

t = r.db("test").table('hurricane')

t.insert(YAML.load_file('hurricane.yml')).run

cursor = t.filter { |h| h['info']['cat'].eq(3) }.run
cursor.each { |h| pp h }

pp t.filter { |h| h['info']['cat'].eq(3) }.count.run

pp t.map(lambda: {|h| h['info']['cat'] }).sum.run
