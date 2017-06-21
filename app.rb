require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'date' )
require_relative('controllers/transactions_controller')
require_relative('controllers/merchants_controller')
require_relative('controllers/tags_controller')
require_relative( 'models/transaction' )

get '/' do
  @month_minus1 = Date.new(Date.today.year, Date.today.month - 1, 1).strftime("%B")
  @month_minus2 = Date.new(Date.today.year, Date.today.month - 2, 1).strftime("%B")
  @month_minus3 = Date.new(Date.today.year, Date.today.month - 3, 1).strftime("%B")
  @month_minus4 = Date.new(Date.today.year, Date.today.month - 4, 1).strftime("%B")

  @total_current = Transaction.total( Transaction.txs_month_current )
  @total_minus1 = Transaction.total( Transaction.txs_month_minus(1) )
  @total_minus2 = Transaction.total( Transaction.txs_month_minus(2) )
  @total_minus3 = Transaction.total( Transaction.txs_month_minus(3) )
  @total_minus4 = Transaction.total( Transaction.txs_month_minus(4) )
  erb(:index)
end