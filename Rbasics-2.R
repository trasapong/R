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
df[which(df$y==max(df$y)),]

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

###

# List
list1 <- list(1,2,3)
list1
list2 <- list(c(1,2,3))
list2
(list3 <- list(c(1,2,3), 3:7))
(list4 <- list(df, 1:10))
(list5 <- list(df, 1:10, list3))
names(list5)
names(list5) <- c("df","vec","lst")
names(list5)
list5
(list6 <- list(datafr = df, vect = 1:10, lst = list3))
names(list6)
list5[[1]]
list5[["df"]]
list5[[1]]$z
list5[[1]][,"z"]
list5[[1]][,"z", drop = FALSE]
length(list5)
list5[[4]] <- 2
length(list5)
list5[["NewElement"]] <- 3:6
length(list5)
names(list5)
list5
# Matrices
A <- matrix(1:10, nrow = 5)
A
AA <- matrix(1:10, nrow = 5, byrow = TRUE)
AA
(B <- matrix(21:30, nrow = 5))
(C <- matrix(21:40, nrow = 2))
nrow(A)
ncol(A)
dim(A)
A + B
A * B
A == B
t(B)
A %*% t(B)
C
colnames(C) <- LETTERS[1:10]
C
LETTERS
letters
# Arrays
theArray <- array(1:12, dim = c(2,3,2))
theArray
theArray[1,,]
theArray[1,,1]
theArray[,,1]


#################################################################################
