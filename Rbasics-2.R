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

summary(df)
summary(df$x)
str(df)

df$zz <- as.factor(df$z)  # new var
df
str(df)

df$z <- as.factor(df$z)   # replace existing var
df
str(df)

df$z <- as.character(df$z)   # replace back
df
str(df)

#################################################################################
