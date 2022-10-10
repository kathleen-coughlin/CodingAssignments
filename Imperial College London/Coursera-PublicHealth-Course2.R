#### Lesson: 
#### Recap on Installing R

# Starting R and opening a data set
setwd("~/R Programs")
COPD <- read.csv("COPD_student_dataset.csv")

View(COPD)

colnames(COPD)
# "X", "ID", "AGE", "PackHistory", "COPDSEVERITY", "MWT1", MWT2", "MWT1Best"
# "FEV1", "FEV1PRED", "FVC", "FVCPRED", "CAT", "HAD", "SGRQ", "AGEquartiles"
# "copd", "gender", "smoking", "Diabetes", "muscular", "hypertension", 
# AtrialFib", "IHD" 




#### Lesson: 
#### Assessing distributions and calculating the correlation coefficient in R 




hist(COPD$MWT1Best, main="Histogram of MWT1Best", xlab="MWT1Best", breaks=12)

# The distribution looks reasonably symmetric and there is a distinctive peak 
# with a high proportion of patients walking between 400 to 500 meters in 6 
# minutes. There are no obvious impossible values, but there is quite a high 
# value which is above 650. For this specific value, you can look at it using 
# the subset() function. 

subset(COPD, MWT1Best > 650)

# Where you see this value with MWT1Best > 650 is observation number 100, of 
# sample ID 108, and its corresponding values for other variables in the 
# dataset. You can then see that value for this patient is 699, which is a high 
# value but not impossible. So your choice here is to check the original source 
# from whoever collected it, or leave it as it is. You should never delete an 
# unusual value if the value is a possible one. Deleting unusual values will 
# bias your results and cause you to underestimate the variability in the 
# observations. 

# If you now want to look at more than one value, let’s say samples which have 
# values of MWT1Best over 650 and under 150, you can use the following code: 

subset(COPD, MWT1Best >600 | MWT1Best <150)

# The output will now give you those two samples, of ID 58 and 108:

hist(COPD$FEV1, main="Histogram of FEV1", xlab="FEV1") 

# Here you can see a much flatter distribution, with the peak spread over a 
# larger range of values and the distribution has thinner tail. Again, there 
# are no impossible values here identified in this plot.    

# Descriptive statistics and two-way plots can tell you more about the data. 
# Useful statistics to summarize your data are: the mean, the standard 
# deviation, the range, the median, and the inter-quartile range.  

# Note that these will give an error message if there is a missing value 
# (i.e. NA) in your dataset, and you therefore need to specify that you want 
# the missing values removed from the calculation using the command 
# na.rm = TRUE. You can look at all of these statistics together using the 
# list() function.  

# To view descriptive statistics for MWT1Best, type the command:  

list("Summary" = summary(COPD$MWT1Best), 
     "Mean" = mean(COPD$MWT1Best, na.rm=TRUE), 
     "Standard Deviation" = sd(COPD$MWT1Best, na.rm=TRUE), 
     "Range" = range(COPD$MWT1Best, na.rm=TRUE), 
     "Inter-Quartile Range" = IQR(COPD$MWT1Best, na.rm=TRUE))

# For FEV1
list("Summary" = summary(COPD$FEV1), 
     "Mean" = mean(COPD$FEV1, na.rm=TRUE), 
     "Standard Deviation" = sd(COPD$FEV1, na.rm=TRUE), 
     "Range" = range(COPD$FEV1, na.rm=TRUE), 
     "Inter-Quartile Range" = IQR(COPD$FEV1, na.rm=TRUE))

# We can see that MWT1 has one patient with a missing value and all values 
# complete for FEV1. The mean and median values are similar for FEV1 but not so 
# MWT1Best so this suggests the distribution is a bit skewed. 

# And finally, let’s calculate the correlation coefficient and have a look at 
# the scatterplot of the two variables. The basic command for this is plot(x,y) 
# and you can rename the axes in the same way you did in the histogram. 

plot(COPD$FEV1, COPD$MWT1Best, xlab="FEV1", ylab="MWT1Best")

# The scatterplot shows an even distribution over both lung function and 
# walking distance with no discontinuations in either, or obvious outliers. So, 
# it is reasonable to calculate the Pearson’s correlation coefficient to assess 
# a linear association between the two variables. But we will also have a look 
# at the Spearman’s for comparison. 

