#!/usr/bin/env ruby
require 'thor'
require "./lib/ranking"

class CalculateRanking < Thor
  class_option :path, :type => :string, :aliases => "-p"

  desc "init path_url", "Create a new rails app"

  def init
    if File.exists? options[:path]
	    Ranking.init(options[:path])
    else
    	puts "Your file does not work!"
    	puts "Make sure your path directorie is correct!"
    end
  end
end

CalculateRanking.start(ARGV)