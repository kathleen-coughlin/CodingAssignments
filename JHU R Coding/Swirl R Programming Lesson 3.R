#In this lesson, you'll learn how to create sequences of numbers in R.

#The simplest way to create a sequence of numbers is by using the `:` operator.
1:20
#   1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

#That gave us every integer between (& including) 1 and 20. We could also use 
# it to create a sequence of real numbers.
pi:10
#   3.141593 4.141593 5.141593 6.141593 7.141593 8.141593 9.141593

#The result is a vector of real numbers starting with pi & increasing in 
# increments of 1. The upper limit of 10 is never reached, since the next number 
# in our sequence would be greater than 10.

15:1
#   15 14 13 12 11 10 9 8 7 6 5 4 3 2 1

#Remember that if you have questions about a particular function, you can access
# its documentation with a question mark followed by the function name. However, 
# in the case of an operator like the colon used above, you must enclose the 
# symbol in backticks like this: ?`:`. 

?`:`

#Often, we'll desire more control over a sequence we're creating than what the 
# `:` operator gives us. The seq() function serves this purpose. The most basic 
# use of seq() does exactly the same thing as the `:` operator.
seq(1, 20)
#   1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
seq(0, 10, by=0.5)
#   0.0 0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0 .....
my_seq<- seq(5, 10, length=30)
#   5.000000  5.172414  5.344828  5.517241  5.689655  5.862069  6.034483
length(my_seq) #  30

#Let's pretend we don't know the length of my_seq, but we want to generate a 
# sequence of integers from 1 to N, where N represents the length of the my_seq 
# vector. There are several ways we could do this.
1:length(my_seq) # 1 2 3 ..... 29 30
seq(along.with = my_seq)  # 1 2 3 ..... 28 29 30
seq_along(my_seq) # 1 2 3 ..... 28 29 30

#There are often several approaches to solving the same problem, particularly 
# in R. Simple approaches that involve less typing are generally best. It's also 
# important for your code to be readable, so that you and others can figure out
# what's going on without too much hassle.

#If R has a built-in function for a particular task, it's likely that function 
# is highly optimized for that purpose &  is your best option. As you become a 
# more advanced R programmer, you'll design your own functions to perform tasks 
# when there are no better options. 

#One more function related to creating sequences of numbers is rep(), which 
# stands for 'replicate'.
rep(0, times=40) #  prints 40 zeroes
rep(c(0, 1, 2), times=10) #   0 1 2 0 1 2 0 1 2 until it's been 10 times
rep(c(0, 1, 2), each=10) #   0 0 0 0 0 0 0 0 0 0 1 1 1 .... each 10 times