# The basic command for a correlation test is cor.test(x,y) where you can 
# specify which method you want to use using the command  method = "pearson" 
# or "spearman". You need to remove missing values, otherwise you will have an 
# error message. To do this, use the command use = “complete.obs”. 

cor.test(COPD$FEV1, COPD$MWT1Best, use="complete.obs", method="pearson")

# Pearson’s correlation coefficient is 0.47 and the 95% confidence interval 
# suggests the population coefficient is likely to lie somewhere between 0.3 to 
# 0.6. The p value is less than 0.001 so there is very strong evidence against 
# the null hypothesis of the coefficient being zero.   

cor.test(COPD$FEV1, COPD$MWT1Best, use="complete.obs", method="spearman", exact=FALSE)

# The Spearman’s correlation coefficient provides a similar result with 
# estimated correlation of 0.45. 

# So, you have examined the raw data and found that it was fine, and that there 
# was only one missing value. You have discovered moderate correlation between 
# walking distance and lung function. 




#### Lesson (Practice)
#### Why Spearman's and Pearson's may differ slightly




# You’ve just looked at how to check and assess the association between walking 
# distance (MWT1best) and lung function (FEV1) in COPD patients. Repeat the 
# steps above but this time looking at the association between walking distance 
# (MWT1best) and age (AGE).  

hist(COPD$AGE, main="Histogram of AGE", xlab="AGE", breaks=10)

# Ages look like a reasonable distribution

list("Summary" = summary(COPD$AGE), 
     "Mean" = mean(COPD$AGE, na.rm=TRUE), 
     "Standard Deviation" = sd(COPD$AGE, na.rm=TRUE), 
     "Range" = range(COPD$AGE, na.rm=TRUE), 
     "Inter-Quartile Range" = IQR(COPD$AGE, na.rm=TRUE))

# Min=44, Med=71, Max=88, Mean=70.1, IQR=10

plot(COPD$AGE, COPD$MWT1Best, xlab="AGE", ylab="MWT1Best")

# The scatterplot shows an even distribution over both age and walking distance 
# with no discontinuations in either, or obvious outliers. So, it is reasonable 
# to calculate the Pearson’s correlation coefficient to assess a linear 
# association between the two variables. But we will also have a look at the 
# Spearman’s for comparison. 

cor.test(COPD$AGE, COPD$MWT1Best, use="complete.obs", method="pearson")

# Pearson’s correlation coefficient is -0.23 and the 95% confidence interval 
# suggests the population coefficient is likely to lie somewhere between -0.41
# to -0.04. The p value is greater than 0.001 (p=0.021) so there is not strong evidence against 
# the null hypothesis of the coefficient being zero.   

cor.test(COPD$AGE, COPD$MWT1Best, use="complete.obs", method="spearman", exact=FALSE)

# The Spearman’s correlation coefficient differs slightly with 
# estimated correlation of -0.27. However, the p-value here, while still above 
# 0.001 is much lower than  with Pearson. Spearman's correlation gives a
# p-value of 0.007. 




#### Lesson
#### How to fit a regression model in R




# To run a linear regression in R, the function you need to use is lm(). 
# The basic format of this function is: lm(outcome ~ predictor, data =dataframe)

MWT1Best_FEV1 <- lm(MWT1Best~FEV1, data=COPD)

# To view the output of this model, type:summary(modelname)

summary(MWT1Best_FEV1)

# Here, the (Intercept) indicates the regression constant α.  
# FEV1 indicates the linear effect of lung function, i.e. β.

# To view 95% confidence intervals, use the command confint(modelname)

confint(MWT1Best_FEV1)

# To check model assumptions, you can graphically examine the linear regression 
# model using the function plot(modelname). This function allows to check for linearity, 
# homoscedasticity, independence, and normality of your assumptions. Four plots 
# are generated: 
    # The first is a constant variance plot, which checks for the homogeneity 
        # of the variance and the linear relation. If you see no pattern in this 
        # graph, then your assumptions are met. 
    # The second plot is a Q-Q plot, which checks that the residuals follow a 
        # normal distribution. The points should fall on a line if the normality 
        # is met. 
    # The third plot allows to detect heterogeneity of the variance. 
    # The fourth plot allows for the detection of points that have a large 
        # impact on the regression coefficients. 

