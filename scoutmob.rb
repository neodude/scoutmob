# TODO: move to Gemfile & Bundler once RVM gets fixed on my machine
require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'feedzirra'

get '/' do
  rss = File.open('./sample.rss')
  feed = Feedzirra::Feed.parse(rss.read)
  
  feed.entries.map(&:title).join('<br>')
end
