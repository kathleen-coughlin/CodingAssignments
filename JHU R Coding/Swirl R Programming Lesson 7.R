#In this lesson, we cover matrices & data frames. Both represent 'rectangular' 
# data types, meaning  they are used to store tabular data, with rows & columns.

# The main difference is that matrices can only contain a single class of data, 
# while data frames can consist of many different classes of data.

my_vector <- 1:20
my_vector # 1 2 3 ..... 19 20

#The dim() function tells us the 'dimensions' of an object.
dim(my_vector) # NULL

#Since my_vector is a vector, it doesn't have a `dim` attribute (so it's just 
# NULL), but we can find its length using the length() function
length(my_vector) #20

#What happens if we give my_vector a `dim` attribute? 
dim(my_vector) <- c(4, 5)
#The dim() function allows you to get OR set the `dim` attribute for an object. 
# Here, we assigned the value c(4, 5) to the `dim` attribute of my_vector.
dim(my_vector) # 4 5
#Another way to see this is by calling the attributes() function on my_vector.
attributes(my_vector) # $dim 4 5

#Just like in math class, when dealing with a 2-dimensional object (think 
# rectangular table), the first number is the number of rows and the second is 
# the number of columns. Therefore, we just gave my_vector 4 rows and 5 columns.

#Now it's a matrix
my_vector
#       [,1] [,2] [,3] [,4] [,5]
# [1,]    1    5    9   13   17
# [2,]    2    6   10   14   18
# [3,]    3    7   11   15   19
# [4,]    4    8   12   16   20

class(my_vector) # "matrix" "array"
my_matrix <- my_vector

#A matrix is simply an atomic vector with a dimension attribute. 
#A more direct method of creating the same matrix uses the matrix() function.

?matrix
#matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, dimnames = NULL)

my_matrix2 <- matrix(1:20, nrow=4, ncol=5)
identical(my_matrix, my_matrix2) #TRUE

#We may want to label the rows. One way to do this is to add a column to the 
# matrix, which contains the names of each observation/individual/etc.

patients <- c("Bill", "Gina", "Kelly", "Sean")

# Now we'll use the cbind() function to 'combine columns'. 
cbind(patients, my_matrix)
# patients                       
# [1,] "Bill"   "1" "5" "9"  "13" "17"
# [2,] "Gina"   "2" "6" "10" "14" "18"
# [3,] "Kelly"  "3" "7" "11" "15" "19"
# [4,] "Sean"   "4" "8" "12" "16" "20"

#Something is fishy about our result! It appears that combining the character 
# vector with our matrix of numbers caused everything to be enclosed in double 
# quotes. This means we're left with a matrix of character strings, which is no 
# good. If you remember back to the beginning of this lesson, I told you that 
# matrices can only contain ONE class of data. Therefore, when we tried to 
# combine a character vector with a numeric matrix, R was forced to 'coerce' the 
# numbers to characters, hence the double quotes.

#This is called 'implicit coercion', bc we didn't ask for it. It just happened.

#We're still left with the question of how to include the names of our patients 
# in the table without destroying the integrity of our numeric data.

my_data <- data.frame(patients, my_matrix)
my_data
#   patients X1 X2 X3 X4 X5
# 1     Bill  1  5  9 13 17
# 2     Gina  2  6 10 14 18
# 3    Kelly  3  7 11 15 19
# 4     Sean  4  8 12 16 20


#The data.frame() function takes any number of arguments &  returns a single 
# object of class `data.frame` that's composed of the original objects.
class(my_data)  # "data.frame"

#It's also possible to assign names to the individual rows & columns of a df

#Create a character vector containong one element for each column. Then, use 
# the colnames() function to set the `colnames` attribute for our data frame. 
# This is similar to the way we used the dim() function earlier in this lesson.
cnames <- c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data) <- cnames
my_data
#   patient age weight bp rating test
# 1    Bill   1      5  9     13   17
# 2    Gina   2      6 10     14   18
# 3   Kelly   3      7 11     15   19
# 4    Sean   4      8 12     16   20