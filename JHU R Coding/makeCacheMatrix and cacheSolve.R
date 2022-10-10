#Assignment Directions:

#Matrix inversion is usually a costly computation and there may be some benefit
# to caching the inverse of a matrix rather than compute it repeatedly (there 
# are also alternatives to matrix inversion that we will not discuss here). 
# Your assignment is to write a pair of functions that cache the inverse of a 
# matrix. Write the following functions:
    #makeCacheMatrix
    #cacheSolve


# This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(m=matrix()){
    inv <- NULL # reset any previous inv value
    
    #clear any previously cached inverse or m
    setInput <- function(y){
        # assign input argument to the m object in parent environment
        m <<- y 
        #  assign NULL to the inv onject in parent environment
        inv <<- NULL
    } 

    #retrieve m from makeCacheMatrix parent environment
    getInput <- function() m 
    
    #set the value of the inverse and save to parent environment
    setInverse <- function(solve) inv<<- solve
 
    #find the right value for inv
    getInverse <- function() inv
    
    #define list of functions, name list elements & return to parent envirnoment
    list(setInput=setInput, getInput=getInput, setInverse=setInverse, 
         getInverse=getInverse)
}


#This function computes the inverse of the special "matrix" returned by 
# makeCacheMatrix above. If the inverse has already been calculated (and the 
# matrix has not changed), then the cachesolve should retrieve the inverse from
# the cache.
cacheSolve <- function(m, ...){
    # 
    inv <- m$getInverse()
    
    #if previously cached, retrieve inverse and return
    if(!is.null(inv)){
        message("getting cached data")
        return(inv)
    }
    
    #if no cached inverse, assign matrix to variable data
    data <- m$getInput()
    
    #getInverse for variable data assiged above
    inv <- solve(data, ...)
    
    #setInverse based on previous set
    m$setInverse(inv)
    
    #return the value of inv
    inv
}


#Test Matrix 1
#Define test matrix
m1 <- matrix(c(1/2, -1/4, -1, 3/4), nrow = 2, ncol = 2)
m1
solve(m1)
myMatrix_object <- makeCacheMatrix(m1)
myMatrix_object$getInput()
myMatrix_object$getInverse()
cacheSolve(myMatrix_object)

#Test Matrix 2
n2 <- matrix(c(5/8, -1/8, -7/8, 3/8), nrow = 2, ncol = 2)
n2
solve(n2)
myMatrix2_object <- makeCacheMatrix(n2)
cacheSolve(myMatrix2_object)
