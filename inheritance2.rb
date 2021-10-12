class First 

  # a constant 
  MYCONST = 1000 
  
  # a global
  MYGLOB = 'GLOBAL'

  # An instance variable defined outside a method is not a thing.  
  # This pattern is only useful for class variables.    
  @instVarX = 1

  #class variable
  @@classVar1 = 0

  # attr_accessor :instVar4

  def initialize(param1)
    @instVar1 = 1
    @instVar2 = 2
    @instVar3 = param1
    @@classVar2 = 'X'
  end

  # This instance variable does not exist until this method gets called.  
  # It's not defined, cannot reference instVar4 with @instVar4, even with the attr_accessor.  
  def instVar4
    @instVar4 = 4
  end

  # @instVar4 will be empty unless the method instVar4 has been run first.  
  def p_manual 
    "#{@instVar1} #{@instVar2} #{@instVar3} #{@instVar4}"
  end

  def p_class_manual 
    "#{@@classVar1} #{@@classVar2}"
  end

  # These will both fail, unless I have first called instVar4 to create @instVar4.  
  def practice 
    newValue = @instVar4 + 5 
    newValue
  end

  def more_practice
    @instVar4
  end

  # Weirdly, Ruby will not actually error.  No matter what junk value you put after @.
  def tryAndFail 
    @instVarX # could be @alsdkfjahdg
  end 

  # This will produce a proper error messsage 
  def tryAndFailBetter
    @instVarX + 10
  end

  def self.forTheClass 
    "A class method was called!"
  end

end

=begin

=end

one = First.new 'passed param1!'

# The only visible variable is instVar3.  
# This is the one instant variable created with initialize. 
puts one.inspect
puts one.instVar4
puts one.p_manual
puts one.p_class_manual
puts one.practice
puts one.more_practice

# puts one.tryAndFail # Just prints an empty line. It's a nil: NilCLass 
# puts one.tryAndFailBetter # Properly errors.  

# puts one.forTheClass
puts First.forTheClass
puts First::forTheClass # Same thing but not a good style.  
# This is also the same thing.  
puts one.class.forTheClass
puts one.class.name

puts '>>>>>>>>>>>>>>>>>>>>'
one.instVar4
puts one.p_manual
puts one.p_class_manual

# This empty class definition seems to inherit everything. 
# An online forum had said that a subclass would not receive class variables.
# That seems untrue so far.  I wonder what they meant. 

# class Second < First 
# end


# empties out most variables
# class Second < First 
#   def initialize(param1)
#     @instVar1 = "An overriding value"
#     @instVar2 = param1
#   end
# end

# With inheritance of all the instance and class variables. 

class Second < First 
  def initialize(param1)
    super(param1)
    @instVar1 = "An overriding value"
  end
end

two = Second.new('passed param!')
two.instVar4
puts two.p_manual

# An online forum said that subclasses do not receive class variables.  
# That's clearly untrue in this example.  I wonder what they meant.  
puts two.p_class_manual

puts Second.forTheClass

