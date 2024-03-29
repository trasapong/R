# Rbasics-2-1-titanic.R

# Titanic Data

# https://WWW.kaggle.com/c/titanic
# or search "titanic dataset csv download"

# see data dict on the page
# https://www.kaggle.com/competitions/titanic/data

# read in the data
# can use GUI to import data

# getwd()
# setwd()
# Note: R use / or //, windows use \

URL <- "https://raw.githubusercontent.com/trasapong/R/main/titanic.csv"

getwd()
dir()
files <- dir()
files

?read.csv
titanic <- read.csv(URL)
View(titanic)
summary(titanic)
str(titanic)

titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)
str(titanic)
summary(titanic)

head(titanic)
head(titanic,3)
tail(titanic)

# create new vars

titanic$SurvivedLabel <- ifelse(titanic$Survived == 1, "Survived","Died")
str(titanic)
titanic$SurvivedLabel <- as.factor(titanic$SurvivedLabel)
str(titanic)

titanic$familySize <- 1 + titanic$SibSp + titanic$Parch
str(titanic)

# basic questions
summary(titanic$Fare)
hist(titanic$Fare)
aggregate(Survived~Sex,FUN=mean,data=titanic)
aggregate(Survived~Sex+Pclass,FUN=mean,data=titanic)

# filtering
male <- titanic[titanic$Sex == "male",]

library(ggplot2)
ggplot(titanic, aes(x=familySize, fill = SurvivedLabel)) +
  theme_bw() +
  facet_wrap(Sex ~ Pclass) +
  geom_histogram(binwidth = 1)

# try copy above command, change familySize -> Fare

ggplot(titanic, aes(x=Fare, fill = SurvivedLabel)) +
  theme_bw() +
  facet_wrap(Sex ~ Pclass) +
  geom_histogram(binwidth = 1)


#################################################################################
