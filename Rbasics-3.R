# Rbasics-2.R

# Advanced Data Structures

# 1. Data Frame
x <- 10:1
y <- -4:5
z <- c("Banana","Mango","Apple","Orange","Mango","Apple","Mango","Apple","Banana","Mango")
df <- data.frame(x,y,z)
View(df)    # or click on the var name in envi

class(df)
df$x
df$y
df$z
class(df$x)
class(df$z)
df[1,]
df[,1]
class(df[1,])
class(df[,1])
df[1:3,]    # row filer, col filter
df[,1:3]
df[c(1,4,7:9),]
df[c(7:9,1,4),]
df[,c(1,3)]
df[c(7:9,1,4),c(1,3)]
df[df$x>5,]     # filter with condition
df[(df$x>5)&(df$y< -1),]     # note: space b/w < and -
max(df$y)
which(df$y==max(df$y))
df[which(y==max(y)),]

df[,"x"]
df[,c("x","z")]

# different methods to get x data
df["x"]
df[,"x"]
df[["x"]]
df[,1]
class(df["x"])
class(df[,"x"])
class(df[["x"]])
class(df[,1])
df[,1]
df[,1,drop=FALSE]
class(df[,1,drop=FALSE])
df[,"x",drop=FALSE]

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
df$grade <- ifelse(xx$x>=50,"A","F")
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
