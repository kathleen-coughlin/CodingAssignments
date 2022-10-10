#In this lesson, you'll learn how to use lapply() and sapply(), the two most 
# important members of R's *apply family of functions, aka loop functions.

#These powerful functions, along with their close relatives (vapply() and 
# tapply(), among others) offer a concise and convenient means of implementing 
# the Split-Apply-Combine strategy for data analysis.

#Each of the *apply functions will SPLIT up some data into smaller pieces, 
# APPLY a function to each piece, then COMBINE the results. A more detailed 
# discussion of this strategy is found in Hadley Wickham's Journal of 
# Statistical Software paper, 'The Split-Apply-Combine Strategy for Data Analysis'.

#Throughout this lesson, we'll use the Flags dataset from the UCI Machine 
# Learning Repository. This dataset contains details of various nations and 
# their flags. More information may be found here:
    #http://archive.ics.uci.edu/ml/datasets/Flags

head(flags)
#VARIABLES: name landmass zone area population language religion bars stripes 
        #colours red green blue gold white black orange mainhue circles crosses 
        # saltires quarters sunstars crescent triangle icon animate text topleft 
        # botright

dim(flags) # [1] 194 30

#This tells us that there are 194 rows, or observations, and 30 columns, or 
# variables. Each observation is a country and each variable describes some 
# characteristic of that country or its flag. To open a more complete 
# description of the dataset in a separate text file, type viewinfo() when you 
# are back at the prompt (>).

viewinfo()
  #1. Title: Flag database

  #2. Source Information
  #-- Creators: Collected primarily from the "Collins Gem Guide to Flags":
  #  Collins Publishers (1986).
  #-- Donor: Richard S. Forsyth 
  #8 Grosvenor Avenue
  #Mapperley Park
  #Nottingham NG3 5DX
  #0602-621676
  #-- Date: 5/15/1990

  #3. Past Usage:
  #  -- None known other than what is shown in Forsyth's PC/BEAGLE User's Guide.

  #4. Relevant Information:
  #  -- This data file contains details of various nations and their flags.
  #In this file the fields are separated by spaces (not commas).  With
  #this data you can try things like predicting the religion of a country
  #from its size and the colours in its flag.  
  #-- 10 attributes are numeric-valued.  The remainder are either Boolean-
  #  or nominal-valued.

  #5. Number of Instances: 194

  #6. Number of attributes: 30 (overall)

  #7. Attribute Information:
  #  1. name	Name of the country concerned
  #2. landmass	1=N.America, 2=S.America, 3=Europe, 4=Africa, 4=Asia, 6=Oceania
  #3. zone	Geographic quadrant, based on Greenwich and the Equator
  #1=NE, 2=SE, 3=SW, 4=NW
  #4. area	in thousands of square km
  #5. population	in round millions
  #6. language 1=English, 2=Spanish, 3=French, 4=German, 5=Slavic, 6=Other 
  #Indo-European, 7=Chinese, 8=Arabic, 
  #9=Japanese/Turkish/Finnish/Magyar, 10=Others
  #7. religion 0=Catholic, 1=Other Christian, 2=Muslim, 3=Buddhist, 4=Hindu,
  #5=Ethnic, 6=Marxist, 7=Others
  #8. bars     Number of vertical bars in the flag
  #9. stripes  Number of horizontal stripes in the flag
  #10. colours  Number of different colours in the flag
  #11. red      0 if red absent, 1 if red present in the flag
  #12. green    same for green
  #13. blue     same for blue
  #14. gold     same for gold (also yellow)
  #15. white    same for white
  #16. black    same for black
  #17. orange   same for orange (also brown)
  #18. mainhue  predominant colour in the flag (tie-breaks decided by taking
  #                                           the topmost hue, if that fails then the most central hue,
  #                                          and if that fails the leftmost hue)
  #19. circles  Number of circles in the flag
  #20. crosses  Number of (upright) crosses
  #21. saltires Number of diagonal crosses
  #22. quarters Number of quartered sections
  #23. sunstars Number of sun or star symbols
  #24. crescent 1 if a crescent moon symbol present, else 0
  #25. triangle 1 if any triangles present, 0 otherwise
  #26. icon     1 if an inanimate image present (e.g., a boat), otherwise 0
  #27. animate  1 if an animate image (e.g., an eagle, a tree, a human hand)
  #present, 0 otherwise
  #28. text     1 if any letters or writing on the flag (e.g., a motto or
  #                                                    slogan), 0 otherwise
  #29. topleft  colour in the top-left corner (moving right to decide 
  #                                          tie-breaks)
  #30. botright Colour in the bottom-left corner (moving left to decide 
  #                                               tie-breaks)

  #8. Missing values: None

