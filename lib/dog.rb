class Dog

attr_accessor :name, :breed, :id

def initialize(arguments)
  @name = arguments[:name]
  @breed = arguments[:breed]
  @id = arguments[:id]
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
end

def self.create(hash)
  new_dog = Dog.new(hash)
  new_dog.save
  new_dog
end

end
