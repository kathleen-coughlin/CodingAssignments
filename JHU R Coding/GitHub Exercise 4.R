## MOTIVATION FOR THIS EXERCISE

#For this exercise, we will finish constructing the function 
# getPrimeNumbers(N = 1000) which will return all the prime numbers between 1 
# and the positive integer N. We will use the isItPrime(n) function constructed 
# in the previous exercise, which tests whether the positive integer n is a 
# prime number. This illustrates construction of a function in several steps 
# & in a modular fashion, allowing for flexibility & easier testing & debugging.

# IS IT PRIME V2 from exercise 3

isItPrimeV2 <- function(n){
  nint <- as.integer(n)
  if(nint!=n) stop ("n must be an integer")
  if(nint<0) stop ("n must be a positive integer")
  #if(nint>1000000) stop ("n must be an integer less than 1,000,000")
  
  if(n==1) return (FALSE)
  if(n==2) return (TRUE)
  if(n==3) return (TRUE)
  
  lastdiv <- as.integer(sqrt(n)) + 1L
  
  for(i in 2L:lastdiv){
    if((n%%i)==0) return (FALSE)
  }
  
  return(TRUE)
}


#Use a for loop and use isItPrime(n) to test each positive integer n between 2 
# and N to see if it is prime. Return the integers that are found to be prime 
# in a vector called, for example, primes_up_to_N

## GET PRIME NUMBERS FUNCTION VERSION 1
getPrimeNumbersV1 <- function(n){
  nint <- as.integer(n)
  
  if(nint!=n) stop("n must be an integer")
  if(nint<2) stop ("n must be at least 2")
  if(nint>1000000) stop("n must be an integer less than 1,000,000")
  
  primes_up_to_N <- integer(0)
  
  for(i in 2L:nint){
    if(isItPrimeV2(i)==TRUE){
      primes_up_to_N <- c(primes_up_to_N, i)
    }
  }
  
  return(primes_up_to_N)
}

## TEST

getPrimeNumbersV1(3) # [1] 2 3
getPrimeNumbersV1(5) # [1] 2 3 5
getPrimeNumbersV1(8) # [1] 2 3 5 7
getPrimeNumbersV1(22) # [1] 2 3 5 7 11 17 19


## GET PRIME NUMERS VERSION 2: RUNNING INDEX

getPrimeNumbersV2 <- function(n){
  nint <- as.integer(n)
  
  if(nint!=n) stop("n must be an integer")
  if(nint<2) stop ("n must be at least 2")
  if(nint>1000000) stop("n must be an integer less than 1,000,000")
  
  k <- 0
  primes_up_to_N <- integer(0)
  
  for(i in 2L:nint){
    if(isItPrimeV2(i)==TRUE){
      k <- k + 1
      primes_up_to_N[k] <- i
    }
  }
  
  return(primes_up_to_N)
}

## TEST

getPrimeNumbersV2(3) # [1] 2 3
getPrimeNumbersV2(5) # [1] 2 3 5
getPrimeNumbersV2(8) # [1] 2 3 5 7
getPrimeNumbersV2(15) # [1] 2 3 5 7 11 13


## GET PRIME NUMBERS VERSION 3 : READLINE FUNCTION TO OVERRIDE

getPrimeNumbersV3 <- function(n){
  nint <- as.integer(n)
  
  if(nint!=n) stop("n must be an integer")
  if(nint<2) stop ("n must be at least 2")
  if(nint>1000000) {
    cat("N= ", n, "\n")
    yes.or.no <- readline("This N is large. Do you want to continue? Type yes or no")
    if(yes.or.no != "yes") return ("n was too large. getPrimeNumbersV3 exited.")
  }
  
  k <- 0
  primes_up_to_N <- integer(0)
  
  for(i in 2L:nint){
    if(isItPrimeV2(i)==TRUE){
      k <- k + 1
      primes_up_to_N[k] <- i
    }
  }
  
  return(primes_up_to_N)
}

## TEST
getPrimeNumbersV3(25) # 2 4 5 7 11 13 17 19 23

primes.for.N.equal.a.million <- getPrimeNumbersV3(1000000)
length(primes.for.N.equal.a.million) # 78498
primes.for.N.equal.a.million[1000] #7919
primes.for.N.equal.a.million[10000] # 104729
tail(primes.for.N.equal.a.million) #999931 999953 999961 999979 999983

