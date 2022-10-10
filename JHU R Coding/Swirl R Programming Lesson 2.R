#Determine which directory your R session is using as its current working 
#directory using getwd().
getwd()    #"C:/Users/kmc27/OneDrive/Documents/R Programs"

#List all the objects in your local workspace using ls().
ls() #"my_div"  "my_sqrt" "x"       "y"       "z"

x<- 9
ls()

#List all the files in your working directory using list.files() or dir().
list.files() #"Swirl R Programming Lesson 1.R"

#One of the most helpful parts of any R help file is the See Also section.
?list.files

#Using the args() function on a function name is also a handy way to see what 
# arguments a function can take.
args(list.files)

#function (path = ".", pattern = NULL, all.files = FALSE, full.names = FALSE, 
#recursive = FALSE, ignore.case = FALSE, include.dirs = FALSE, 
#no.. = FALSE) 
#NULL

old.dir <- getwd()

#Use dir.create() to create a directory in the current working directory 
# called "testdir".
dir.create("testdir")
?dir.create

setwd("testdir")
#In general, you will want your working directory to be someplace sensible, 
# perhaps created for the specific project that you are working on. In fact, 
# organizing your work in R packages using RStudio is an excellent option. 

file.create("mytest.R")

#This should be the only file in this newly created directory. Let's check this 
# by listing all the files in the current directory.

list.files()    #"mytest.R"
file.exists("mytest.R")    #TRUE

#These sorts of functions are excessive for interactive use. But, if you are 
# running a program that loops through a series of files and does some 
# processing on each one, you will want to check to see that each exists before 
# you try to process it.

file.info("mytest.R")
         #size isdir mode       mtime          ctime               atime               exe
#mytest.R  0 FALSE  666 2022-05-17 10:42:02   2022-05-17 10:42:02 2022-05-17 10:42:02  no

#You can use the $ operator to grab  specific items.
file.info("mytest.R")$mode

file.rename("mytest.R", "mytest2.R")

file.copy("mytest2.R", "mytest3.R")

#You now have two files in the current directory. That may not seem very 
# interesting. But what if you were working with dozens, or millions, of 
# individual files? In that case, being able to programatically act on many 
# files would be absolutely necessary

#Provide the relative path to the file "mytest3.R"
file.path("mytest3.R") # "mytest3.R"

# You can use file.path to construct file and directory paths that are 
# independent of the operating system your R code is running on. Pass 'folder1' 
# & 'folder2' as arguments to file.path to make a platform-independent pathname.

file.path("folder1", "folder2")

?dir.create
#Take a look at the documentation for dir.create. Notice the 'recursive' arg.
# In order to create nested directories, 'recursive' must be set to TRUE


#Create a directory in the current working directory called "testdir2" and a 
# subdirectory for it called "testdir3", all in one command.

dir.create(file.path("testdir2", "testdir3"), recursive=TRUE)

setwd(old.dir)

#It is often helpful to save the settings that you had before you began an 
# analysis & then go back to them at the end. This trick's often used within 
# functions; you save, say, the par() settings that you started with, mess 
# around, & then set them back to the original values at the end. This isn't the 
# same as what we have done here, but it seems similar enough to mention.

