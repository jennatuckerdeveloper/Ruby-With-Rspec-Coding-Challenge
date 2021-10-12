=begin

I think I know my game plan:

1. Get a first, basic working version of the code.  [Monday]
2. Add a first version of testing. [Monday]
-----------------------------------------------------------------------------------------------------
3. Take the time to study testing and improve testing approach. [Tuesday]
4. Run through refactors of various aspects with the extra time.  Take notes for myself.  [Wednesday]
-----------------------------------------------------------------------------------------------------
--> OOP, sort algorithms, various data types and manipulations 


This will give me a chance to study:
- The Ruby lanuage 
- OOP
- Testing ==> The big one here for me.  
- Sort algorithms 
There isn't a lot beyond that.  

I think my current tactic will be to work this out here in a scrap form
Then use this as a reason to do TDD 
Is there any reason not to do it in that version?  I mean... yes, for me there is. 
I wouldn't necessarily normally do that, but I am studying A LANGUAGE here.  
And I alsolutely break away into little JS files whenever JS messes with me.  

============================================================================

Difference among require, require_relative, include 
Differene importing module, constant, class 

Proper use of class variables 
Do we always have to manually create a method to inspect class variables? 

Should songs variable be a list or a hash? 
Any speed or memory differences between those types? 

I don't believe that the songs themselves need to have a featured field.
The artist simply needs to have a featured song that changes on new_song.
And also has a way to hand the removal of the featured song.
What is the best null type to use in Ruby? 

how does irb work?  
What's required to get this actually running in irb? 


So there are two really interesting pieces here:

The first is how do you want to set a featured song? 
Specifically, do you want to be able to do this from a song?
Which is asking, should a song be able to exist without an artist? 
This brings in the concept of a belongs_to and a has_many 
The languaged used was:  
"When a song is marked as featured, it should replace any currently featured song."
This brings up interesting OOP discussions.  
Some folks are saying, you don't want a child to have a parent reference.  
I'd like to see the way to do both and have a sense of the tradeoffs.  
I don't think that should be a two-way interface... 
It's hard for me to imagine that a song should be able to exist without an aritst... 
This might be getting into some data table stuff that I just do not know... 

But this isn't REALLY a parent / child relationship... is it?  
This is not really inhertiance.  
So what is this called?  

The second is how to most efficiently keep track of an artists genres 
I think the answer is a hash table 
That would keep you from having to run a method on a list over and over 
But maybe the savings on CPU aren't worth the added storage 
I am assuming they are, but I could also do two versions of this 
But in general, this is the most interseting data manipulation 
And what would be really cool would be somehow making this resuable 
Like choosing a TOP 3 based on hash values or something of that nature 


There is an aspect of this that is confusing me.
I don't think you'd want a song to exist WITHOUT an artist.
You would want a song to exist, however, with multiple artists. 
But in their clear code example, they have songs being manually added to artists. 
So... I got to think about the way I want to handle that.  
I think that's incorrect design.  But I could absolutely be wrong.  
I could resolve this issue by just making sure when songs are created, they have one artist
And then making it so you can add songs to artists and thus add artists to songs.
But I would bet that something is wrong with this when it comes to db interactions.  


=end 

