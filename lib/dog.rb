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

end