plot(MWT1Best_FEV1)

# You can view all 4 plots in one output by setting a viewing format of 2 by 2 
# plots, using the command: par(mfrow=c(2,2)) 

par(mfrow=c(2,2))
plot(MWT1Best_FEV1)

# If you want to go back to a viewing format of one plot per page after that, 
# simply use the command: par(mfrow=c(1,1)) 




#### Lesson:
#### Practice with R: Linear Regression





#You’ve just seen how to fit a linear regression model to quantify the 
# relationship between walking distance (MWT1best) and lung function (FEV1) in 
# COPD patients. In this practice with R, you’re going to repeat the steps from 
# before, but this time fit a linear regression model between walking distance 
# (MWT1best) and age (AGE).

MWT1Best_AGE <- lm(MWT1Best~AGE, data=COPD)
summary(MWT1Best_AGE)

# Here, the (Intercept) indicates the regression constant α. The estimate is 616.453  
# AGE indicates the linear effect of age, i.e. β. The estimate is -3.104

# This creates the model: MWT1Best = 616.45 + -3.10*AGE

# R-squared is 0.053
# Adjusted R-squared is 0.043
# p-value is 0.021

confint(MWT1Best_AGE)

# 95% confidence interval for intercept is: 432.02 to 801.88
# 95% confidence interval for AGE is: -5.74 to -0.47

par(mfrow=c(2,2))
plot(MWT1Best_AGE)

# Residuals vs. fitted sees clustering around 0, but with values below the line
# showing more variability than those above. 

# The QQ plot suggests some violation of the assumption of normality. The plot 
# shows values lying off the straight line including the middle section of the 
# plot. Recall that the QQ plot is a plot of the quartiles of the residuals 
# against the quartiles of a theoretical normal distribution and if the 
# residuals are normal then the observations will lie on a straight line. 


# Verify by examining a hsitogram of residyals which is fitted using the following command
predictedVals <- predict(MWT1Best_AGE) # What was this for?
residualVals <- residuals(MWT1Best_AGE)
hist(residualVals, main = "Histogram of residuals", xlab = "Residuals") 




#### Lesson:
#### Fitting the Multiple Regression in R




# The basic format of a multiple linear regression is: 
    # Y = α + β1*X1 + β2*X2 + ε 

# Where: 
    # Y = outcome (i.e. dependent) variable. 
    # X1 = first predictor (i.e. independent) variable. 
    # X2 = second predictor (i.e. independent) variable. 
    # α = intercept (average Y when X1=X2=0). Note: α is unit specific. 
    # β1 = slope of the line (change in Y for a 1 unit increase in X1 when X2 is held constant). Note: β1 is unit specific. 
    # Β2 = slope of the line (change in Y for a 1 unit increase in X2 when X1 is held constant). Note: β2 is unit specific. 
    # ε is the random variation in Y, i.e. the residuals. 

# To run a multiple linear regression in R, the basic format of the function is 
# very similar to that of a simple linear regression – the only difference is 
# that you are adding two predictor variables instead of one: 

# Model name <- lm(outcome ~ predictor1 + predictor2, data =dataframe) 

MWT1Best_FEV1_AGE <- lm(MWT1Best~FEV1+AGE, data=COPD)

# Where: 
    # MWT1Best_FEV1_AGE is the name of our model 
    # MWT1Best is the outcome variable 
    # FEV1 is the first predictor variable 
    # AGE is the second predictor variable 

summary(MWT1Best_FEV1_AGE)

# Here, the (Intercept) indicates the regression constant α. The estimate is 460.887  
# FEV1 indicates the linear effect of lung function, i.e. β1. The estimate is 71.278
# AGE indicates the linear effect of age, i.e. β2. The estimate is -2.519
# Residual standard error = 92.93 on 97 degrees of freedom

# This creates the model: MWT1Best = 460.887 + 71.278*FEV1 + -2.519*AGE

# Multiple R-squared is 0.2547
# Adjusted R-squared is 0.2394
# p-value is 6.419e-07

confint(MWT1Best_FEV1_AGE)

