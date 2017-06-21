require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/transaction' )
require('pry-byebug')

get '/transactions' do
  if params[:from] && params[:to]
    @from = params[:from]
    @to = params[:to]
    txs = Transaction.all
    @transactions = Transaction.date_range( txs, params['from'], params['to'] )
  else
    @transactions = Transaction.all
  end
  @total = Transaction.total(@transactions)
  erb(:"transactions/index")
end

get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end

post '/transactions' do
  params['amount'] = params['amount'].to_f * 100
  transaction = Transaction.new(params)
  transaction.save
  redirect to("/transactions")
end

get '/transactions/:id' do
  @transaction = Transaction.find(params['id'])
  erb(:"transactions/show")
end

get '/transactions/:id/edit' do
  @merchants = Merchant.all
  @tags = Tag.all
  @transaction = Transaction.find(params['id'])
  erb(:"transactions/edit")
end

post '/transactions/:id' do
  params['amount'] = params['amount'].to_f * 100
  params['amount'] = params['amount'].to_i
  transaction = Transaction.new(params)
  transaction.update
  redirect to "/transactions/#{ params['id'] }"
end

post '/transactions/:id/delete' do
  Transaction.delete(params[:id])
  redirect to("/transactions")
end