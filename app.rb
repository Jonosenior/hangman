require 'sinatra'
require 'erb'
require 'sinatra/reloader'
#require_relative 'lib/5desk.txt'



get '/' do
  erb :hangman
end
