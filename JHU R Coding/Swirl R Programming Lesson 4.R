#The simplest and most common data structure in R is the vector.

#Vectors come in two different flavors: atomic vectors and lists. An atomic 
# vector contains exactly one data type, whereas a list may contain multiple 
# data types. 

#Types of atomic vectors: numerical, logical, character, integer, complex

#Logical vectors can contain the values TRUE, FALSE, & NA (for 'not available'). 
# These values are generated as the result of logical 'conditions'

num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect < 1
tf   # TRUE FALSE TRUE FALSE

#The statement num_vect < 1 is a condition and tf tells us whether each 
# corresponding element of our numeric vector num_vect satisfies this condition.

num_vect >=6   # FALSE TRUE FALSE TRUE

#Logiclal operators: `<`, `>=`, `>`, `<=`, `==`, & `!=`

#If we have two logical expressions, A and B, we can ask whether at least one is 
# TRUE with A | B (logical 'or' a.k.a.'union') or whether they are both TRUE 
# with A & B (logical 'and' a.k.a. 'intersection'). Lastly, !A is the negation 
# of A and is TRUE when A is FALSE and vice versa.


#Character vectors are also very common. Double quotes are used to distinguish 
# character objects
my_char <- c("My", "name", "is")
my_char   # "My"  "name"  "is"

#Let's say we want to join the elements of my_char together into one continuous 
# character string (i.e. a character vector of length 1). We can do this using 
# the paste() function.

paste(my_char, collapse=" ")
#The `collapse` argument to the paste() function tells R that when we join 
# together the elements of the my_char character vector, we'd like to separate 
# them with single spaces.

my_name <- c(my_char, "Kathleen")
my_name # "My"  "name"  "is"  "Kathleen"
paste(my_name, collapse=" ") #  "My name is Kathleen"

paste("Hello", "world!", sep=" ") #  "Hello world!"
paste(1:3, c("X", "Y", "Z"), sep="") #  "1X" "2Y" "3Z" 

#If the vectors are different length, R performs vector recycling.
paste(LETTERS, 1:4, sep="-")  #"A-1" "B-2" "C-3" "D-4" "E-1" "F-2" .....

#Since the character vector LETTERS (a predefined variable in R containing a 
# character vector of all 26 letters in the English alphabet) is longer than 
# the numeric vector 1:4, R  simply recycles, or repeats, 1:4 until it matches 
# the length of LETTERS

#Also worth noting is that the numeric vector 1:4 gets 'coerced' into a 
# character vector by the paste() function. 
