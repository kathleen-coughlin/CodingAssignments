#In this lesson, you'll learn how to use vapply() and tapply(), each of which 
# serves a very specific purpose within the Split-Apply-Combine methodology. 

dim(flags)
head(flags)
str(flags)
summary(flags)

#Vairables: name landmass zone area population language religion bars stripes 
# colours red green blue gold white black orange mainhue circles crosses 
# saltires quarters sunstars crescent triangle icon animate text topleft botright

#As you saw in the last lesson, the unique() function returns a vector of the 
# unique values contained in the object passed to it. Therefore, 
# sapply(flags, unique) returns a list containing one vector of unique values 
# for each column of the flags dataset. Try it again now.

sapply(flags, unique)

#What if you had forgotten how unique() works and mistakenly thought it returns 
# the *number* of unique values contained in the object passed to it? Then you 
# might have incorrectly expected sapply(flags, unique) to return a numeric 
# vector, since each element of the list returned would contain a single number 
# and sapply() could then simplify the result to a vector.

#Try vapply(flags, unique, numeric(1)), which says that you expect each element 
# of the result to be a numeric vector of length 1. Since this is NOT actually 
# the case, YOU WILL GET AN ERROR. Once you get the error, type ok() to continue 
# to the next question.

vapply(flags, unique, numeric(1))
ok()

#Recall from the previous lesson that sapply(flags, class) will return a 
# character vector containing the class of each column in the dataset. Try that 
# again now to see the result.

sapply(flags, class)

#If we wish to be explicit about the format of the result we expect, we can use 
# vapply(flags, class, character(1)). The 'character(1)' argument tells R that 
# we expect the class function to return a character vector of length 1 when 
# applied to EACH column of the flags dataset. Try it now.

vapply(flags, class, character(1))

#Since our expectation was correct (i.e. character(1)), the vapply()result is 
# identical to the sapply() result: a character vector of column classes.

#As a data analyst, you'll often wish to split your data up into groups based 
# on the value of some variable, then applya function to the members of each 
# group. The next function we'll look at, tapply(), does exactly that.

?tapply #tapply(X, INDEX, FUN = NULL, ..., default = NA, simplify = TRUE)

#The 'landmass' variable in our dataset takes on integer values between 1 and 6,
# each of which represents a different part of the world. Use 
# table(flags$landmass) to see how many flags/countries fall into each group.

table(flags$landmass)

#The 'animate' variable in our dataset takes the value 1 if a country's flag 
# contains an animate image (e.g. eagle, tree, human hand) and 0 otherwise. Use 
# table(flags$animate) to see how many flags contain an animate image.

table(flags$animate)

# Use tapply(flags$animate,flags$landmass, mean) to apply the mean function to 
# the 'animate' variable separately for each of the six landmass groups, thus 
# giving us the proportion of flags containing an animate image WITHIN each 
# landmass group.

tapply(flags$animate, flags$landmass, mean)
       #        1         2         3         4         5         6 
       #0.4193548 0.1764706 0.1142857 0.1346154 0.1538462 0.3000000 

#The first landmass group (landmass = 1) corresponds to North America and 
# contains the highest proportion of flags with an animate image (0.4194).

#Similarly, we can look at a summary of population values (in round millions) 
# for countries with and without the color red on their flag with 
# tapply(flags$population, flags$red, summary).

tapply(flags$population, flags$red, summary)

#Use the same approach to look at a summary of population values for each of 
# the six landmasses.

tapply(flags$population, flags$landmass, summary)

#In this lesson, you learned how to use vapply() as a safer alternative to 
# sapply(), which is most helpful when writing | your own functions. You also 
# learned how to use tapply() to split your data into groups based on the value 
# of some variable, then apply a function to each group. These functions will 
# come in handy on your quest to become a better data analyst.
