# R for Everyone, ch 11, Group Manipulation

#11.1 Apply family
#11.1.1 apply
(theMatrix <- matrix(1:9, nrow = 3))
apply(theMatrix, 1, sum)
apply(theMatrix, 2, sum)
rowSums(theMatrix)
colSums(theMatrix)
theMatrix[2,1] <- NA
theMatrix
apply(theMatrix, 1, sum)
apply(theMatrix, 1, sum, na.rm = TRUE)
?apply
rowSums(theMatrix)
rowSums(theMatrix, na.rm = TRUE)
?rowSums

#11.1.2 lapply and sapply
theList <- list(A=matrix(1:9,3),B=1:5,C=matrix(1:4,2),D=2)
theList
lapply(theList, sum)
sapply(theList, sum)
theNames <- c("Jared","Deb","Paul")
lapply(theNames, nchar)
sapply(theNames, nchar)

#11.1.3 mapply
firstList <- list(A=matrix(1:16,4), B=matrix(1:16,2),C=1:5)
secondList <- list(A=matrix(1:16,4), B=matrix(1:16,8),C=15:1)
mapply(identical, firstList, secondList)

simpleFunc <- function(x,y)
{
  NROW(x) + NROW(y)
}
mapply(simpleFunc, firstList, secondList)

#11.1.4 Othe apply functions
# tapply, rapply, eapply, vapply

#11.2 aggregate
require(ggplot2)
data(diamonds)
head(diamonds)
aggregate(price ~ cut, diamonds, mean)
aggregate(price ~ cut+color, diamonds, mean)
aggregate(cbind(price,carat) ~ cut, diamonds, mean)
aggregate(cbind(price,carat) ~ cut+color, diamonds, mean)

#11.3 plyr
#11.3.1 ddply
require(plyr)
# from ddply help doc
# Summarize a dataset by two variables
dfx <- data.frame(
  group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
  sex = sample(c("M", "F"), size = 29, replace = TRUE),
  age = runif(n = 29, min = 18, max = 54)
)

# ddply
?ddply
ddply(dfx, .(group, sex), summarize, mean = mean(age))
# Note the use of the '.' function to allow
# group and sex to be used without quoting
ddply(dfx, .(group, sex), summarize,
      mean = round(mean(age), 2),
      sd = round(sd(age), 2))
############################################

data(baseball)
head(baseball)
tail(baseball)
?baseball
any(is.na(baseball$sf))
#sent NA -> 0 for before 1954 data
baseball$sf[baseball$year < 1954] <- 0
any(is.na(baseball$sf))
head(baseball)

any(is.na(baseball$hbp))
baseball$hbp[is.na(baseball$hbp)] <- 0
any(is.na(baseball$hbp))

#only keep players with at least 50 at bats in a season
baseball <- baseball[baseball$ab >= 50,]

#calculate OBP (On Base Percentage)
baseball$OBP <- with(baseball, (h+bb+hbp)/(ab+bb+hbp+sf))
# is the same as, but nicer than
# baseball$OBP <- (baseball$h+baseball$bb+baseball$hbp)/(baseball$ab+baseball$bb+baseball$hbp+baseball$sf)
tail(baseball)

# this is OBP for each season
# to find OBP for a player's entire career, we need to use 
# the sum of numerator and divide by the sum of denominator
obp <- function(data)
{
  c(OBP = with(data, sum(h+bb+hbp)/sum(ab+bb+hbp+sf)))
}
careerOBP <- ddply(baseball, .variables = "id", .fun = obp)
head(careerOBP)
careerOBP <- ddply(baseball, .(id), .fun = obp)
careerOBP <- ddply(baseball, ~id, .fun = obp)
#sort the results by OBP
careerOBP <- careerOBP[order(careerOBP$OBP, decreasing = TRUE),]
head(careerOBP,10)

#11.3.2 llply
theList <- list(A=matrix(1:9,3),B=1:5,C=matrix(1:4,2),D=2)
lapply(theList, sum)
llply(theList, sum)
identical(lapply(theList, sum), llply(theList, sum))
sapply(theList, sum)
laply(theList, sum)

#11.3.3 plyr helper functions
aggregate(price ~ cut, diamonds, each(mean, median))
