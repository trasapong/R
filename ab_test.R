# A/B test

# Hypothesis test of one variant
# H0: p = 0.17
# H1: p != 0.17

prop.test(x=150,n=900,p=0.17,correct = FALSE)
(xsq <- ((150-(0.17*900))^2)/(0.17*900) + ((750-(0.83*900))^2)/(0.83*900))
1-pchisq(xsq,1)

prop.test(x=150,n=900,p=0.17,correct = TRUE)   # default of correct = TRUE

# Hypothesis test of two variants (A/B test)
# V1: 120 clicks, 800 impressions
# V2: 100 clicks, 700 impressions

# H0: p1 = p2
# H1: p1 != p2

x <- c(120,100)
n <- c(800,700)
(a <- prop.test(x,n,correct = FALSE))
(pp1 <- sum(x)/sum(n))
(pp2 <- 1-pp1)
(xsq <- ((120-(pp1*800))^2)/(pp1*800) + 
    ((680-(pp2*800))^2)/(pp2*800) +
    ((100-(pp1*700))^2)/(pp1*700) + 
    ((600-(pp2*700))^2)/(pp2*700))
1-pchisq(xsq,1)

# Hypothesis test of k variants (A/B/n test)
# H0: p1 = p2 = ... = pk
# H1: pi are not all equal

(x <- seq(from=80, by=5, length.out = 8))
(n <- rep(1000,8))
a <- prop.test(x,n)
attributes(a)
(pp1 <- sum(x)/sum(n))
(pp2 <- 1-pp1)
(xsq <- sum(c(((x - pp1*n)^2/(pp1*n)),(((n-x) - pp2*n)^2/(pp2*n))))) 
1-pchisq(xsq,7)