# 95% confidence interval for intercept is: 284.9 to 636.9 
# 95% confidence interval for FEV1 is: 43.67 to 98.99
# 95% confidence interval for AGE is: -4.88 to -0.16




#### Lesson:
#### Practice: Repeating the Regression Model




# Here we'll go through the steps again but this time replace FEV1 with FVC. 
# FVC is another measure of lung capacity: it is the total volume of air that a 
# patient can forcibly exhale in one breath.

# So, you’re going to fit a multiple linear regression model to examine the 
# relationship between walking distance (MWT1best), FVC (FVC) and age (AGE).

# Before you do that it’s helpful to go back a step. You already know what the 
# impact of age is on walking distance from practicing fitting the linear 
# regression, but - what about the relationship between walking distance and 
# FVC? It’s a good idea to fit this model first. If you do, you’ll be able to 
# compare the impact of including both predictors in your model like you did 
# previously. Do this yourself in R.

hist(COPD$FVC, main="Histogram of MWT1Best", xlab="FVC")

list("Summary" = summary(COPD$FVC), 
     "Mean" = mean(COPD$FVC, na.rm=TRUE), 
     "Standard Deviation" = sd(COPD$FVC, na.rm=TRUE), 
     "Range" = range(COPD$FVC, na.rm=TRUE), 
     "Inter-Quartile Range" = IQR(COPD$FVC, na.rm=TRUE))

# Min=1.14, Med=2.77, Max=5.37, Mean=2.95, IQR=1.36, sd=0.98

plot(COPD$FVC, COPD$MWT1Best, xlab="FVC", ylab="MWT1Best")

cor.test(COPD$FVC, COPD$MWT1Best, use="complete.obs", method="pearson")

# Pearson’s correlation coefficient is 0.446 and the 95% confidence interval 
# suggests the population coefficient is likely to lie somewhere between 0.27
# to 0.59. The p value is less than 0.001 (p=3.368e-06) so there is strong 
# evidence against the null hypothesis of the coefficient being zero.   

cor.test(COPD$FVC, COPD$MWT1Best, use="complete.obs", method="spearman", exact=FALSE)

# The Spearman’s correlation coefficient is fairly similar with estimated 
# correlation of 0.452 and a p-value here of 2.418e-06, still lower than 0.001. 

MWT1Best_FVC <- lm(MWT1Best~FVC, data=COPD)
summary(MWT1Best_FVC)

# Here, the (Intercept) indicates the regression constant α. The estimate is 254.951
# FVC indicates the linear effect of lung capacity, i.e. β. The estimate is 48.630

# This creates the model: MWT1Best = 254.95 + 45.64*FVC

# R-squared is 0.1987
# Adjusted R-squared is 0.1905
# p-value is 3.368e-06

confint(MWT1Best_FVC)

# 95% confidence interval for intercept is: 193.87 to 316.03
# 95% confidence interval for AGE is: 29.05 to 68.21

par(mfrow=c(2,2))
plot(MWT1Best_FVC)

# Not the best fit on residuals vs. fitted values. Clustering above and below 
# seems fine but not sticking to 0 line

# Q-Q plot has an excellent fit :)


# Once you’ve done that, you can fit the multiple regression model.  Remember 
# that walking distance (MWT1best) is the outcome variable and AGE and FVC are 
# the predictor variables.

MWT1Best_FVC_AGE <- lm(MWT1Best~FVC+AGE, data=COPD)

# Where: 
# MWT1Best_FEV1_AGE is the name of our model 
# MWT1Best is the outcome variable 
# FVC is the first predictor variable 
# AGE is the second predictor variable 

summary(MWT1Best_FVC_AGE)

# Here, the (Intercept) indicates the regression constant α. The estimate is 425.377  
# FVC indicates the linear effect of lung function, i.e. β1. The estimate is 46.058
# AGE indicates the linear effect of age, i.e. β2. The estimate is -2.325
# Residual standard error = 94.59 on 97 degrees of freedom

# This creates the model: MWT1Best = 425.377 + 46.058*FEV1 + -2.325*AGE

# Multiple R-squared is 0.2278
# Adjusted R-squared is 0.2119
# p-value is 3.588e-06

confint(MWT1Best_FVC_AGE)

# 95% confidence interval for intercept is: 238.6 to 612.1 
# 95% confidence interval for FEV1 is: 26.55 to 65.56
# 95% confidence interval for AGE is: -4.74 to 0.086


