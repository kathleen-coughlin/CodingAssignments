#Importing cancer data for Statistical Thinking for Public Health MOOC
#Kathleen Coughlin
#August 14, 2022

#getwd()
setwd("~/R Programs")
data <- read.csv("CourseraCancerData.csv", header=TRUE, sep=',')
head(data)

data[4,] # shows the 4th row
data[,5] # shows the 5th column
data[2,3] # value in the 2nd row, 4th column
data[1:5,] # all columns in rowws 1-5 
dim(data) # number or rows and columns
data[,'gender'] # all rows for the column labeled gender
gender <- data[,'gender'] # save the gender column as its own variables

# Unless you tell it, R will assume all numerical variables are non-categorical
# Change it to categorical, or a factor

gender <- as.factor(data[,'gender'])
table(gender)

bmi <- data[,'bmi']
summary(bmi)

fruit <- data[,'fruit']
veg <- data[, 'veg']
fruitveg <- fruit + veg
table(fruitveg)
hist(fruitveg)

# Can also refer to columns with the dollar sign
g$fruitveg <- g$fruit + g$veg
table(g$fruitveg)

#Explore the rest of the variables
library(tidyverse)
str(data)
age <- data$age
smoking <- as.factor(data$smoking) # 1 missing value
cancer <- as.factor(data$cancer)
exercise <- as.factor(data$exercise)

table(cancer)

summary(age)
hist(age)

prop.table(table(cancer, gender), 2)
data %>% 
    group_by(gender) %>%
    summarise(mean=mean(bmi), median=median(bmi), IQR=IQR(bmi))

table(smoking)
prop.table(table(cancer, smoking), 2)

table(exercise)
prop.table(table(cancer, exercise), 2)

#Adding additional arguments to hist()

hist(fruitveg, xlab = "Portions of fruit and vegetables",
     main = "Daily consumption of fruit and vegetables combined", axes = F)
axis(side = 1, at = seq(0, 11, 1))
axis(side = 2, at = seq(0, 16, 2))

# Making a histogram through ggplot2

ggplot(data = data) + 
    geom_histogram(aes(x = fruitveg), 
                   bins=10, 
                   fill="darkgreen", 
                   col="black") +
    labs(x="Portions of fruit and vegetables", y="Frequency") +
    scale_x_continuous(breaks=seq(from = 0, to = 12, by = 1)) +
    theme_bw()

#Dicotomize BMI into "normal" and "not normal" and change the axis labels on the histogram
#Healthy BMI (18.5-24.9 inclusive)
    # This is how I did it
data <- data %>% 
    mutate(bmiBuckets = case_when(
        bmi >= 18.4 & bmi <=24.9 ~"Normal",
        TRUE ~"Abnormal"
    ))

bmiBuckets <- as.factor(data$bmiBuckets)

ggplot(data = data) + 
    geom_histogram(aes(x = fruitveg), 
                   bins=10, 
                   fill="darkgreen", 
                   col="black") +
    labs(x="Portions of fruit and vegetables", y="Frequency") +
    scale_x_continuous(breaks=seq(from = 0, to = 12, by = 1)) +
    theme_bw() +
    facet_wrap(~bmiBuckets)

    #This is how they suggested I do it
data$healthy_BMI <- ifelse(data$bmi > 18.5 & data$bmi < 25, 1, 0)
table(data$healthy_BMI)

hist(g$fruit, xlab = "Portions of fruit",
     main = "Daily consumption of fruit", axes = F)
axis(side = 1, at = seq(0, 4, 1))
axis(side = 2, at = seq(0, 24, 4))

hist(g$veg, xlab = "Portions of vegetables",
     main = "Daily consumption of vegetables", axes = F)
axis(side = 1, at = seq(0, 9, 1))
axis(side = 2, at = seq(0, 18, 2))

ggplot() + geom_histogram(data = g, aes(x = fruit), bins = 5, fill = "darkgreen", col = "black") +
    theme_bw() + labs(x = "Portions of fruit", y = "Frequency") +
    scale_x_continuous(breaks = seq(from = 0, to = 4, by = 1))

ggplot() + geom_histogram(data = g, aes(x = veg), bins = 10, fill = "darkgreen", col = "black") + 
    theme_bw() + labs(x = "Portions of vegetables", y = "Frequency") + 
    scale_x_continuous(breaks = seq(from = 0, to = 9, by = 1))


## Hypothesis Testing
# Chi-Squared Test
data <- data %>% 
    mutate(five_a_day = case_when(
        fruitveg >= 5 ~ "Yes",
        TRUE ~"No"
    ))
five_a_day <- as.factor(data$five_a_day)
chisq.test(x=five_a_day, y=cancer)

#Independent sample t-test
t.test(bmi~cancer)
t.test(bmi, mu=25) # the null hypothesis here is that the mean BMI is 25


# How I did it
data <- data %>% 
    mutate(overweight = case_when(
        bmi >= 25 ~"Yes",
        TRUE ~"No"
    ))
overweight <- as.factor(data$overweight)


chisq.test(x=overweight, y=cancer)
