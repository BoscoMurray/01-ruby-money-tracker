require_relative( '../db/sql_runner' )

class Transaction

  attr_reader :id, :date, :merchant_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @date = options['date']
    @amount = options['amount']*100.to_i
    @merchant_id = options['merchant_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

  def save
    sql = "INSERT INTO transactions (
      date, amount, merchant_id, tag_id) VALUES (
      '#{@date}', #{amount}, #{@merchant_id}, #{@tag_id})
      RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def amount
    return @amount/100.to_f
  end

  # def date
  #   return Date.parse @date
  # end

  # def validate 
  #   errors.add(:price, "should be at least 0.01") if price.nil? || price < 0.01 
  # end 

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM transactions WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end