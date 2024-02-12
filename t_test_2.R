# t-test 
# M.Miran (U British Columbia)

#setwd("C:/Users/trasa/Google Drive/work/Courses/R_teaching_resources/R_code/data")

# Many ways to import data
# ------------------------
# 1) If data file is in the current working dir (use getwd() to see & use setwd() to set)

# Data1 <- read.table(file="LungCapData.txt", header = TRUE, sep=",")
# head(Data1)

# 2) Choose file interactively

# Data2 <- read.table(file.choose(), header = TRUE, sep=",")
# head(Data2)

# 3) Use "import dataset" tab on the right --> from text (base) ---> import as LungCapData

# 4) Download from class's github repo
LungCapData <- read.table(file="https://raw.githubusercontent.com/trasapong/R/main/LungCapData.txt", header = TRUE, sep=",")

head(LungCapData)
names(LungCapData)
str(LungCapData)
LungCapData$Smoke <- factor(LungCapData$Smoke)
#View(LungCapData)  #   invoke a data viewer

attach(LungCapData)
boxplot(LungCap)

#*************************************************************
# one-sample t-test
#*************************************************************
# H0 : mu = 8
# Ha : mu < 8
# one-sided 95% confidence interval for mu

t.test(LungCap, mu = 8, alternative = "less", conf.level = 0.95)
t.test(LungCap, mu = 8, alt = "less", conf = 0.95)

# two-sided

t.test(LungCap, mu = 8, alt = "two.sided", conf = 0.95) 
t.test(LungCap, mu = 8, conf = 0.95) # two-sided -> default 
t.test(LungCap, mu = 8) # conf = 0.95 -> default 
?t.test

# specify all defaults -> more readable
t.test(LungCap, mu = 8, alt = "two.sided", conf = 0.99) 
result <- t.test(LungCap, mu = 8, alt = "two.sided", conf = 0.99) 
result
attributes(result)
result$conf.int
result$p.value

#*************************************************************
# two-sample t-test
#*************************************************************
# one of parametric methods appropriate for examining the difference in means for 2 populations

# relationship between Smoke and LungCap
str(LungCapData)

boxplot(LungCap ~ Smoke)

# H0: mean lung cap of smokers = of non smokers
# two-sided test
# assume non-equal variances

t.test(LungCap~Smoke, mu=0, alt ="two.sided", conf=0.95, var.eq=F, paired=F)
?t.test

# how to find t
LungCapNotSmoke <- LungCap[Smoke=="no"]
LungCapSmoke <- LungCap[Smoke=="yes"]
(n1 <- length(LungCapNotSmoke))
(n2 <- length(LungCapSmoke))
(var1 <- var(LungCapNotSmoke))
(var2 <- var(LungCapSmoke))
(varp <- ((n1-1)*var1 + (n2-1)*var2)/(n1+n2-2))
(t <- (mean(LungCapNotSmoke)-mean(LungCapSmoke))/sqrt(var1/n1+var2/n2))
# degree of freedom
(v <- (((var1/n1+var2/n2)^2)/((((var1/n1)^2)/(n1-1))+(((var2/n2)^2)/(n2-1)))))

# how to find p
(p <- 2*(1-pt(abs(t),v)))

# how to find CI at 95%
tmp <- qt(0.975,v)*sqrt(var1/n1+var2/n2)
(L <- mean(LungCapNotSmoke)-mean(LungCapSmoke)-tmp)
(U <- mean(LungCapNotSmoke)-mean(LungCapSmoke)+tmp)

t.test(LungCap~Smoke)

t.test(LungCapNotSmoke,LungCapSmoke)
t.test(LungCap[Smoke=="no"],LungCap[Smoke=="yes"])

# if var.eq = TRUE
t.test(LungCap~Smoke, mu=0, alt ="two.sided", conf=0.95, var.eq=TRUE, paired=F)
# how to decide var eq or not eq
# (1) boxplot
# (2) compare var()

var(LungCap[Smoke=="no"])
var(LungCap[Smoke=="yes"])

# (3) Levene's Test (less sensitive to departures from normality, F-test for normal dist)
library(car)  # Companion to Applied Regression
leveneTest(LungCap~Smoke)
# from p.value -> Reject Null -> vars are not equal

#-------------------------------------------------------------------------
# Paired t-test

# import BloodPressure.txt data

# use file.choose() 
#BloodPressure <- read.table(file.choose(), header = T, sep = "\t")

# Download from class's github repo
BloodPressure <- read.table(file="https://raw.githubusercontent.com/trasapong/R/main/BloodPressure.txt", header = TRUE, sep="\t")

BloodPressure
View(BloodPressure)
str(BloodPressure)
attach(BloodPressure)

boxplot(Before, After)
# may want to see as paired data
plot(Before, After)
abline(a=0, b=1, col="red", lwd = 3)

# if no change in bp, should be equally scattered below and above the line
# if there is a decrease in bp after treatment, more points should fall below the line

# H0: Mean difference in Systolic BP is 0
# two-sided test

t.test(Before, After, mu=0, alt ="two.sided", paired = T, conf.level = 0.99)
# if flip the order
t.test(After, Before, mu=0, alt ="two.sided", paired = T, conf.level = 0.99)
# see opposite sign of t and mean dif

# how to find t
d <- Before-After
n <- length(d)
(t <- mean(d)/(sd(d)/sqrt(n)))

# how to find p
(p <- 2*(1-pt(t,n-1))) 

# how to find CI (99%)
alpha <- 0.01
tmp <- qt(1-alpha/2,n-1)*sd(d)/sqrt(n)
(L <- mean(d)-tmp)
(U <- mean(d)+tmp)

#***EOF***