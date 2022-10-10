### LESSON 12: LOOKING AT DATA

##Whenever you're working with a new dataset, the first thing you should do is 
# look at it! What is the format of the data? What are the dimensions? What are 
# the variable names? How are the variables stored? Are there missing data? Are 
# there any flaws in the data?

##We'll be using a dataset constructed from the United States Department of
# Agriculture's PLANTS Database (http://plants.usda.gov/adv_search.html).

##Type ls() to list the variables in your workspace, among which should be plants.
ls() # [1] plants

##Let's begin by checking the class of the plants variable with class(plants). 
# This will give us a clue as to the overall structure of the data
class(plants) # [1] data.frame

##It's very common for data to be stored in a data frame. It is the default 
# class for data read into R using functions like read.csv() and read.table(), 
# which you'll learn about in another lesson.

##Since the dataset is stored in a data frame, we know it is rectangular. In 
# other words, it has two dimensions (rows and columns) and fits neatly into a 
# table or spreadsheet. Use dim(plants) to see exactly how many rows & columns 
# we're dealing with.
dim(plants) # [1] 5166  10

##You can also use nrow(plants) to see only the number of rows. And ncol(plants) 
# to see only the number of columns
nrow(plants) # [1] 5166
ncol(plants) # [1] 10

##If you are curious as to how much space the dataset is occupying in memory, 
# you can use object.size(plants)
object.size(plants) #745944 bytes

##Now that we have a sense of the shape and size of the dataset, let's get a 
# feel for what's inside. names(plants) will return a character vector of column
# (i.e. variable) names. Give it a shot.
names(plants) # [1] "Scientific_Name" "Duration" ... (lists all 10)

##We've applied fairly descriptive variable names to this dataset, but that 
# won't always be the case. A logical next step is to peek at the actual data.
# However, our dataset contains over 5000 observations (rows), so it's 
# impractical to view the whole thing all at once.


##The head() function allows you to preview the top of the dataset. Give it a 
# try with only one argument.
head(plants)

##Take a minute to look through and understand the output above. Each row is 
# labeled with the observation number and each column with the variable name. 
# Your screen is probably not wide enough to view all 10 columns side-by-side, 
# in which case R displays as many columns as it can on each line before 
# continuing on the next.

##By default, head() shows you the first six rows of the data. You can alter 
# this behavior by passing as a second argument the number of rows you'd like to 
# view. Use head() to preview the first 10 rows of plants.
head(plants, 10)

##The same applies for using tail() to preview the end of the dataset. Use 
# tail() to view the last 15 rows.
tail(plants, 15)

##After previewing the top and bottom of the data, you probably noticed lots of 
# NAs, which are R's placeholders for missing values. Use summary(plants) to 
# get a better feel for how each variable is distributed and how much of the 
# dataset is missing.
summary(plants)

##summary() provides different output for each variable, depending on its class. 
# For numeric data such as Precip_Min, summary() displays the minimum, 1st 
# quartile, median, mean, 3rd quartile, and maximum. These values help us 
# understand how the data are distributed.

##For categorical variables (called 'factor' variables in R), summary() displays
# the number of times each value (or 'level') occurs in the data. For example, 
# each value of Scientific_Name only appears once, since it is unique to a 
# specific plant. In contrast, the summary for Duration (also a factor 
# variable) tells us that our dataset contains 3031 Perennial plants, 682 
# Annual plants, etc.

##You can see that R truncated the summary for Active_Growth_Period by 
# including a catch-all category called 'Other'. Since it is a categorical/
# factor variable, we can see how many times each value actually occurs in the 
# data with table(plants$Active_Growth_Period).

table(plants$Active_Growth_Period)

##Perhaps the most useful and concise function for understanding the 
# *str*ucture of your data is str().
str(plants)

##The beauty of str() is that it combines many of the features of the other 
# functions you've already seen, all in a concise and readable format. At the 
# very top, it tells us that the class of plants is 'data.frame' and that it has 
# 5166 observations and 10 variables. It then gives us the name and class of 
# each variable, as well as a preview of its contents.

##str() is actually a very general function that you can use on most objects in 
# R. Any time you want to understand the structure of something (a dataset, 
# function, etc.), str() is a good place to start.