class(flags) # [1] data.frame

#That just tells us that the entire dataset is stored as a 'data.frame', which 
# doesn't answer our question. What we really need is to call the class() 
# function on each individual column. While we could do this manually (i.e. one 
# column at a time) it's much faster if we can automate the process. Sounds 
# like a loop!


#The lapply() function takes a list as input, applies a function to each element 
# of the list, then returns a list of the same length as the original one. Since 
# a data frame is really just a list of vectors (you can see this with 
# as.list(flags)), we can use lapply() to apply the class() function to each 
# column of the flags dataset. Let's see it in action!

#Type cls_list <- lapply(flags, class) to apply the class() function to each 
# column of the flags dataset and store the result in a variable called cls_list.
# Note that you just supply the name of the function you want to apply (i.e.
# class), without the usual parentheses after it.

cls_list <- lapply(flags, class)
cls_list
    #$name
    #[1] "character"

    #$landmass
    #[1] "integer"

    #$zone
    #[1] "integer"

    #... for every variable

#The 'l' in 'lapply' stands for 'list'. Type class(cls_list) to confirm that 
# lapply() returned a list.

class(cls_list) # [1] "list"

#As expected, we got a list of length 30 -- one element for each variable/column.
# The output would be considerably more compact if we could represent it as a 
# vector instead of a list.

#You may remember from a previous lesson that lists are most helpful for storing 
# multiple classes of data. In this case, since every element of the list 
# returned by lapply() is a character vector of length one (i.e. "integer" and 
# "vector"), cls_list can be simplified to a character vector. To do this 
# manually, type as.character(cls_list).

as.character(cls_list) # [1] "character" "integer" ... for all variables

#sapply() allows you to automate this process by calling lapply() behind the 
# scenes, but then attempting to simplify (hence the 's' in 'sapply') the result 
# for you. Use sapply() the same way you used lapply() to get the class of each 
# column of the flags dataset and store the result in cls_vect. If you need 
# help, type ?sapply to bring up the documentation.

?sapply # sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)
cls_vect <- sapply(flags, class)
class(cls_vect) # "character"

#In general, if the result is a list where every element is of length one, then 
# sapply() returns a vector. If the result is a list where every element is a 
# vector of the same length (> 1), sapply() returns a matrix. If sapply() can't 
# figure things out, then it just returns a list, no different from what 
# lapply() would give you.

#Columns 11 through 17 of our dataset are indicator variables, each representing 
# a different color. The value of the indicator variable is 1 if the color is 
# present in a country's flag and 0 otherwise.Therefore, if we want to know the 
# total number of countries (in our dataset) with, for example, the color orange 
# on their flag, we can just add up all of the 1s and 0s in the 'orange' column. 

sum(flags$orange) # [1] 26

#Now we want to repeat this for each of the colors recorded in the dataset.

flag_colors <- flags[, 11:17]
head(flag_colors)
    #  red green blue gold white black orange
    #1   1     1    0    1     1     1      0
    #2   1     0    0    1     0     1      0
    #...

# To get a list containing the sum of each column of flag_colors, call the 
# lapply() function with two arguments. The first argument is the object over 
# which we are looping (i.e. flag_colors) and the second argument is the name 
# of the function we wish to apply to each column (i.e. sum). Remember that the 
# second argument is just the name of the function with no parentheses, etc.

lapply(flag_colors, sum)
    #$red
    #[1] 153

    #$green
    #[1] 91

    #$blue
    #[1] 99

    #$gold
    #[1] 91

    #$white
    #[1] 146

    #$black
    #[1] 52

    #$orange
    #[1] 26

#The result is a list, since lapply() always returns a list. Each element of 
# this list is of length one, so the result can be simplified to a vector by 
# calling sapply() instead of lapply(). Try it now.

sapply(flag_colors, sum)
    #red  green   blue   gold  white  black orange 
    #153     91     99     91    146     52     26 

#Perhaps it's more informative to find the proportion of flags (out of 194) 
# containing each color. Since each column is just a bunch of 1s and 0s, the 
# arithmetic mean of each column will give us the proportion of 1s.

