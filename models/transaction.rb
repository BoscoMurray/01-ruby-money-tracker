require_relative('../db/sql_runner')

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

  def self.all
    sql = "SELECT * FROM transactions"
    transactions = Transaction.map_items(SqlRunner.run(sql))
    return transactions.sort_by { |t| [t.date] }
  end

  def self.total
    total = 0
    self.all.each { |transaction| total += transaction.amount.to_i }
    return total
  end

  def self.map_items(hashes)
    result = hashes.map { |transaction| Transaction.new(transaction) }
    return result.sort_by { |t| [t.date] }
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