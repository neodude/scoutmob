# TODO: move to Gemfile & Bundler once RVM gets fixed on my machine
require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'nokogiri'

get '/' do
  rss = File.open('./sample.rss')
  feed = Nokogiri::XML.parse(rss.read)
  
  feed.search('item:has(percentageOff) title').map(&:content).join("<br>\n")
end
