# chi-square test
# Test of Goodness of Fit
# Ex.1
jobs <- c(11091, 11282, 15378, 12696)
names(jobs) <- c("Data Science", "Project Mngt", "Supply Chain", "Quality")
jobs 
jobs/sum(jobs)   # proportion
(prob <- rep(0.25,4))
# H0: Proportion of jobs in each category is 0.25 (variation due to chance or randomness)
# H1: Proportion of jobs in each category is not 0.25 
?chisq.test
(Xsq<-chisq.test(jobs, p = prob))
# degrees of freedom = No of categories - 1
attributes(Xsq)
Xsq$observed
Xsq$expected
(exp <- prob*sum(jobs))
(stat <- sum(((jobs-exp)^2)/exp))
1-pchisq(stat,3)   # p value
alpha <- 0.05
qchisq(1-alpha,3) # critical value

chisq.test(jobs)  # default p = 1/length
# different prob
(prob <- c(0.219,0.226,0.30,0.255))
chisq.test(jobs, p = prob)

# Test of Independence
# Ex.2
Voter <- rbind(c(2792, 3591), c(1486, 2131))
dimnames(Voter) <- list(Voting = c("voted", "didn't vote"),
                        Gender = c("male","female"))
Voter # Contingency Table
# H0: Gender is independent of voting
# H1: Gender and voting are dependent
chisq.test(Voter)

# Ex.3
# 500 randomly selected car owners were questioned on the main reason 
# they purchased their current car. The results are given below:
#          Style    Engineering   FuelEconomy   Total
#  Male      70         130         150           350
#  Female    30          20         100           150
#           100         150         250           500
#  Give the conclusion for this test with 90% confidence level.
Buyer <- rbind(c(70,130,150),c(30,20,100))
dimnames(Buyer) <- list(Gender = c("Male","Female"),
                        Reason = c("Style","Engineering","FuelEconomy"))
Buyer
# H0: Buying reason is independent of gender
# H1: Buying reason is NOT independent of gender
(Xsq <- chisq.test(Buyer))
# df = (df for reason)*(df for gender) = (3-1)*(2-1) = 2*1 = 2
Xsq$expected
(a <- as.matrix(rowSums(Buyer)/sum(Buyer)))
(b <- t(as.matrix(colSums(Buyer))))
(ex <- a %*% b)
(X <- sum(((Buyer - ex)^2)/ex))
1-pchisq(X,2) # p value
alpha <- 0.1
qchisq(1-alpha,2) # critical value

# Ex.4 
library(MASS)
?survey
head(survey)
summary(survey)
str(survey)
table(survey$Exer, survey$Smoke) # contingency table
addmargins(table(survey$Exer, survey$Smoke)) # small values
 
(Exer2 <- survey$Exer)
summary(Exer2)
levels(Exer2)           # alphabetical order
Exer2 <- factor(Exer2,levels(Exer2)[c(2,3,1)])  # rearrange order
table(survey$Exer, survey$Smoke) 
table(Exer2, survey$Smoke) 

(Smoke2 <- survey$Smoke)
summary(Smoke2)
levels(Smoke2)         # alphabetical order
Smoke2 <- factor(Smoke2,levels(Smoke2)[c(2,3,4,1)]) # rearrange order
summary(Smoke2)
table(survey$Exer, survey$Smoke)
table(Exer2, Smoke2)

(Xsq <- chisq.test(survey$Exer, survey$Smoke))

(Xsq <- chisq.test(Exer2, Smoke2))
# large p -> fail to reject null -> 
# not enough evidence to conclude that Exer & Smoke are dep
# warning due to some "expected" values < 5
Xsq$expected

qchisq(0.95,6)  # cv

levels(Exer2)
levels(Exer2) <- c("NotFreq","NotFreq","Freq")
summary(Exer2)
table(Exer2, Smoke2)
(Xsq <- chisq.test(Exer2, Smoke2))
Xsq$expected
qchisq(0.95,3)  # cv

# Ex.5 Cont.from Ex.3  (exp freq < 5)
Buyer <- rbind(c(2,130,150),c(3,20,100))
dimnames(Buyer) <- list(Gender = c("Male","Female"),
                        Reason = c("Style","Engineering","FuelEconomy"))
Buyer
# H0: Buying reason is independent of gender
# H1: Buying reason is NOT independent of gender
(Xsq <- chisq.test(Buyer))
Xsq$expected
# warning due to exp freq < 5
chisq.test(Buyer, simulate.p.value = TRUE, B = 10000)
chisq.test(Buyer, simulate.p.value = TRUE, B = 50000)
# EOF ----------------------------
