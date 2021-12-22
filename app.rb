require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require 'pry'
require "pg"
require './lib/train'
require './lib/city'

DB = PG.connect({ dbname: 'train_station', host: 'db', user: 'postgres', password: 'password' })

get '/' do
  @trains = Train.all
  erb(:trains)
end

get('/trains') do
  @trains = Train.all
  erb(:trains)
end

get('/trains/sort') do
  erb(:trains)
end

get('/trains/new') do
  erb(:new_train)
end

post('/trains') do
  name = params[:train_name]
  train = Train.new(name: name)
  train.save()
  @trains = Train.all
  erb(:trains)
  erb(:trains)
end

get('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:train)
end

get('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i())
  erb(:edit_train)
end

patch('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  @train.update({name: params[:name]})
  @trains = Train.all
  erb(:trains)
end

delete('/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @train.delete()
  @trains = Train.all
  erb(:trains)
end

get('/trains/:id/cities/:city_id') do
  @city = City.find(params[:city_id].to_i())
  erb(:city)
end

post('/trains/:id/cities') do
  @train = Train.find(params[:id].to_i())
  city = City.new({name: params[:city_name], train_id: @train.id})
  city.save()
  erb(:train)
end

patch('/trains/:id/cities/:city_id') do
  @train = Train.find(params[:id].to_i())
  city = City.find(params[:city_id].to_i())
  city.update(params[:name], @train.id)
  erb(:train)
end

delete('/trains/:id/cities/:city_id') do
  city = City.find(params[:city_id].to_i())
  city.delete
  @train = Train.find(params[:id].to_i())
  erb(:train)
end


