#Simulation
#Generating random numbers
#Functions for probability distributions in R

#rnorm: generate random Normal variates with a given mean
#and standard deviation 

#dnorm: evaluate the Normal probability density (with a
#given mean/std) at a point (or vector of points)

#pnorm: evaluate the cumulative distribution function
#for a Normal distribution 

#rpois: generate random Poisson variates with a given
#rate

#Probability distribution functions usually have
#four functions associated with them
#The functions are prefixed with a

#d for density
#r for random number generation
#p for cumulative distribution
#q for quantile function

#Working with the Normal distributions requires using
#these four functions

# dnorm(x, mean=0, sd=1, log=FALSE)
# pnorm(q, mean=0, sd=1, lower.tail=TRUE, log.p=FALSE)
# qnorm(p, mean=0, sd=1, lower.tail=TRUE, log.p=FALSE)
# rnorm(n,mean=0,sd=1)

# If Q is the cumulative distribution function for a
# standard Normal distribution, then pnorm(q)=Q(q)
# and qnorm(p)=inv(Q)(p)
? pnorm
x=rnorm(10)
x
x=rnorm(10,20,2)
x
summary(x)

#setting the random number with set.seed ensures 
#reproducibility
set.seed(1)
rnorm(5)
rnorm(5)
set.seed(1)
rnorm(5)

#Always set the random number seed when conducting
#a simulation

#Generating Poisson data
rpois(10,1) #generate 10 poisson variates with rate 1
rpois(10,2) #generate 10 poisson variates with rate 2
rpois(10,20) #generate 10 poisson variates with rate 20

ppois(2,2) #cumulative distribution
           #Pr(x<=2)
ppois(4,2) #Pr(x<=4)


