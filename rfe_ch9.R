# R for Everyone, ch 9, Control Statements

#9.1 If-else
as.numeric(TRUE)
as.numeric(FALSE)
toCheck <- 1
if (toCheck == 1)
{
  print("hello")
}
if (toCheck != 1)
{
  print("hello")
}
# print nothing

check.bool <- function(x)
{
  if (x == 1) 
  {
    print("hello")
  } else 
  {
    print("goodbye") 
  }
}
check.bool(1)
check.bool(0)
check.bool("k")
check.bool(TRUE)

check.bool <- function(x)
{
  if (x == 1) 
  {
    print("hello")
  } else if (x==0) 
  {
    print("goodbye") 
  } else
  {
    print("confused")
  }
}
check.bool(1)
check.bool(0)
check.bool(2)
check.bool("k")

#9.2 switch
use.switch <- function(x)
{
  switch(x,
         "a"="first",
         "b"="second",
         "z"="last",
         "c"="third",
         "other")
}
use.switch("a")
use.switch("b")
use.switch("c")
use.switch("d")
use.switch("e")
use.switch("z")
use.switch(1)
use.switch(2)
use.switch(3)
use.switch(4)
use.switch(5)
use.switch(6) #nothing is returned
is.null(use.switch(6))

#9.3 ifelse
ifelse(1 == 1, "Yes", "No")
ifelse(1 == 0, "Yes", "No")
toTest <- c(2,2,1,2,1,2)
ifelse(toTest == 2, "Yes", "No")
ifelse(toTest == 2, toTest * 3, toTest)
ifelse(toTest == 2, toTest * 3, "ONE") 
# notice 6 -> "6"
toTest[2] <- NA
toTest
ifelse(toTest == 2, "Yes", "No")
ifelse(toTest == 2, toTest * 3, toTest)
ifelse(toTest == 2, toTest * 3, "ONE")
#9.4 Compound Tests
a <- c(1,1,0,1)
b <- c(2,1,0,1)
ifelse(a==1 & b==1, "Yes","No")
# & compare each element
ifelse(a==1 && b==1, "Yes","No")
# && compare only one element