require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/merchant' )

get '/merchants' do
  @merchants = Merchant.all
  erb (:"merchants/index")
end

