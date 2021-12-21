# R for Everyone, ch 10, Loops, the Un-R Way to Iterate

#10.1 for 
for (i in 1:10) {
  print(i)
}
print(1:10)

fruit <- c("apple","banana","pomegranate")
(fruitLength <- rep(NA, length(fruit)))
names(fruitLength) 
names(fruitLength) <- fruit
fruitLength
for (a in fruit) {
  fruitLength[a] <- nchar(a)
}
fruitLength
# use R's build in vectorization is much easier
fruitLength2 <- nchar(fruit)
names(fruitLength2) <- fruit
fruitLength2
identical(fruitLength,fruitLength2)

#10.2 while
x <- 1
while (x <= 5) {
  print(x)
  x <- x + 1
}

#10.3 Controlling Loops
for (i in 1:10) {
  if (i==3) 
  {
    next
  }
  print(i)
}

for (i in 1:10) {
  if (i==4) 
  {
    break
  }
  print(i)
}

#compare running time
g <- rnorm(1000000)
h <- rep(NA, 1000000)
#start the clock
ptm <- proc.time()

for (i in 1:1000000) {
  h[i] <- g[i] + 1
}
#stop the clock
proc.time() - ptm

ptm <- proc.time()
h <- g+1
proc.time() - ptm
