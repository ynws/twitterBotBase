#! /usr/bin/ruby
# coding: utf-8

require 'rubygems'
require 'twitter'

twitter = Twitter::Streaming::Client.new do |config|
    config.consumer_key        = ENV['consumer_key']
    config.consumer_secret     = ENV['consumer_secret']
    config.access_token        = ENV['access_token']
    config.access_token_secret = ENV['access_token_secret']
end

STDOUT.sync = true
puts "#{Time.now.strftime('[ %F %X ]')},Streaming start"

begin
    twitter.user do |status|
        case status
        when Twitter::Tweet
            time = Time.now.strftime('%F %X')
            text = status.full_text.encode('SJIS', 'UTF-8', invalid: :replace, undef: :replace, replace: ' ').encode('UTF-8').gsub(/[\r\n]/, ' ')
            puts "#{time},#{status.id},#{text}"
        end
    end
rescue => ex
    puts "#{Time.now.strftime('[ %F %X ]')},Streaming Error,retry"
    puts ex.message
    retry
end

puts "#{Time.now.strftime('[ %F %X ]')},Streaming Error,End"

