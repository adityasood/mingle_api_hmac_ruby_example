# Copyright 2014, ThoughtWorks Inc.
# from https://github.com/ThoughtWorksStudios/mingle_api_hmac_ruby_example

require 'rubygems'
require 'bundler'
Bundler.setup

require 'net/http'
require "net/https"
require 'cgi'
require "time" # needed for httpdate
require "uri"
require 'api-auth'
require 'nokogiri'

# config: use env vars or constants here

MINGLE_LOGIN = ENV['MINGLE_LOGIN']
SECRET_ACCESS_KEY= ENV['SECRET_ACCESS_KEY']

MINGLE_API_ENDPOINT=ENV['API_ENDPOINT'] || ''

PROJECT_IDENTIFIER=ENV['PROJECT_IDENTIFIER'] || 'attached'
SKIP_SSL = false

api_prefix = File.join(MINGLE_API_ENDPOINT, 'api', 'v2', 'projects', PROJECT_IDENTIFIER)

uri = URI.parse(File.join(api_prefix, 'murmurs.xml'))
HTTP_CLIENT = Net::HTTP.new(uri.host, uri.port).tap do |client|
  client.use_ssl = !SKIP_SSL
end

cmd_args = ARGV || []

def do_hmac_request(request, expected_response_class = Net::HTTPOK)

  signed_request = ApiAuth.sign!(request, MINGLE_LOGIN, SECRET_ACCESS_KEY)

  response = HTTP_CLIENT.request(signed_request)

  if expected_response_class === response
    response.body
  else
    raise "Unexpected response: expected #{expected_response_class}, got #{response.class}"
  end
end

def print_murmurs(murmurs)
  puts "Found #{murmurs.size} murmurs."
  murmurs.each do |murmur|
    author = murmur.xpath('author/name').text
    body = murmur.xpath('body').text
    created_at = Time.parse(murmur.xpath('created_at').text)
    puts "#{author} murmured '#{body[0..64]}' at #{created_at}"
  end
end


if cmd_args.size > 0 && cmd_args[0].downcase == 'get'
  request = Net::HTTP::Get.new(uri.request_uri)
  xml = do_hmac_request(request)
  data = Nokogiri::XML(xml)
  murmurs = data.xpath('.//murmurs/murmur')
  print_murmurs(murmurs)

elsif cmd_args.size > 0 && cmd_args[0].downcase == 'post'

  murmur_content = cmd_args[1] || raise("Please supply murmur content")
  params = CGI.escape "murmur[body]=#{murmur_content}"
  request = Net::HTTP::Post.new(uri.request_uri + '?' + params)
  do_hmac_request(request)
  puts "Murmured #{murmur_content} successfully."

else
  puts "Sorry I didn't understand your command: #{cmd_args}"
  puts "  Usage:  "
  puts "     ruby client.rb get"
  puts "     ruby client.rb post hello"
  exit -1
end
