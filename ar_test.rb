load '/Users/danielmyasnikov/src/_lab/performance/measurement_wrapper.rb'

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  pool: 5,
  timeout: 5000,
  database: 'test'
)

class Member < ActiveRecord::Base
  self.primary_key = 'id'
end

measure do
  10_000.times do |i|
    Member.create(username: i)
  end
end
measure do
  Member.all.load
end
measure do
  10_000.times do |i|
    Member.find(i + 20296).update_attribute(:username, i + 1)
  end
end
measure do
  Member.destroy_all
end