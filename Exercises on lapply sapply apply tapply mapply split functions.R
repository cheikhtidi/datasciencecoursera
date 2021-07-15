library(datasets)
head(iris)
s=split(iris,iris$Species)
s
class(s)

#There will be an object called ‘iris’ in your workspace.
#In this dataset, what is the mean of ‘Sepal.Length’ 
#for the species virginica? Please round your answer
#to the nearest whole number.

#1st method

s=split(iris,iris$Species)
s
class(s)
round(mean(s$virginica$Sepal.Length))

#2nd method

round(mean(iris[which(iris$Species == "virginica"),]$Sepal.Length))

#3rd method

sapply(s, function(x) round(colMeans(x[,c("Sepal.Length","Sepal.Width")],na.rm=T)))



#Continuing with the ‘iris’ dataset from the previous
#Question, what R code returns a vector of the means
#of the variables ‘Sepal.Length’, ‘Sepal.Width’,
#‘Petal.Length’, and ‘Petal.Width’?

apply(iris[,1:4],2,mean)

#Load the 'mtcars' dataset in R with the following 
#code

library(datasets)
data(mtcars)
str(mtcars)
summary(mtcars)


#How can one calculate the average miles per gallon 
#(mpg) by number of cylinders in the car (cyl)? 
#Select all that apply.

# 1st method

with(mtcars,tapply(mpg,cyl,mean))

# 2nd method

tapply(mtcars$mpg, mtcars$cyl, mean)

# 3rd method
sapply(split(mtcars$mpg, mtcars$cyl), mean)


#4. Continuing with the ‘mtcars’ dataset from the 
#previous Question, what is the absolute difference 
#between the average horsepower of 4-cylinder cars
#and the average horsepower of 8-cylinder cars?
  
#(Please round your final answer to the nearest
#whole number. Only enter the numeric result and 
#nothing else.)

new <- tapply(mtcars$hp, mtcars$cyl, mean)
new
round(abs(new[3]-new[1]))

