## MOTIVATION FOR THIS EXERCISE

#The input data for many functions will be or include a tab delimited text file 
# that comes from or is naturally viewed as an Excel spreadsheet. For example, 
# the last programming assignment in the R Programming course uses a .csv 
# (comma separated variables) text file appropriately read in using R's read.csv 
# function. It has a total of 46 columns, only 5 of which are relevant to the 
# assignment (Excel columns B, G, K, Q and W). For this and many other 
# situations, it would be convenient to have an R function that would take as 
# its input an Excel column name (as a character variable) and output the 
# corresponding column number.

## COL NAME TO NUMBER FUNCTION

colnameToNumber <- function(colname){
  # colname should be a lower case letter in the
  colname <- tolower(colname)
  
  #create vectors of letter strings
  az <- letters 
  aaz <- paste("a", az, sep="")
  baz <- paste("b", az, sep="")
  caz <- paste("c", az, sep="")
  daz <- paste("d", az, sep="")
  
  #combine the letter vectors into one
  a_thru_dz <- c(az, aaz, baz, caz, daz)
  
  # to the corresponding column number
  colnumber <- which(a_thru_dz==colname)
  
  #test for having found a (unique) match
  if(length(colnumber) !=1) stop("no match to colname")
  
  #return the column number
  return(colnumber)
}

## TEST
colnameToNumber("a") # [1] 1
colnameToNumber("z") # [1] 26
colnameToNumber("aa") # [1] 27
colnameToNumber("az") # [1] 52
colnameToNumber("ba") # [1] 53
colnameToNumber("dz") # [1] 130


## COL VEC TO NUMBERS FUNCTION

colvecToNumbers <- function(colvec){
  #manage invalid inputs
  if(length(colvec)<1) stop ("colvec is empty. Input column name(s)")
  if(!is.character(colvec)) stop ("colvec input must be characters")

  #colvec should be lower case letters in the
  colvec <- tolower(colvec)
  
  #create integer vector to be output
  n <- length(colvec)
  colnumbers <- integer(n)
    
  #use colnameToNumber to get each entry of colnumbers
  for(i in 1:n){
    colname <- colvec[i]
    colnumbers[i] <- colnameToNumber(colname)
  }
  
  #return the column number
  return(colnumbers)
}


## TEST
colvec <- c("b", "g", "k")
colvecToNumbers(colvec) # [1] 2 7 11

colvec <- c("a", "aa", "ba", "ca", "da")
colvecToNumbers(colvec) # [1] 1 27 53 79 105

colvec <- c("z", "az", "bz", "cz", "dz")
colvecToNumbers(colvec) # [1] 26 52 78 104 130


## LATER WITH SAPPLY

colvec <- c("z", "az", "bz", "cz", "dz")
sapply(colvec, colnameToNumber)
      #  z  az  bz  cz  dz 
      # 26  52  78 104 130 

colvec <- c("b", "g", "k")
sapply(colvec, colnameToNumber)
      # b  g  k 
      # 2  7 11 