require_relative( '../db/sql_runner' )

class Transaction

  attr_reader :id, :date, :merchant_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount']*100.to_i
    @date = options['date']
    @merchant_id = options['merchant_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

  def save
    
  end

  def amount
    return @amount/100.to_f
  end

  # def date
  #   return Date.parse @date
  # end

  def validate 
    errors.add(:price, "should be at least 0.01") if price.nil? || price < 0.01 
  end 

end