sapply(flag_colors, mean)
    #      red     green      blue      gold     white     black    orange 
    #0.7886598 0.4690722 0.5103093 0.4690722 0.7525773 0.2680412 0.1340206 

#In the examples we've looked at so far, sapply() has been able to simplify the 
# result to vector. That's because each element of the list returned by lapply() 
# was a vector of length one. Recall that sapply() instead returns a matrix 
# when each element of the list returned by lapply() is a vector of the same 
# length (> 1).

#To illustrate this, let's extract columns 19 through 23 from the flags dataset
# and store the result in a new data frame called flag_shapes.

flag_shapes <- flags[,19:23]

#Each of these columns (i.e. variables) represents the number of times a 
# particular shape or design appears on a country's flag. We are interested in 
# the minimum and maximum number of times each shape or design appears.

#The range() function returns the minimum and maximum of its first argument, 
# which should be a numeric vector. Use lapply() to apply the range function to
# each column of flag_shapes. Don't worry about storing the result in a new
# variable. By now, we know that lapply() always returns a list.

lapply(flag_shapes, range)
    #$circles
    #[1] 0 4

    #$crosses
    #[1] 0 2

    #$saltires
    #[1] 0 1

    #$quarters
    #[1] 0 4

    #$sunstars
    #[1]  0 50

shape_mat <- sapply(flag_shapes, range)
shape_mat

    #circles crosses saltires quarters sunstars
    #[1,]       0       0        0        0        0
    #[2,]       4       2        1        4       50

#Each column of shape_mat gives the minimum (row 1) and maximum (row 2) number 
# of times its respective shape appears in different flags.

class(shape_mat) # [1] "matrix" "array

#As we've seen, sapply() always attempts to simplify the result given by 
# lapply(). It has been successful in doing so for each of the examples we've 
# looked at so far. Let's look at an example where sapply() can't figure out 
# how to simplify the result and thus returns a list, no different from lapply()

#When given a vector, the unique() function returns a vector with all duplicate 
# elements removed. In other words, unique() returns a vector of only the 
# 'unique' elements. To see how it works, try unique(c(3, 4, 5, 5, 5, 6, 6)).

unique(c(3, 4, 5, 5, 5, 6, 6)) # [1] 3 4 5 6

#We want to know the unique values for each variable in the flags dataset. To 
# accomplish this, use lapply() to apply the unique() function to each column 
# in the flags dataset, storing the result in a variable called unique_vals.

unique_vals <- lapply(flags, unique)
unique_vals
    #...

    #$animate
    #[1] 0 1

    #$text
    #[1] 0 1

    #$topleft
    #[1] "black"  "red"    "green"  "blue"   "white"  "orange" "gold"  

    #$botright
    #[1] "green"  "red"    "white"  "black"  "blue"   "gold"   "orange" "brown" 


# Since unique_vals is a list, you can use what you've learned to determine the 
# length of each element of unique_vals (i.e. the number of unique values for 
# each variable). Simplify the result, if possible. Hint: Apply the length() 
# function to each element of unique_vals.

sapply(unique_vals, length)
    #name   landmass       zone       area population   language   religion
    #194          6          4        136         48         10          8

#The fact that the elements of the unique_vals list are all vectors of 
# *different* length poses a problem for sapply(), since there's no obvious way 
# of simplifying the result.

#Use sapply() to apply the unique() function to each column of the flags dataset 
# to see that you get the same unsimplified list that you got from lapply().

sapply(flags, unique)

#Occasionally, you may need to apply a function that is not yet defined, thus 
# requiring you to write your own. Writing functions in R is beyond the scope 
# of this lesson, but let's look at a quick example of how you might do so in 
# the context of loop functions.

#Pretend you are interested in only the second item from each element of the 
# unique_vals list that you just created. Since each element of the unique_vals 
# list is a vector and we're not aware of any built-in function in R that 
# returns the second element of a vector, we will construct our own function.

#lapply(unique_vals, function(elem) elem[2]) will return a list containing the 
# second item from each element of the unique_vals list. Note that our function 
# takes one argument, elem, which is just a 'dummy variable' that takes on the 
# value of each element of unique_vals, in turn.

lapply(unique_vals, function(elem) elem[2])

# The only difference between previous examples and this one is that we are 
# defining and using our own function right in the call to lapply(). Our 
# function has no name and disappears as soon as lapply() is done using it. 
# So-called 'anonymous functions' can be very useful when one of R's built-in 
# functions isn't an option.