# Would you include FVC and FEV1 in the model with AGE? Multiple regression can 
# take multiple predictors so there’s no need to limit it to two variables. You 
# already know that FEV1 is a significant predictor of walking distance after 
# adjusting for AGE. Is there any reason why you wouldn’t want to include FVC 
# and FEV1 in the same model? 
    # Collinearity, don't do that 








# Installing packages
    #install.packages("Hmisc")
    #install.packages("gmodels")
    library(Hmisc)
    library(tidyverse)
    library(gmodels)

#Viewing the dataset
    
    #Print the first few rows of your dataset: 
    head(COPD)
    
    #See how many rows and columns you have in your dataset: 
    dim(COPD)
    
    #Look at the different variables in the dataset: 
    colnames(COPD) 
    
    #Look at all the values in a variable: print(variable)
    print(COPD$SGRQ)
    print(COPD$AGE)
    
    #To visualise the structure of the data in a variable: str(variable)
    str(COPD$FVC) 
    
    #Look at a specific value (x) in a variable: variable[x]
    COPD$gender[5]  
    
#For continuous variables
    #View number of values, missing values, mean and ranges using the describe() function from the ‘Hmisc’ package
    describe(COPD$X)
    describe(COPD$ID)
    describe(COPD$AGE)
    describe(COPD$PackHistory)
    describe(COPD$MWT1)
    describe(COPD$MWT2)
    describe(COPD$MWT1Best)
    describe(COPD$FEV1)
    describe(COPD$FEV1PRED)
    describe(COPD$CAT)
    describe(COPD$HAD)
    describe(COPD$SGRQ)

# For categorical variables
    #View number of values, missing values, mean and ranges using the describe() function from the ‘Hmisc’ package
        describe(COPD$COPDSEVERITY)
        describe(COPD$AGEquartiles)
        describe(COPD$copd)
        describe(COPD$gender)
        describe(COPD$smoking)
        describe(COPD$diabetes)
        describe(COPD$hypertension)
        describe(COPD$AtrialFib)
        describe(COPD$IHD)
    #OR Tabulate the data to view the number of values and their frequency using the CrossTable() function from the ‘gmodels package.
        CrossTable(COPD$COPDSEVERITY)
    #To view missing values, type: sum(is.na(variable)).
        sum(is.na(COPD$gender))
    
    
    #Viewing the categories and distribution of entries in a categorical variable: table(catvariable) 
    
    #You can add the argument exclude = NULL in the function parentheses to include missing values in the output. 
    
#Running a linear regression
    
   # The basic format is: 
        
        #modelname <- lm(outcome~predictor, data = dataframe) 
        #Viewing the regression model output: summary(modelname) 
        #Viewing the model 95% confidence intervals: confint(modelname) 
    
    #Drawing a Q-Q plot, constant variance plot, and other diagnostic plots 
    
        #Calculate predicted values: predict(modelname) 
        #Calculate residuals: residuals(modelname) 
        #Set a plotting format of 4 graphs: par(mfrow=c(2,2))
        #View the 4 resulting plots: plot(modelname) 
    
#Create a histogram 
    
    #The basic format is: hist(variablename) 
    #If you are getting a variable from the dataset, the $ sign allows R to locate this variable. E.g. COPD$MWT1Best 
    #To change the title of the histogram, use the command: main = “histogram title” 
    #Don’t forget quotation marks when using text! 
    #To change the x or y axes labels, use the commands: xlab = “x axis label” or ylab = “y axis label” 
    #Don’t forget quotation marks using text! 
    #To change the number of bins displayed, use the command main = to specify the number of bins you want to see. 
    #To look at specific values in your variable, you can use the subset() function, using the basic code subset(dataframe, variable > 15) if you want to see values over 15 for that variable. 
        #You can add additive rules by including ‘|’, e.g. subset(dataframe, variable1 > 15 | variable2 < 5) 


#Summary statistics  

    #Basic summary statistics (incl. minimum, medium, maximum, 1st and 3rd quartiles, and number of blank cells): summary(variablename) 
    #List of summary statistics, including the basic summary() outcome, standard deviation, range, and inter-quartile range:  
    #list(summary(variablename), sd(variablename, na.rm = TRUE), range(variablename, na.rm = TRUE), IQR(variablename, na.rm = TRUE)) 
    #Note that the na.rm = TRUE command tells R to remove NA values. Without this, an error message will be displayed    

