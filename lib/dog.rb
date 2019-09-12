class Dog

attr_accessor :name, :breed, :id

def initialize(arguments)
  @name = arguments[:name]
  @breed = arguments[:breed]
  @id = arguments[:id]
end

end
