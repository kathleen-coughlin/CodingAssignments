#In this lesson, we'll see how to subset and extract elements from a vector

x # NA NA NA 0.07487952 NA -0.88562079 NA 2.16608025 ....

#The way you tell R that you want to select some particular elements (i.e. a 
# 'subset') from a vector is by placing an 'index vector' in square brackets 
# immediately following the name of the vector.
x[1:10] # prints the values in positions 1 through 10 in the vector

x[is.na(x)] # a vector with all the NA values from x
y <- x[!is.na(x)]
y # a vector with all the non-nA values from x

y[y>0] # a vector of the positive values from y

x[x>0] 
#Since NA is not a value, but rather a placeholder for an unknown quantity, the 
# expression NA > 0 evaluates to NA. Hence we get a bunch of NAs mixed in with 
# our positive numbers when we do this.

x[!is.na(x) & x>0] # gives a subset of x that's not NA and positive

#Many programming languages use what's called 'zero-based indexing', which means 
# that the first element of a vector is considered element 0. R uses 'one-based 
# indexing', which means the first element of a vector is considered element 1.

x[c(3, 5, 7)]  # NA -1.2797416 -0.8856208
               # the 3rd, 5th, and 7th elements in x

x[0] # numeric(0)
     # asking for the 0th element but there isn't one
x[3000] # NA
        # askinf for the 1000th element but there isn't one

#R accepts negative integer indexes. Whereas x[c(2, 10)] gives us ONLY the 2nd 
# and 10th elements of x, x[c(-2,-10)] gives us all elements of x EXCEPT for the 
# 2nd and 10 elements. 
x[c(-2, -10)]
#A shorthand way of specifying multiple negative numbers is to put the negative 
# sign out in front of the vector of positive numbers. 
x[-c(2, 10)]

vect<- c(foo=11, bar=2, norf=NA)
#When we print vect to the console, you'll see that each element has a name.
vect
     # foo    bar    norf
     #  11      2      NA
names(vect) # "foo" "bar" "norf"

#Alternatively, we can create an unnamed vector then, we can add the `names` 
# attribute to vect2 after the fact
vect2<- c(11, 2, NA)
names(vect2) <- c("foo", "bar", "norf")

#Let's check that vect and vect2 are the same
identical(vect, vect2) #TRUE

vect["bar"] #the element named "bar" and its value 
vect[c("foo", "bar")] #the elements named "foo" & "bar" and their values
 