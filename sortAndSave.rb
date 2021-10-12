hash = {coconut: 200, orange: 50, bacon: 100, apple: 20, milk: 10, whiskey: 1}
puts hash
# puts hash[:apple]
# puts hash[:new].class.name
# puts hash.include? :apple # This can check quickly if the value exists 
# puts hash.include? :new # This can check quickly if the value exists 

sortedNestedArray = hash.sort_by(&:last)
topThree = []
sortedNestedArray.slice(0,3).each do | innerArray | 
  # puts innerArray[0]
  topThree.push(innerArray[0]) 
end
puts topThree
backToHash = sortedNestedArray.to_h
puts backToHash
# puts sortedHash.include? :apple # doesn't work on this nested array result, though. 

newType = :bread
existingType = :apple

# a cheaty way might be to flatten the nested array to do a key scan 
# puts sortedNestedArray.flatten.include? existingType
# puts sortedNestedArray.flatten.include? newType

# sortedHash.each do | hash | 
#   puts hash.include? existingType
#   # hash.each do |key, value|
     
#   # end
# end

# puts sortedNestedArray.slice(0,3)

=begin 

So one technique would be to 
Hold variable genres as simple has of genre symbols as keys and totals as values 
Use a specific algorithm to generate an array of the top one to three genres 
-> This cannot error with one or two genres only.  

After there are at least three genres:  
Only run that method if the value of the lowest of the top three is now lower than new 
Then run it over the entire thing.  

=end 