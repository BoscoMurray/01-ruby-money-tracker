require_relative('../db/sql_runner')
require_relative('transaction')

class Tag

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name'].downcase
  end

  def save
    sql = "INSERT INTO tags (name) VALUES ('#{ @name }')
      RETURNING id"
    @id = SqlRunner.run(sql)[ 0 ][ 'id' ].to_i
  end

  def update
    sql = "UPDATE tags SET name = '#{ @name }' WHERE id = #{ @id }"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM tags"
    return Tag.map_items( SqlRunner.run(sql) )
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = #{id}"
    result = SqlRunner.run(sql)[ 0 ]
    return Tag.new(result)
  end

  def self.txs_by_id(id)
    sql = "SELECT * FROM transactions WHERE tag_id = #{ id }"
    return Transaction.map_items( SqlRunner.run(sql) )
  end

  def self.total_by_id(id)
    txs = self.txs_by_id(id)
    return Transaction.total(txs)
  end

  def self.map_items(hashes)
    result = hashes.map { |tag| Tag.new(tag) }
    return result.sort_by { |t| [t.name] }
  end

  def self.delete_all
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM tags WHERE id = #{ id }"
    SqlRunner.run(sql)
  end

end