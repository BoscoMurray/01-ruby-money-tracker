require_relative('../db/sql_runner')
require_relative('transaction')

class Merchant

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name'].downcase
  end

  def save
    sql = "INSERT INTO merchants (name) VALUES ('#{ @name }')
      RETURNING id"
    @id = SqlRunner.run(sql)[ 0 ][ 'id' ].to_i
  end

  def self.all
    sql = "SELECT * FROM merchants"
    return Merchant.map_items( SqlRunner.run(sql) )
  end

  def self.txs_by_id(id)
    sql = "SELECT * FROM transactions WHERE merchant_id = #{ id }"
    return Transaction.map_items( SqlRunner.run(sql) )
  end

  def self.total_by_id(id)
    txs = self.txs_by_id(id)
    return Transaction.total(txs)
  end

  def self.map_items(hashes)
    result = hashes.map { |merchant| Merchant.new(merchant) }
    return result.sort_by { |t| [t.name] }
  end

  def self.delete_all
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM merchants WHERE id = #{ id }"
    SqlRunner.run(sql)
  end

end