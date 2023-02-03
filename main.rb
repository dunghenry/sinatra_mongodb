# myapp.rb
require 'sinatra'
require 'mongoid'
require './models/post'  
require './models/comment'

set :root, File.dirname(__FILE__)
set :views, Proc.new{File.join(root, 'views')}
set :public_folder, __dir__ + '/public'

# DB Setup
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))
def getBody (req)
  req.body.rewind
  return JSON.parse(req.body.read)
end

# ! all routes use content_type :json
# before do
#   content_type :json
# end

get '/posts' do
  content_type :json
  return Post.all.to_json
end

post '/posts' do
  content_type :json
  body = getBody(request)
  post = Post.create!(body)
  post.to_json
end

get '/posts/:id' do |id|
  content_type :json
  post = Post.find_by(_id: id)
  post.to_json
end

put '/posts/:id' do |id|
  content_type :json
  body = getBody(request)
  post = Post.find_by(_id: id)
  post.update_attributes!(
    title: body["title"],
    body: body["body"],
  )
  post.to_json
end

delete '/posts/:id' do |id|
  content_type :json
  post = Post.find_by(_id: id)
  post.delete
  "Delete post successfully".to_json
end

get "/" do
  "Hello world".to_json
end


get "/about" do
  @code = 200
  erb :about
end