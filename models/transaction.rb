require_relative( '../db/sql_runner' )

class Transaction

  attr_reader :id, :date, :amount, :merchant_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @date = options['date']
    @amount = options['amount'].to_i
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

  def merchant
    sql = "SELECT * FROM merchants WHERE id = #{@merchant_id}"
    return SqlRunner.run(sql)[0]['name']
  end

  def tag
    sql = "SELECT * FROM tags WHERE id = #{@tag_id}"
    return SqlRunner.run(sql)[0]['name']
  end

  # def date
  #   return Date.parse @date
  # end

  # def validate 
  #   errors.add(:price, "should be at least 0.01") if price.nil? || price < 0.01 
  # end 

  def self.all
    sql = "SELECT * FROM transactions"
    transactions = SqlRunner.run(sql)
    return transactions.map { |transaction| Transaction.new(transaction) }
  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM transactions WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end