class Dog

attr_accessor :name, :breed, :id

def initialize(name:,breed:,id:nil)
  @name = name
  @breed = breed
  @id = id
end

def self.create_table
  sql = <<-SQL
  CREATE TABLE IF NOT EXISTS dogs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    breed TEXT
  )
  SQL
  DB[:conn].execute(sql)
end

def self.drop_table
  sql = <<-SQL
  DROP TABLE dogs
  SQL
  DB[:conn].execute(sql)
end

def save
  sql = <<-SQL
  INSERT INTO dogs (name, breed)
  VALUES (?, ?)
  SQL
  DB[:conn].execute(sql, self.name, self.breed)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
  self
end

def self.create(name:,breed:)
  new_dog = Dog.new(name:name,breed:breed)
  new_dog.save
end

def self.new_from_db(row)
  new_dog = Dog.new(name:row[1],breed:row[2],id:row[0])
  new_dog
end

def self.find_by_id(value)
  sql = <<-SQL
  SELECT * FROM dogs
  WHERE id = ?
  SQL
  result = DB[:conn].execute(sql,value)
  self.new_from_db(result)
end



end
