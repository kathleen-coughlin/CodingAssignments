#In its simplest form, R can be used as an interactive calculator.
5+7

#Instead of retyping 5 + 7 every time we need it, we can just create a new 
# variable that stores the result.

#You assign a value to a variable in R by using the assignment operator
x <- 5+7
x   #12
y <- x-3
y   #9

#Now, let's create a small collection of numbers called a vector. Any object 
# that contains data is called a data structure and numeric vectors are the 
# simplest type of data structure in R. In fact, even a single number is 
# considered a vector of length one.

#The easiest way to create a vector is with the c() function, which stands for 
# 'concatenate' or 'combine'.
z <- c(1.1, 9, 3.14)

#Anytime you have questions about a particular function, you can access R's 
# built-in help files via the `?` command.
?c

z   # 1.10 9.00 3.14

#You can combine vectors to make a new vector. Create a new vector that 
# contains z, 555, then z again in that order
c(z, 555, z)   # 1.10 9.00 3.14 555.00 1.10 9.00 3.14

#Numeric vectors can be used in arithmetic expressions.
z * 2 + 100   # 103.30 118.00 106.28

#Other common arithmetic operators are `+`, `-`, `/`, and `^` (where x^2 means 
# 'x squared'). To take the square root, use the sqrt() function and to take 
# the absolute value, use the abs() function.
my_sqrt <- sqrt(z-1)
my_sqrt    #0.3162278 2.8284271 1.4628739
my_div <- z/my_sqrt
my_div    #3.478505 3.181981 2.146460

#When given two vectors of the same length, R simply performs the specified 
# arithmetic operation (`+`, `-`, `*`, etc.) element-by-element. If the vectors 
# are of different lengths, R 'recycles' the shorter vector until it is the 
# same length as the longer vector.
c(1, 2, 3, 4) + c(0 ,10)    # 1 12 3 14

#If the length of the shorter vector does not divide evenly into the length of 
# the longer vector, R will still apply the 'recycling' method, but will throw 
# a warning to let you know something fishy might be going on.

c(1, 2, 3, 4) + c(0, 10, 100)
#1 12 103 4
#Warning message: In c(1, 2, 3, 4) + c(0, 10, 100) : 
   # longer object length is not a multiple of shorter object length

#In many programming environments, the up arrow will cycle through previous commands.

#You can type the first two letters of the variable name, then hit the Tab key 
# (possibly more than once). Most programming environments will provide a list 
# of variables that you've created that begin with 'my'.

my_div

