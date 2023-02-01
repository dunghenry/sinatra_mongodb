# myapp.rb
require 'sinatra'
require 'mongoid'
require './models/post'  
require './models/comment'  
# DB Setup
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))
def getBody (req)
  req.body.rewind
  return JSON.parse(req.body.read)
end

get '/posts' do
  Post.all.to_json
end

post '/posts' do
  body = getBody(request)
  post = Post.create!(body)
  post.to_json
end

get '/posts/:id' do |id|
  post = Post.find_by(_id: id)
  post.to_json
end

put '/posts/:id' do |id|
  body = getBody(request)
  post = Post.find_by(_id: id)
  post.update_attributes!(
    title: body["title"],
    body: body["body"],
  )
  post.to_json
end

delete '/posts/:id' do |id|
  post = Post.find_by(_id: id)
  post.delete
  "Delete post successfully".to_json
end

get "/" do
  "Hello world".to_json
end