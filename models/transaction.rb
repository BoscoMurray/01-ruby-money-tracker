require_relative('../db/sql_runner')

class Transaction

  attr_reader :id
  attr_accessor :date, :amount, :merchant_id, :tag_id

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
      '#{ @date }', #{ amount }, #{ @merchant_id }, #{ @tag_id })
      RETURNING id"
    @id = SqlRunner.run(sql)[ 0 ][ 'id' ].to_i
  end

  def update
    sql = "UPDATE transactions SET
      date = '#{ @date }', amount = #{ @amount },
      merchant_id = #{ @merchant_id }, tag_id = '#{ @tag_id }'
      WHERE id = #{ @id }"
    SqlRunner.run(sql)
  end

  def merchant
    sql = "SELECT * FROM merchants WHERE id = #{ @merchant_id }"
    return SqlRunner.run(sql)[ 0 ][ 'name' ]
  end

  def tag
    sql = "SELECT * FROM tags WHERE id = #{ @tag_id }"
    return SqlRunner.run(sql)[ 0 ][ 'name' ]
  end

  def self.all
    sql = "SELECT * FROM transactions"
    return Transaction.map_items( SqlRunner.run(sql) )
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = #{id}"
    result = SqlRunner.run(sql)[ 0 ]
    return Transaction.new(result)
  end

  def self.date_range(txs, from, to)
    txs_by_date = []
    txs.each { |tx| txs_by_date << tx if tx.date >= from && tx.date <= to }
    return txs_by_date
  end

  def self.total(txs)
    total = 0
    txs.each { |tx| total += tx.amount.to_i }
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
    sql = "DELETE FROM transactions WHERE id = #{ id }"
    SqlRunner.run(sql)
  end

end