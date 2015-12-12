load '/Users/danielmyasnikov/src/_lab/performance/measurement_wrapper.rb'

require 'sequel'
DB = Sequel.postgres('test', 
  adapter: 'postgres',
  pool: 5,
  timeout: 5000,
  port: 15432
)

class Member < Sequel::Model
  set_primary_key [:id]
end

measure do
  10_000.times do |i|
    Member.create(username: i)
  end
end
measure do
  Member.all
end
measure do
  mid = Member.first.id
  10_000.times do |i|
    Member[i + mid].update(:username => i + 1)
  end
end
# measure do
#   mid = Member.first.id
#   10_000.times do |i|
#     Member[i + mid].destroy rescue nil
#   end
# end