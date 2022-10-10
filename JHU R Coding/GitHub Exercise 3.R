## MOTIVATION OF THIS EXERCISE

#If statements and for loops are basic constructs for constructing a function 
# that will carry out a specified computation. This exercise practices writing 
# a code containing if statements and a for loop that through a sequence of 
# steps computes the desired result. The specific function for this exercise is 
# described below.

isItPrimeV1 <- function(n){
  nint <- as.integer(n)
  if(nint!=n) stop ("n must be an integer")
  if(nint<0) stop ("n must be a positive integer")
  if(nint>1000000) stop ("n must be an integer less than 1,000,000")
  
  if(n==1) return(FALSE)
  if(n==2) return(TRUE)
  
  n_minus_1 <- nint - 1
  
  for(i in 2:n_minus_1){
    if((nint%%i) == 0) return (FALSE)
  }
  
  return(TRUE)
}

## TEST
isItPrimeV1(2) # [1] TRUE
isItPrimeV1(3) # [1] TRUE
isItPrimeV1(4) # [1] FALSE
isItPrimeV1(83) # [1] TRUE


# IS IT PRIME V2

isItPrimeV2 <- function(n){
  nint <- as.integer(n)
  if(nint!=n) stop ("n must be an integer")
  if(nint<0) stop ("n must be a positive integer")
  if(nint>1000000) stop ("n must be an integer less than 1,000,000")
  
  if(n==1) return (FALSE)
  if(n==2) return (TRUE)
  if(n==3) return (TRUE)
  
  lastdiv <- as.integer(sqrt(n)) + 1L
  
  for(i in 2L:lastdiv){
    if((n%%i)==0) return (FALSE)
  }
  
  return(TRUE)
}

## TEST
isItPrimeV2(1) # [1] FALSE
isItPrimeV2(2) # [1] TRUE
isItPrimeV2(3) # [1] TRUE
isItPrimeV2(11) # [1] TRUE
isItPrimeV2(83) # [1] TRUE

## IS IT PRIME V3

isItPrimeV3 <- function(n){
  nint <- as.integer(n)
  if(nint!=n) stop("n must be an integer")
  if(nint<0) stop ("n must be a positive integer")
  if(nint>1000000) stop ("n must be an integer less than 1,000,000")
  
  is_n_prime <- numeric(0)
  firstq <- numeric(0)
  
  if(n==1) return(c(is_n_prime=0, n=1, firstq=1))
  if(n==2) return(c(is_n_prime=1, n=2, firstq=2))
  if(n==3) return(c(is_n_prime=1, n=3, firstq=3))
  
  lastq <- as.integer(sqrt(n)) + 1L
  
  for(q in 2:lastq){
    if((n%%q)==0) return(c(is_n_prime=0, n=nint, firstq=q))
  }

  return(c(is_n_prime=1, n=nint, firstq=nint))
}

## TEST
isItPrimeV3(3)
      #is_n_prime          n     firstq 
      #         1          3          3
isItPrimeV3(6)
      #is_n_prime          n     firstq 
      #         0          6          2
isItPrimeV3(1000)
      #is_n_prime          n     firstq 
      #         0       1000          2 
isItPrimeV3(2047)
      #is_n_prime          n     firstq 
      #         0       2047         23 