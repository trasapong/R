# Two-way Anova

URL = "https://raw.githubusercontent.com/trasapong/R/main/math_score.csv"
mathScore <- read.table(file=URL, header = TRUE, sep=",")
View(mathScore)
str(mathScore)
# change Age type to factor
mathScore$Age <- as.factor(mathScore$Age)
str(mathScore)

# one-way anova, factor:Age
# H0: Age has no significant effect on students score.
# H1: Age has significant effect on students score.
m <- aov(Score ~ Age, data = mathScore)
summary(m)

# two-way anova, Factor: Age, Gender, Age:Gender interaction
# H0: Gender has no significant effect on students score.
# H1: Gender has significant effect on students score.

# H0: Age has no significant effect on students score.
# H1: Age has significant effect on students score.

# H0: Gender and Age interaction has no significant effect on students score.
# H1: Gender and Age interactionhas significant effect on students score.

m <- aov(Score ~ Gender*Age, data = mathScore)
summary(m)

(meanGA <- aggregate(Score~Gender*Age,data = mathScore, FUN = mean))
(meanG <- aggregate(Score~Gender,data = mathScore, FUN = mean))
(meanA <- aggregate(Score~Age,data = mathScore, FUN = mean))
(grandMean <- mean(mathScore$Score))

# Total Sum of Squares = 
#    Sum of Squares 1st Factor(Gender) +
#    Sum of Squares 2nd Factor(Age) +
#    Sum of Squares Both Factor(Gender&Age interaction) +
#    Sum of Squares Within(Error) 

# Sum of Squares 1st Factor(Gender)
meanG
meanG$Score
meanG$Score - grandMean
(meanG$Score - grandMean)^2
subset(mathScore, Gender=="Boy")
nrow(subset(mathScore, Gender=="Boy"))
(SSGender <-sum(((meanG$Score - grandMean)^2)*nrow(subset(mathScore, Gender=="Boy"))))

# Sum of Squares 2nd Factor(Age) 
meanA
meanA$Score
(SSAge <-sum(((meanA$Score - grandMean)^2)*nrow(subset(mathScore, Age=="10"))))

# Sum of Squares Within(Error) 
meanGA
meanGA$Score
# use for loop:
#tmp <- NULL
#for (a in meanGA$Score) {
#  tmp <- c(tmp,rep(a,3))
#}
#tmp
# or
(tmp<-rep(meanGA$Score, each=3))
(SSE <- sum((mathScore$Score - tmp)^2)) 

# Total Sum of Squares
(SST <- sum((mathScore$Score - grandMean)^2)) 

# Sum of Squares Both Factor(Gender&Age interaction) 
(SSGA <- SST - SSGender - SSAge - SSE) 

# F value Gender
(fGender <- SSGender/(SSE/12))
(pGender <- 1 - pf(fGender,1,12))

# F value Age
(fAge <- (SSAge/2)/(SSE/12))
(pAge <- 1 - pf(fAge,2,12))

# F value GA
(fGA <- (SSGA/2)/(SSE/12))
(pGA <- 1 - pf(fGA,2,12))
