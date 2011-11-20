# TODO: move to Gemfile & Bundler once RVM gets fixed on my machine
require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'nokogiri'
require 'haml'
require 'json'

helpers do
  def extract_children_from_nodeset(nodeset, attrs)
    nodeset.map do |node|
      children = node.children.filter(attrs.join(','))
      hash = {}
      children.each do |child|
        hash[child.name.to_sym] = child.content
      end
      hash
    end
  end
end

get '/' do
  haml :index, :format => :html5
end

get '/data.json' do
  rss = File.open('./sample.rss')
  feed = Nokogiri::XML.parse(rss.read)
  
  items = feed.search('item:has(percentageOff)')
  
  @data = extract_children_from_nodeset(items, ['latitude', 'longitude', 'title'])
  @data.to_json
end
