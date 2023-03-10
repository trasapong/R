# missing_data.R
# how to handle missing data

# Missingness mechanisms
# 1. Missing completely at random (MCAR)
# 2. Missing at random (MAR)
#    Ex: NAs depend on some other variables (ex. ask about weight NA rate might depend on gender)
# 3. Missing not at random (MNAR)
#    Ex: NAs depend on the value itself (ex. ask about weight)

# How to handle:
# 1. Delete
#    + Simple
#    - Data Loss
#    - Bias
# 2. Replace with a constant such as average
# (Mean, Median, Mode)
#
#  Vehicle  Month   Mileage
#    1       10      20,000
#    2       36     100,000
#    3        1        NA
#    4       15      30,000
#    5       24      50,000
# Avg = 50,000 miles
# - lower variation
# 3. Hot Deck : from same data set
# 4. Cold Deck : from another data set
# 5. Regression

# single imputation/multiple imputation

library(mice)
library(VIM)
data <- read.table(file="https://raw.githubusercontent.com/trasapong/R/main/vehicleMiss.csv", header = TRUE, sep=",", stringsAsFactors = TRUE)
str(data)
View(data)
# vehicle : vehicle no.
# fm : failure month
# lh : labor hours
# lc : labor cost
# mc : material cost
summary(data)

# Missing data
p <- function(x) {sum(is.na(x))/length(x)*100}
apply(data,2,p)   # missing data in %

md.pattern(data)
md.pairs(data)  # r : observed, m : missing

marginplot(data[,c('Mileage','lc')])
# Note that, if data are MCAR, we expect the blue and red box plots to be identical.

# omit NA
head(data,25)
data2 <- na.omit(data)
head(data2,25)

# Impute
impute <- mice(data[,2:7],m=3,seed = 123)
# 5 iterations, 3 imputations

impute
# pmm : Predictive Mean Matching
# polyreg : Multinomial Logistic Regression

impute$imp$Mileage
data[253,]
summary(data$Mileage)
summary(data$fm)

# Complete data
(newData <- complete(impute, 2))
newData[253,]

# Distribution of observed/imputed values
xyplot(impute, lc ~ lh)
xyplot(impute, lc ~ lh | .imp, pch=20, cex=1.4)

#### ex.2 ###############################################

data(nhanes)
View(nhanes)
# National Health and Nutrition Examination Survey (NHANES) 
# by the US National Center for Health Statistics
# contains 25 obs & four variables: age (age groups: 20-39, 40-59, 60+), bmi (body mass index), 
# hyp (hypertension status) and chl (cholesterol level).
str(nhanes)
nhanes$age <- factor(nhanes$age)
# do default multiple imputation on a numeric matrix
summary(nhanes)
imp <- mice(nhanes)
imp

# list the actual imputations for BMI
imp$imp$bmi

# first completed data matrix
complete(imp) # default = 1

# imputation on mixed data with a different method per column

nhanes2
str(nhanes2)
summary(nhanes2)
?mice # see methods
imp2 <- mice(nhanes2, meth=c('sample','pmm','logreg','mean'))
# list the actual imputations for BMI
imp2$imp$hyp
imp2$imp$chl
complete(imp2)

#### EOF ############################################