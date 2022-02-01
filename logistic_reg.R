#logistic_reg.R

##########################################
Age <- c(18, 23, 24, 26, 30, 35, 37, 40, 42, 46, 50, 55)
Sub <- c(0,0,0,1,0,0,1,0,1,1,1,1)
cbind(Age,Sub)
plot(Age,Sub)
(model <- glm(Sub~Age,family = binomial(link = logit)))
summary(model)
plot(Age,model$fitted.values)
predict(model, data.frame(Age=41), type="response")
coef(model)
(logOdds <- coef(model)["(Intercept)"] + (coef(model)["Age"]*41))
(odds <- exp(logOdds))
(prob <- odds / (1+odds))
#p-value > alpha (0.05) not reject null hypo = Model is adequate
1-pchisq(10.705,10)
#critical value
qchisq(0.95,10)

################################################################

Years <- c(5.8,15,21.5,27.5,33.5,39.5,46,51.5)
Cases <- c(0,1,3,8,9,8,10,5)
Miners <- c(98,54,43,48,51,38,28,11)
(pneu <- data.frame(Years,Cases,Miners))
(cw <- cbind(Cases,Miners-Cases))
(model <- glm(cw~Years,family = binomial(link = logit),data=pneu))
summary(model)

plot(Years, model$fitted.values)
points(Years,Cases/Miners,col="red")

plot(Years, model$fitted.values, xlim = c(0,100),ylim = c(0,1))
points(Years,Cases/Miners,col="red")

predict(model, data.frame(Years=31), type="response")
coef(model)
(logOdds <- coef(model)["(Intercept)"] + (coef(model)["Years"]*31))
(odds <- exp(logOdds))
(prob <- odds / (1+odds))

(odds2 <- odds*exp(coef(model)["Years"]))
(prob2 <- odds2 / (1+odds2))

#critical value
qchisq(0.95,6)

#p-value (p>alpha = not reject null=Model is adequate)
1-pchisq(6.0508,6)

###################################################
setwd("C:/Users/trasa/Google Drive/work/Courses/R_teaching_resources/R_code/data")
mydata <- read.table(file="binary.csv", header = TRUE, sep=",")
# mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
# rank = school tier
head(mydata)
summary(mydata)
str(mydata)
sapply(mydata, sd)
xtabs(~ admit + rank, data = mydata)
mydata$rank <- factor(mydata$rank)
mylogit <- glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")
summary(mylogit)
predict(mylogit, data.frame(gre=590,gpa=2.0,rank="1"), type="response")
(logOdds1 <- coef(mylogit)["(Intercept)"] + (coef(mylogit)["gre"]*590) + (coef(mylogit)["gpa"]*2))
(odds1 <- exp(logOdds1))
(p1 <- odds1/(1+odds1))

predict(mylogit, data.frame(gre=590,gpa=3.0,rank="1"), type="response")
(logOdds2 <- coef(mylogit)["(Intercept)"] + (coef(mylogit)["gre"]*590) + (coef(mylogit)["gpa"]*3))
(odds2 <- exp(logOdds2))
(p2 <- odds2/(1+odds2))

# odds2 = odds1 * exp(b_gpa)
coef(mylogit)["gpa"]   # b_gpa
exp(coef(mylogit)["gpa"])   # exp(b_gpa)
odds1*exp(coef(mylogit)["gpa"])  
odds2

predict(mylogit, data.frame(gre=690,gpa=3.0,rank="1"), type="response")
(logOdds1 <- coef(mylogit)["(Intercept)"] + (coef(mylogit)["gre"]*690) + (coef(mylogit)["gpa"]*3))
(odds1 <- exp(logOdds1))
(p1 <- odds1/(1+odds1))

predict(mylogit, data.frame(gre=690,gpa=3.0,rank="4"), type="response")
(logOdds2 <- coef(mylogit)["(Intercept)"] + (coef(mylogit)["gre"]*690) + (coef(mylogit)["gpa"]*3) + coef(mylogit)["rank4"])
(odds2 <- exp(logOdds2))
(p2 <- odds2/(1+odds2))

# odds2 = odds1 * exp(b_rank4)
coef(mylogit)["rank4"]   # b_rank4
exp(coef(mylogit)["rank4"])   # exp(b_rank4)
odds1*exp(coef(mylogit)["rank4"])  
odds2

# exp(-rank2 est)
# neg value rank2 = odds of admitted is ... of the odds of rank1 admission
exp(mylogit$coefficients["rank2"])

# rank1 : rank2
1/exp(mylogit$coefficients["rank2"])

# exp(rank2)/exp(rank3) : (rank2/rank1) / (rank3/rank1) = (rank2/rank3)
exp(mylogit$coefficients["rank2"])/exp(mylogit$coefficients["rank3"])

summary(mylogit)
#critical value
qchisq(0.95,394)
#p-value 
1-pchisq(458.52,394)

confint(mylogit)
#---- eof --------------------
