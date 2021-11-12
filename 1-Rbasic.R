# 1-Rbasic.R

# this is a comment!!!
# this is the editor window for writing R script

# 1. Basic Math
1 + 1
4/2
4/3
sqrt(2)

# 2. Variables
x <- 3   # see result in the environment window
x
4 -> y   # not recommended
y
z = 5    # also not recommended 
z
rm(z)  # remove var
z

# 3. Data Types
# 4 main types:
# (1) Numeric 
# (2) Character (String)
# (3) Date
# (4) Logical (TRUE/FALSE)

# 3.1 Numeric
x <- 4
class(x)
is.numeric(x)
is.integer(x)
y <- 4L    # integer
class(y)
is.numeric(y)
is.integer(y)
# integer is a subset of numeric (used less frequently)

# promote type when needed
class(2.8)
class(4L)
class(4L * 2.8)

# 3.2 Character (String)
y <- "Hello"
y
class(y)
z <- factor("Hello")
z
class(z) # explained further in vectors

nchar(y)
nchar(z) # Error
nchar(1234)

# 3.3 Dates
date1 <- as.Date("2021-11-12")
date1
class(date1)
as.numeric(date1) # number of days since 1 Jan 1970

date2 <- as.POSIXct("2021-11-12 9:00")
date2
class(date2)
as.numeric(date2) # number of secs since 1 Jan 1970

# 3.4 Logical
x <- TRUE
x
class(x)
is.logical(x)

TRUE * 5
FALSE * 5

y <- !x
y
T
F
x <- T
x
# *Note: T could be a var name
T <- 7
x <- T
x
class(x)
rm(T)
T
TRUE <- 7 # TRUE can't be a var name
# so use full TRUE/FALSE always
2==3 
2<=3
"chiangmai" == "chiangrai"
"chiangmai" < "chiangrai"

# 4. Vectors
x <- c(1,2,3,4,5,6,7,8,9,10)
x
class(x)

# 4.1 Vector operations
x * 3
x + 3
x / 4 
x ^ 2
sqrt(x)

1:10
10:1
-2:3
5:-7
x <- 1:10
y <- -5:4
x + y
x / y

length(x)
length(y)
length(x+y)

x
x + c(1,10)
x + c(1,2,3)  # warning
x <= 5

(x <- 10:1)
(y <- -4:5)
any(x<y)
all(x<y)
q <- c("Banana","Mango","Apple","Orange")
nchar(q)
y
nchar(y)
x
x[1]    # index start from 1
x[1:2]
x[c(1,4)]

y <- rep(c(-1,0,2),3)
y
z <- seq(0,1,length.out = 9)
z
class(z)
is.integer(z)
is.numeric(z)

# 4.2 Factor vector

q1 <- c("Banana","Mango","Apple","Orange","Mango","Apple","Mango","Apple","Banana","Mango")
q1

q2 <- as.factor(q1)
q2
as.numeric(q2)

# 5. Calling Functions
x
mean(x)
?mean

# 6. Missing Data
# 6.1 NA
z <- c(1,2,NA,8,3,NA,3)
z
is.na(z)

# 6.2 NULL
z <- c(1,2,NULL,8,3,NULL,3)
z

d <- NULL

# NULL is atomic, can't be in vector


#################################################################################
