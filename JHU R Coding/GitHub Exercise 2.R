## MOTIVATION FOR THIS EXERCISE

#If statements are a basic construct for determining which commands or blocks 
# of commands should be executed. The specific function for this exercise is 
# described below.


## SOME IF, ELSE IF, ELSE TEMPLATES

#Below are templates for common if statement constructs. Note it is helpful to 
# use indentation of lines of code and blank spaces between sections of code as 
# illustrated below. The number of spaces of indentation is somewhat a personal 
# choice, balancing making code easy to read by having separate blocks of code 
# stand out by having more spaces in indentations, with not having too many R 
# commands extend over more than 1 line (and in general, don't go over 80 
# characters in a line). The motivation is that code that is easier to read is 
# easier to proofread and spot bugs in.

if (condition1) short.code  # short.code is a short R command 
# condition1 (and below, condition2, condition3) is a logical statement evaluating to TRUE or FALSE
# when condition1 is true, execute the short.code statement



if (condition1) { 
  code1  # where code1 (and below, code2, code3, code4) stands for one or more lines of code
}
# when condition1 is true, execute code1



if (condition1) { 
  code1
} else {
  code2
} 
# when condition1 is TRUE, then the line(s) of code1 are executed,
# otherwise the line(s) of code2 are executed



if (condition1) { 
  code1
} else if (condition2) {
  code2
}
# when condition1 is TRUE, code1 is executed
# when condition1 is FALSE, then code2 will be executed if condition2 is TRUE;
# when neither condition is TRUE, neither code1 nor code2 get executed, and
# R "proceeds" to the next line of code



# The full range of possibilities within one if, else if, else block are
# illustrated here
if (condition1) { 
  code1
} else if (condition2) {
  code2
} else if (condition3) {
  code3
} else {
  code4
}
# there can be any (reasonable) number of "else ifs"


# Another quick way to use a sequence of if tests when there are only
# a few cases is shown in this example, of getting the rgb (red, green, blue)
# color scale values when there are only a couple possible color names.
# This is, if nothing else, code that is easy to read/understand

rgbvec <- 0 # when, after the if statements, rgbvec is still 0, throw an error
if(color == "Magenta") rgbvec <- c(255, 0, 255)
if(color == "ForestGreen") rgbvec <- c(34, 139, 34)
if(color == "Cyan") rgbvec <- c(0, 255, 255)
# test that color matched one of the above choices
if(identical(rgbvec, 0)) stop("color did not match one of the choices")

# This is just an example, for "real" use for getting rgb colors one would want to have a data frame
# with this information (many color names and corresponding rgb values) 
# and extract the rgb values for a given color from it.
# The color information above came from
# https://en.wikipedia.org/wiki/Web_colors
# side note: there are web sites for checking how a color figure would appear
# to people with various types of color blindness, for example
# https://www.color-blindness.com/coblis-color-blindness-simulator/


## PVAL TO 3 SIG DIGITS

pval_To_3Sig_Digits <- function(pval){
  if(!is.numeric(pval))stop("pval must be numeric")
  if(pval <0 || pval > 1) stop("pval must be a number between 0 and 1")
  if(pval<0.00001) stop("p<0.00001")
  
  if(pval<0.0001){
    pstring <- as.character(round(pval, digits=7))
  } else if (pval<0.001){
    pstring <- as.character(round(pval, digits=6))
  } else if (pval <0.01) {
    pstring <- as.character(round(pval, digits=5))
  } else if (pval <0.1) {
    pstring <- as.character(round(pval, digits=4))
  } else {
    pstring <- as.character(round(pval, digits=3))
  }

  return(pstring)
}

## TEST
pval_To_3Sig_Digits(1.0) # [1] "1
pval_To_3Sig_Digits(0.123456) # [1] "0.123"
pval_To_3Sig_Digits(0.0123456) # [1] "0.0123"
pval_To_3Sig_Digits(0.00123456) # [1] "0.00123"
pval_To_3Sig_Digits(0.000123456) # [1] "0.000123"
pval_To_3Sig_Digits(0.0000123456) # [1] "1.23e-05"
pval_To_3Sig_Digits(0.00000123345)
          # "Error in pval_To_3Sig_Digits(1.12345e-05) : p<0.00001


