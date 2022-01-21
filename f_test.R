# f-test 
# to compare 2 var from Normal dist
# var1 = var2 ?
# or testing the ratio var1/var2 = 1?

?var.test

set.seed(100)
x <- rnorm(50, mean = 0, sd = 2)
y <- rnorm(30, mean = 1, sd = 1)

# ex.1 *****************************
# two-sided
var.test(x, y)                  # Do x and y have the same variance?

# how to find f 
(f <- var(x)/var(y))

# how to find p.value
# if f > 1, use (p <- 2*(1-pf(f,,)))
# else use (p <- 2*pf(f,,))
# two-sided -> multiply by 2
(p <- 2*(1-pf(f,49,29)))

# how to find 95% conf int
# *swap df
alpha <- 0.05
(L <- f*qf(alpha/2,29,49))
(U <- f*qf(1-alpha/2,29,49))

# ex.2 *****************************
# two-sided (swap x and y)
var.test(y, x)                  # Do x and y have the same variance?

# how to find f 
(f <- var(y)/var(x))

# how to find p.value
# if f > 1, use (p <- 2*(1-pf(f,,)))
# else use (p <- 2*pf(f,,))
# two-sided -> multiply by 2
(p <- 2*pf(f,29,49))

# how to find 95% conf int
# *swap df
alpha <- 0.05
(L <- f*qf(alpha/2,49,29))
(U <- f*qf(1-alpha/2,49,29))

# ex.3 *****************************
# one-sided, right
var.test(x, y, alt="g")                  

# how to find f 
(f <- var(x)/var(y))

# how to find p.value
# one-sided
(p <- (1-pf(f,49,29)))

# how to find 95% conf int
# *swap df
alpha <- 0.05
(L <- f*qf(alpha,29,49))

# ex.4 *****************************
# one-sided, left
var.test(x, y, alt="l")                  

# how to find f 
(f <- var(x)/var(y))

# how to find p.value
# one-sided
(p <- pf(f,49,29))

# how to find 95% conf int
# *swap df
alpha <- 0.05
(U <- f*qf(1-alpha,29,49))

# ex.5 *****************************
# one-sided, left
var.test(y, x, alt="l")                  
       
# how to find f 
(f <- var(y)/var(x))

# how to find p.value
# one-sided
(p <- pf(f,29,49))

# how to find 95% conf int
# *swap df
alpha <- 0.05
(U <- f*qf(1-alpha,49,29))

#*********************************************************************
# A test of a specific blood factor for adults in Scotland & Ireland

# 15 randomly selected patients suffering from the disease in Scotland
dataSco <- c(113,115,120,109,105,103,103,99,128,96,125,107,115,131,119)

# 14 randomly selected patients suffering from the disease in Ireland
dataIre <- c(120,140,112,109,114,116,99,108,109,111,109,131,117,101)
# from entire pop of Sco & Ire -> assume both data sets are from normal dist.

# to test the populations that samples have been drawn from have equal variance
# H0 : varSco = varIre
# Ha : varSco != varIre
# or
# H0 : varSco/varIre = 1
# Ha : varSco/varIre != 1

var.test(dataSco, dataIre)
# Null : true ratio of variances is equal to 1
# high p-value -> Fail to reject Null -> 
# Conclusion: At 95% conf.level, we don't have enough evidence to conclude that Scottish patient population and Irish patient population have different variance. 
# (at 95% confidence level)

# how to find f 
(f <- var(dataSco)/var(dataIre))

# how to find p.value
(p <- 2*pf(f,14,13))

# how to find 95% conf int
alpha <- 0.05
(L <- f*qf(alpha/2,13,14))
(U <- f*qf(1-alpha/2,13,14))
#

#or
#(f <- var(dataIre)/var(dataSco))
#(p <- 2*(1-pf(f,13,14)))
#alpha <- 0.05
#(L <- f*qf(alpha/2,14,13))
#(U <- f*qf(1-alpha/2,14,13))

#********EOF************
