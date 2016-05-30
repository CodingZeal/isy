require 'bundler/setup'
require 'isy'
require 'benchmark/ips'

Benchmark.ips do |x|
  x.report 'native' do
    raise unless 'test'.is_a? String
  end

  x.report 'isy' do
    isy 'test', String
  end

  x.compare!
end
