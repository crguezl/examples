require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'active_record'

configure do
  ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'test.sqlite3.db')
  set :server, %w{mongrel webrick}
end

#ActiveRecord::Base.establish_connection(
#  :adapter => 'sqlite3',
#  :dbfile =>  'db/test.sqlite3.db'
#)

#Models
class Post < ActiveRecord::Base
end

get '/' do
 @posts = Post.all
 haml :index
end

#Posts
get '/posts' do
  @posts = Post.all
  haml :'posts/index'
end

get '/posts/new' do
  @post = Post.new
  haml :'posts/new'
end

post '/posts' do
  @post = Post.new(params[:post])
  if @post.save
    redirect "/posts/#{@post.id}"
  else
    "There was a problem saving that..."
  end
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  haml :'posts/show'
end

