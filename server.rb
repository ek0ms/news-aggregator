require 'sinatra'
require 'pry'
require 'csv'

get '/' do
  @articles = []
  CSV.foreach('articles.csv', headers: true) do |row|
    @articles << row
  end
  erb :index
end

get '/articles/new' do
  erb :submit
end

post '/articles/new' do
  description = params['description']
  title = params['title']
  url = params['url']

  CSV.open('articles.csv', 'ab') do |csv|
    csv << ["#{description}", "#{title}","#{url}"]
  end

  redirect '/'
end
