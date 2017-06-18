require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/transaction' )

get '/transactions' do
  @transactions = Transaction.all
  @total = Transaction.total(@transactions)
  erb(:"transactions/index")
end

get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end

post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  redirect to("/transactions")
end

get '/transactions/:id' do
  @transaction = Transaction.find(params['id'])
  erb(:"transactions/show")
end

post '/transactions/:id/delete' do
  Transaction.delete(params[:id])
  redirect to("/transactions")
end