require_relative( '../db/sql_runner' )

class Tag

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO tags (name) VALUES ('#{@name}')
      RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM tags"
    tags = SqlRunner.run(sql)
    unsorted = tags.map { |tag| Tag.new(tag) }
    return unsorted.sort_by { |t| [t.name] }
  end

  def self.delete_all
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM tags WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end