require_relative( '../db/sql_runner' )

class Transaction

  attr_reader :id, :amount, :date, :merchant_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i
    @amount = options['amount'].to_i
    @date = options['date']
    @merchant_id = options['merchant_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

  def save
    
  end

end