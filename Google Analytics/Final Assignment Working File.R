## Part 1: PLOT THE 30-DAY MORTALITY RATES FOR HEART ATTACKS

outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")
head(outcome)
str(outcome) # 'data.frame':	4706 obs. of  46 variables
colnames(outcome)
lapply(outcome, class)

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

## Part 2: FINDING THE BEST HOSPITAL IN A STATE

##Write a function called best that take two arguments: the 2-character 
# abbreviated name of a state and an outcome name. The function reads the 
# outcome-of-care-measures.csv file and returns a character vector with the 
# name of the hospital that has the best (i.e. lowest) 30-day mortality for the
# specified outcome in that state. The hospital name is the name provided in 
# the Hospital.Name variable. The outcomes can be one of “heart attack”, 
# “heart failure”, or “pneumonia”. Hospitals that do not have data on a 
# particular outcome should be excluded from the set of hospitals when deciding
# the rankings

best <- function(state, outcome){
    #read file
    df <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)

    #Valid inputs
    outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23) 
    state_list <- state.abb
    
    #Control for invalid inputs
    if(!state %in% state_list) stop("Input valid 2-letter state abbreviation")
    if((outcome %in% names(outcomes)) == FALSE) stop ("Input a valid outcome")
    
    #Simplify data frame: subset & rename columns, complete cases, filter & order rows
    df_neededCols <- df[, c(2,7,outcomes[outcome])]
    names(df_neededCols) <- c("hospital", "state", "outcome")
    CompleteDF <- na.omit(df_neededCols)
    statesubset <- CompleteDF[(CompleteDF[,"state"]==state),]
    ranked <- statesubset[order(statesubset[,"outcome"]),]
    
    #Find best hospital.name
    best_hospital <- ranked[1, 1]

    return(best_hospital)
}

best("SC", "heart attack") # [1] "MUSC MEDICAL CENTER"
best("NY", "pneumonia") #[1] "MAIMONIDES MEDICAL CENTER"
best("AK", "pneumonia") #[1] "YUKON KUSKOKWIM DELTA REG HOSPITAL"
  
## Part 3 : RANKING HOSPITALS BY OUTCOME IN A STATE

##Write a function called rankhospital that takes three arguments: the 
# 2-character abbreviated name of a state (state), an outcome (outcome), and the 
# ranking of a hospital in that state for that outcome (num). The function reads 
# the outcome-of-care-measures.csv file and returns a character vector with the 
# name of the hospital that has the ranking specified by the num argument. The 
# num argument can take values “best”, “worst”, or an integer indicating the 
# ranking (smaller numbers are better). If the number given by num is larger 
# than the number of hospitals in that state, then the function should return 
# NA. Hospitals that do not have data on a particular outcome should be 
# excluded from the set of hospitals when deciding the rankings.

rankhospital <- function(state, outcome, num = "best"){
    #Read data
    df <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)
   
    #Valid inputs
    outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23) 
    state_list <- state.abb
    
    #Control for invalid inputs
    if(!state %in% state_list) stop("Input valid 2-letter state abbreviation")
    if((outcome %in% names(outcomes)) == FALSE) stop ("Input a valid outcome")
    if(!is.character(num) && !is.numeric(num)) stop("num must be an integer or the character string 'best' or 'worst'")
 
    #Simplify data frame: subset & rename columns, complete cases, filter & order rows
    df_neededCols <- df[, c(2,7,outcomes[outcome])]
    names(df_neededCols) <- c("hospital", "state", "outcome")
    CompleteDF <- na.omit(df_neededCols)
    statesubset <- CompleteDF[(CompleteDF[,"state"]==state),]
    ranked <- statesubset[order(statesubset[,"outcome"], statesubset[,"hospital"]),]

    #Define exceptional cases
    if(num=="worst") num <- nrow(ranked)
    if(num=="best") {num <- 1}  
    if(num > nrow(ranked)) return(NA)
        
    #Return hospital name in that state with the given rank 30-day death rate
    return(ranked[num, 1]) #return the first column and the row equal to num
}

rankhospital("NC", "heart attack", "worst") # [1] "WAYNE MEMORIAL HOSPITAL"
rankhospital("WA", "heart attack", 7) #  [1] "YAKIMA VALLEY MEMORIAL HOSPITAL"
rankhospital("TX", "pneumonia", 10) # "SETON SMITHVILLE REGIONAL HOSPITAL"
rankhospital("NY", "heart attack", 7) # "BELLVUE HOSPITAL CENTER"

## Part 4: RANKING HOSPITALS IN ALL STATES

##Write a function called rankall that takes two arguments: an outcome name 
# (outcome) and a hospital ranking (num). The function reads the 
# outcome-of-care-measures.csv file and returns a 2-column data frame 
# containing the hospital in each state that has the ranking specified in num. 
# For example the function call rankall("heart attack", "best") would return a 
# data frame containing the names of the hospitals that are the best in their 
# respective states for 30-day heart attack death rates. The function should 
# return a value for every state (some may be NA). The first column in the data 
# frame is named hospital, which contains the hospital name, and the second 
# column is named state, which contains the 2-character abbreviation for the 
# state name. Hospitals that do not have data on a particular outcome should be 
# excluded from the set of hospitals when deciding the rankings. 

rankall <- function(outcome, num="best"){
    #Read data
    df <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)
    
    #Valid inputs
    outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23) 
    state_list <- state.abb
    
    #Control for invalid inputs
    if((outcome %in% names(outcomes)) == FALSE) stop ("Input a valid outcome")
    if(!is.character(num) && !is.numeric(num)) stop("num must be an integer or the character string 'best' or 'worst'")
    
    #Simplify data frame: subset & rename columns, complete cases, order
    df_neededCols <- df[, c(2,7,outcomes[outcome])]
    names(df_neededCols) <- c("hospital", "state", "outcome")
    CompleteDF <- na.omit(df_neededCols)
    Sorted <- CompleteDF[order(CompleteDF[,"outcome"], CompleteDF[,"hospital"]),]
    
    #Split into states
    s <- split(Sorted, Sorted$state)
 
    #Find hospital at defined rank, sapply should simplify back into one df
    ranked <- lapply(X=s, FUN=function(X){          # initiate sapply for each state
        if(num=="worst") {num <- nrow(X)}           # define "worst"
        if(num=="best") {num <- 1}                  # define "best"
        X[num, c("hospital", "state")]              # subset the num-th row & columns hospital.name & state
    })
    
    #Return a data frame with the hospital names and (abbreviate) state name
    return(do.call(rbind, ranked))
}

r <- rankall("heart attack", 4)
as.character(subset(r, state =="HI")$hospital) # [1] "CASTLE MEDICAL CENTER"

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital) # [1] "BERGEN REGIONAL MEDICAL CENTER"

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital) # [1] "RENOWN SOUTH MEADOWS MEDICAL CENTER"
