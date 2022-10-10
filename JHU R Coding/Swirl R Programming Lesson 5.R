#Missing values play an important role in statistics and data analysis. Often, 
# missing values mustn't be ignored, but rather they should be carefully studied 
# to see if there's an underlying pattern or cause for their missingness.

#In R, NA is used to represent any value that is 'not available' or 'missing' 

#Any operation involving NA generally yields NA as the result.
x<- c(44, NA, 5, NA)
x*3  # 132 NA 15 NA

#To make things a little more interesting, lets create a vector containing 1000 
# draws from a standard normal distribution
y <- rnorm(1000)
z <- rep(NA, 1000)
my_data <- sample(c(y, z), 100) #Sample of 100 random values from y & z


#Let's first ask the question of where our NAs are located in our data.
my_na<- is.na(my_data)
my_na # TRUE FALSE FALSE TRUE FALSE TRUE FALSE FALSE FALSE .....
#Everywhere you see a TRUE, you know the corresponding element of my_data is NA

my_data==NA # NA NA NA NA NA
#The reason you got a vector of all NAs is that NA is not really a value, but 
# just a placeholder for a quantity that is not available. Therefore the logical 
# expression is incomplete &  R has no choice but to return a vector of the same
# length as my_data that contains all NAs.

#Now we can compute the total number of NAs in our data. The trick is to 
# recognize that underneath the surface, R represents TRUE as the number 1 and 
# FALSE as the number 0. Therefore, if we take the sum of a bunch of TRUEs and 
# FALSEs, we get the total number of TRUEs.
sum(my_na) # 60

my_data

# Now that we've got NAs down pat, let's look at a second type of missing value 
# -- NaN, which stands for 'not a number'. To generate NaN, try dividing (using 
# a forward slash) 0 by 0 now.
0/0   # NaN
Inf - Inf #Nan
