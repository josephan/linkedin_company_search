require 'linkedin'
require 'open-uri'
require 'nokogiri'

client = LinkedIn::Client.new(ENV["LINKEDIN_CLIENT_ID"], ENV["LINKEDIN_CLIENT_SECRET"])
