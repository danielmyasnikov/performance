load '/Users/danielmyasnikov/src/_lab/performance/measurement_wrapper.rb'

require 'data_mapper'
DataMapper.setup(:default, {
  adapter: 'postgres',
  pool: 5,
  timeout: 5000,
  database: 'test',
  port: 15432
})

class Member
  include DataMapper::Resource

  property :id,       Serial
  property :username, String
end

DataMapper.finalize

measure do
  10_000.times do |i|
    Member.create(username: i.to_s)
  end
end

measure do
  Member.all
end

measure do
  10_000.times do |i|
    Member.get(i + 30296).update(:username => i + 1)
  end
end

measure do
  Member.all.destroy
end