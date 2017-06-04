require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/contribution.rb'
require './image_uploader.rb'
require './rakuten_controller.rb'
require 'active_support/core_ext/numeric/conversions'

enable :sessions

get '/' do
  erb :index
end

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

post '/signin' do
  user = User.find_by(mail: params[:mail])
    if user && user.authenticate(params[:password])
      session[:user] = user.id
    else
      redirect '/error'
    end
    redirect '/'
end

post '/signup' do
  @users = User.create(
    mail:     params[:mail], 
    password: params[:password],
    password_confirmation: params[:password_confirmation],
    grade:    params[:grade],
    isadmin:  false,
    img:      ""
    )
    
  if @users.persisted?
    session[:user] = @users.id
  end
  redirect '/'
end

get '/edit_user' do
  erb :edit_user
end

post '/renew_user/:id' do
  @users = User.find(params[:id])
  @users.update(
    mail:     params[:mail], 
    password: params[:password],
    password_confirmation: params[:password_confirmation],
    grade:    params[:grade],
    img:      ""
    )
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/error' do
  erb :error
end

get '/list' do
  @contents = Contribution.order('id desc').all
  @genres   = Contribution.pluck(:genre).uniq
  erb :list
end

get '/edit_list' do
  @contents = Contribution.order('id desc').all
  @genres   = Contribution.pluck(:genre).uniq
  erb :edit_list
end

post '/new' do
  Contribution.create({
    name:   params[:equipment_name],
    genre:  params[:genre],
    number: params[:number],
    bought: params[:bought],
    isout:  false,
    place:  params[:place]
  })
    
  #if params[:file]
  #  image_upload(params[:file])
  #end
    
  redirect '/edit_list'
end

post '/delete/:id' do
  Contribution.find(params[:id]).destroy
  redirect '/edit_list'
end

post '/delete_user/:id' do
  User.find(params[:id]).destroy
  redirect '/userlist'
end

post '/edit/:id' do
  @content = Contribution.find(params[:id])
  erb :edit
end

post '/renew/:id' do
  @content = Contribution.find(params[:id])
  @content.update({
    name:   params[:equipment_name],
    genre:  params[:genre],
    number: params[:number],
    bought: params[:bought],
    isout:  params[:isout],
    place:  params[:place]
  })
  redirect '/edit_list'
end

get '/rental' do
  @contents = Contribution.order('id desc').all
  @genres   = Contribution.pluck(:genre).uniq
  
  erb :rental
end

post '/rental_request/:id' do
  Rental.create({
    name:      params[:name],
    grade:     params[:grade],
    equipment: params[:equipment]
  })
  redirect '/rental'
end

get '/purchase' do
  @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
  erb :purchase
end

post '/purchase_request' do
  Purchaselist.create({
    name:  params[:name],
    url:   params[:url],
    image: params[:image],
    price: params[:price]
  })
  redirect '/purchase'
end

get '/purchase_request_list' do
  @items = Purchaselist.order('id desc').all
  erb :purchase_request_list
end

post '/delete_purchase/:id' do
  Purchaselist.find(params[:id]).destroy
  redirect '/purchase_request_list'
end

get '/userlist' do
  @users = User.order('id desc').all
  erb :userlist
end

get '/suggestion' do
  erb :suggestion
end
