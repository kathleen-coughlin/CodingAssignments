### LESSON 13: SIMULATION

##One of the great advantages of using a statistical programming language like 
# R is its vast collection of tools for simulating random numbers.

##This lesson assumes familiarity with a few common probability distributions, 
# but these topics will only be discussed with respect to random number 
# generation. Even if you have no prior experience with these concepts, you 
# should be able to complete the lesson and understand the main ideas.

##The first function we'll use to generate random numbers is sample(). Use 
# ?sample to pull up the documentation.
?sample #sample(x, size, replace = FALSE, prob = NULL)

##Let's simulate rolling four six-sided dice: sample(1:6, 4, replace = TRUE).
sample(1:6, 4, replace=TRUE) # [1] 4 5 1 5

##Now repeat the command to see how your result differs. (The probability of 
# rolling the exact same result is (1/6)^4 = 0.00077, which is pretty small!)
sample(1:6, 4, replace=TRUE) # [1] 6 3 4 6

##sample(1:6, 4, replace = TRUE) instructs R to randomly select four numbers 
# between 1 and 6, WITH replacement. Sampling with replacement simply means 
# that each number is "replaced" after it is selected, so that the same number
# can show up more than once. This is what we want here, since what you roll on
# one die shouldn't affect what you roll on any of the others.

##Now sample 10 numbers between 1 and 20, WITHOUT replacement. To sample without 
# replacement, simply leave off the 'replace' argument.
sample(1:20, 10) # [1] 2 4 3 11 1 9 8 5 10 19

##Since the last command sampled without replacement, no number appears more 
# than once in the output.

##LETTERS is a predefined variable in R containing a vector of all 26 letters 
# of the English alphabet. Take a look at it now
LETTERS # "A" "B" "C" "D" "E" .... (prints all 26 in uppercase)

##The sample() function can also be used to permute, or rearrange, the elements 
# of a vector. For example, try sample(LETTERS) to permute all 26 letters of 
# the English alphabet.
sample(LETTERS) # [1] "G" "N" "S" "Z" "D" ... (samples until it gets to all 26)

##This is identical to taking a sample of size 26 from LETTERS, without 
# replacement. When the 'size' argument to sample() is not specified, R takes a
# sample equal in size to the vector from which you are sampling.

##Let the value 0 represent tails and the value 1 represent heads. Use sample() 
# to draw a sample of size 100 from the vector c(0,1), with replacement. Since 
# the coin is unfair, we must attach specific probabilities to the values 0 
# (tails) and 1 (heads) with a fourth argument, prob = c(0.3, 0.7). Assign the 
# result to a new variable called flips.
flips <- sample(c(0, 1), 100, replace=TRUE, prob=c(0.3, 0.7))
flips # [1] 1 1 0 1 0 1 1 1 0 1 1 1 1 - 1 1 0 1 1 1 1 1 1 1 .... (prints 100)

##Since we set the probability of landing heads on any given flip to be 0.7, 
# we'd expect approximately 70 of our coin flips to have the value 1. Count the
# actual number of 1s contained in flips using the sum() function.
sum(flips) # [1] 66

##A coin flip is a binary outcome (0 or 1) & we are performing 100 independent 
# trials (coin flips), so we can use rbinom() to simulate a binomial random 
# variable. Pull up the documentation for rbinom() using ?rbinom.
?rbinom # rbinom(n, size, prob)
        # dbinom(x, size, prob, log = FALSE)
        # pbinom(q, size, prob, lower.tail = TRUE, log.p = FALSE)
        # qbinom(p, size, prob, lower.tail = TRUE, log.p = FALSE)

##Each probability distribution in R has an r*** function (for "random"), a 
# d*** function (for "density"), a p*** (for "probability"), and q*** (for 
# "quantile"). We are most interested in the r*** functions in this lesson, but 
# I encourage you to explore the others on your own.

##A binomial random variable represents the number of 'successes' (heads) in a 
# given number of independent 'trials' (coin flips). Therefore, we can generate 
# a single random variable that represents the number of heads in 100 flips of 
# our unfair coin using rbinom(1, size = 100, prob = 0.7). Note that you only 
# specify the probability of 'success' (heads) and NOT the probability of '
# failure' (tails). Try it now.

rbinom(1, size=100, prob=0.7) # [1] 69

##Equivalently, if we want to see all of the 0s and 1s, we can request 100 
# observations, each of size 1, with success probability of 0.7. Give it a 
# try, assigning the result to a new variable called flips2.

flips2 <- rbinom(100, size=1, prob=0.7)
flips2 # [1] 1 1 1 9 1 1 1 0 0 0 1 1 1 1 0 1 1 0 0 0 0 0 1 1 0 1 .......

##Now use sum() to count the number of 1s (heads) in flips2. It should be close 
# to 70!
sum(flips2) # [1] 69

##Similar to rbinom(), we can use R to simulate random numbers from many other 
# probability distributions. Pull up the documentation for rnorm() now.
?rnorm # rnorm(n, mean=0, sd=1)
        # dnorm(x, mean=0, sd=1, log=FALSE)
        # pnorm(q, mean=0, sd=1, lower.tail=TRUE, log.p=FALSE)
        # qnorm(p, mean=0, sd=1, lower.tail=TRUE, log.p=FALSE)

##The standard normal distribution has mean 0 and standard deviation 1. As you 
# can see under the 'Usage' section in the documentation, the default values 
# for the 'mean' and 'sd' arguments to rnorm() are 0 and 1, respectively. Thus, 
# rnorm(10) will generate 10 random numbers from a standard normal distribution.
# Give it a try
rnorm(10) # [1] -1.34448085 -0.01183973 -1.25992830  1.57146270 ... (10 shown)

##Now do the same, except with a mean of 100 and a standard deviation of 25.
rnorm(n=10, mean=100, sd=25) #  [1] 118.01834 118.69223  73.13373 110.50092 ....

##Finally, what if we want to simulate 100 *groups* of random numbers, each 
# containing 5 values generated from a Poisson distribution with mean 10? Let's 
# start with one group of 5 numbers, then I'll show you how to repeat the 
# operation 100 times in a convenient and compact way.

##Generate 5 random values from a Poisson distribution with mean 10. Check out 
# the documentation for rpois() if you need help.
rpois(5, 10) # [1]  6 11  4 10 15

##Now use replicate(100, rpois(5, 10)) to perform this operation 100 times. 
# Store the result in a new variable called my_pois
my_pois <- replicate(100, rpois(5, 10))
my_pois # matrix with 100 cols & 5 rows

##replicate() created a matrix, each column of which contains 5 random numbers
# generated from a Poisson distribution with mean 10. Now we can find the mean 
# of each column in my_pois using the colMeans() function. Store the result in 
# a variable called cm.
cm <- colMeans(my_pois)

## And let's take a look at the distribution of our column means by plotting a 
# histogram with hist(cm).
hist(cm) # visible to right x-axis=cm, y=frequency

##Looks like our column means are almost normally distributed, right? That's 
# the Central Limit Theorem at work, but that's a lesson for another day!

##Simulation is practically a field of its own and we've only skimmed the 
# surface of what's possible. I encourage you to explore these and other 
# functions further on your own.
