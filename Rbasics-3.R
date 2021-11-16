# Rbasics-3.R

# Advanced Data Structures

sample(1:100,10)
sample(100,10)
sample(6,10) #error
?sample # see the default value
sample(6,10,replace = TRUE)
sample(c(-3,5,6,11:20),100,replace = TRUE)
x <- sample(100,50,replace=TRUE)
df <- data.frame(x)
df
head(df)
names(df)
colnames(df)
rownames(df)
names(df) <- "score"
head(df)
names(df)
colnames(df)
names(df) <- NULL
names(df)
df <- data.frame(score=x)
head(df)
max(df$score)
which(df$score==max(df$score))
df$score <- ifelse(df$score==max(df$score), df$score*10, df$score)
df$score <- x
summary(df)
str(df)
class(df)
df$grade <- ifelse(df$score>=50,"A","F")
head(df)
summary(df)
str(df)
aggregate(score~grade,FUN=mean,data=df)
aggregate(score~grade,FUN=length,data=df)
df$grade2 <- ifelse(df$score>=80,"A",ifelse(df$score>=50,"C","F"))
head(df)
aggregate(score~grade2,FUN=mean,data=df)
aggregate(score~grade2,FUN=length,data=df)


#################################################################################