#Correlation 
    
    #Scatterplot of two variables: plot(x, y) 
    #Correlation coefficient: cor(x, y) 
    #The default method is Pearson, but you can change this to Spearman by adding method = “spearman” in your parentheses. You need to remove missing values, otherwise you will get an error message. To do this, add use = “complete.obs” in your parentheses. 
    #Correlation test: cor.test(x, y) 
    #The default method is also Pearson here. You also need to remove missing values to avoid an error message.
    
#Creating a correlation matrix: 
    
    #Create a vector with the variables to include in the matrix,  e.g. data <- COPD[,c(“AGE”, “PackHistory”, “FEV1”)] 
    #Create the correlation matrix vector, assigning correlation coefficients of the different variables to it,  e.g. cor_matrix <- cor(data) 
    #View the matrix: e.g. cor_matrix to view the output and round(cor_matrix,2) to round this output to 2 decimal points. 
    #Visualising correlation between variables, i.e. correlation plot: pairs(~ variable1 + variable2 + variable3, data = dataframe) 
    
#Multiple linear regression... The basic format is: 
    
    #modelname <- lm(outcome~predictor1 +  predictor2, data = dataframe) 
    #Viewing the regression model output: summary(modelname) 
    #Viewing the model 95% confidence intervals: confint(modelname) 
    #Examining the VIF using the imcdiagF() function from the ‘mctest’ package. 
    
#Regression with categorical variables 
    
    #2 ways to do this: 
        #Check what the variable is saved as, change it to a factor variable if it is not saved as such. 
        #Check what the variable has been saved as using the class() function 
        #If it is not saved as a factor, can it using the factor() command, in the following format: variable <- factor(variable) 
        #Run the regression as normal 
        #Include factor() before the variable in the regression model. E.g. modelname <- lm(outcome~predictor1 + factor(predictor2),  data = dataframe) 
    
#Changing the reference category of a variable: 
        
    #Use the relevel() function in the following format: variable <- relevel(variable, ref = newreflevel) with the newreflevel  being the new reference level, written either as a numeric (1, 2, 3, …) or a character (in which case it needs to be written within apostrophes – “MILD”, “SEVERE”, …) 

#Changing data type for a variable 
    
    #Check what the variable has been as using the class() function. 
    #Changing data type: 
        #To numeric: as.numeric() 
        #To character: as.character() 
        #To factor: factor() or as.factor() 
        #To integer: as.integer() 

#Creating a new variable on R: e.g. variable ‘comorbid’  
    
    #comorbid is a variable you were asked to create. This variable was to be binary, and indicated the presence of at least one comorbidity (‘1’) or complete absence of comorbidities (‘0’) based on the responses to the variables: Diabetes, muscular, hypertension, AtrialFib, and IHD.  
    
    #Check that all variables are saved as the correct datatype. 
    #Create an empty vector of the correct length. 
    #Here, comorbid will be the same length as the other variables, so: 
    #comorbid <- length(COPD$Diabetes) 
    #Assign values to this vector. 
    #Here, we want comorbid = 1 when Diabetes OR muscular OR hypertension OR AtrialFib OR IHD = 1. So: comorbid[COPD$Diabetes == 1 | COPD$muscular == 1 | COPD$hypertension == 1 | COPD$AtrialFib == 1 | COPD$IHD == 1] <- 1  
    #This will assign 1 to the values meeting the set conditions, and NAs to those that are not meeting those conditions. 
    #We also want comorbid = 0 when ALL above variables = 0. So: comorbid[is.na(cormorbid)] <- 0 
    #Convert this variable to a factor. 
    #Optional: add the variable to the dataset, using the following command COPD$comorbid <- cormorbid 
    
#Regression with interaction effect 
    
    #Use the same format as a multiple linear regression, but include both terms, i.e. 
    #modelname <- lm(outcome~predictor1 +  predictor2 +  (predictor1 * predictor2),  
    #data = dataframe) 
    #Interpretation of the interaction effect can be simplified using the prediction() function from the ‘prediction’ package.