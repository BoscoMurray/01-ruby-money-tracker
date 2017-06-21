require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/merchant' )

get '/merchants' do
  @merchants = Merchant.all
  erb (:"merchants/index")
end

get '/merchants/new' do
  @merchants = Merchant.all
  erb(:"merchants/new")
end

post '/merchants' do
  merchant = Merchant.new(params)
  merchant.save
  redirect to("/merchants/new")
end

get '/merchants/:id/edit' do
  @merchant = Merchant.find(params['id'])
  erb(:"merchants/edit")
end

post '/merchants/:id' do
  merchant = Merchant.new(params)
  merchant.update
  redirect to "/merchants"
end

post '/merchant/:id/delete' do
  Merchant.delete(params[:id])
  redirect to("/merchants")
end