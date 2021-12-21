# R for Everyone, ch 8, Writing R functions

#8.1 Hello, World!
say.hello <- function()
{
  print("Hello, World!")
}
say.hello()
say.hello

say.hello2 <- function()
{
  cat("Hello, World!")
}
say.hello2()

#8.2 Function Arguments
sprintf("Hello %s", "Jared")
sprintf("Hello %s, today is %s", "Jared", "Sunday")
cat(sprintf("Hello %s, today is %s", "Jared", "Sunday"))

hello.person <- function(name)
{
  #sprintf : string formatting only
  sprintf("(1) Hello %s", name)
  print(sprintf("(2) Hello %s", name))
  cat(sprintf("(3) Hello %s", name))
}
hello.person("Jared")
hello.person("Bob")

hello.person <- function(first, last)
{
  cat(sprintf("Hello %s %s", first, last))
}
# by position
hello.person("Jared", "Lander")
# by name
hello.person(first = "Jared", last = "Lander")
hello.person(last = "Lander", first = "Jared")
hello.person("Jared", last = "Lander")
hello.person("Lander", first = "Jared")
hello.person(last = "Lander", "Jared")
hello.person(fir = "Jared", l = "Lander")

#Wrong examples
hello.person("Jared")

#8.2.1 Default Arguments
hello.person <- function(first, last="Doe")
{
  cat(sprintf("Hello %s %s", first, last))
}
#Okay this time
hello.person("Jared")
hello.person("Jared", "Lander")
#still error
hello.person(last = "Lander")
#8.2.2 Extra Argument (...)

# Error examples
hello.person("Jared", extra = "Goodbye")
hello.person("Jared", "Lander", "Goodbye")

# and ... to absorb extra arguments
hello.person <- function(first, last="Doe", ...)
{
  cat(sprintf("Hello %s %s", first, last))
}
# Extra arguments got absorbed
hello.person("Jared", extra = "Goodbye")
hello.person("Jared", "Lander", "Goodbye")
hello.person("Jared", "Lander", "Goodbye", "Hello")

hello.person <- function(first, last="Doe", ...)
{
  cat(sprintf("Hello %s %s", first, last))
  functionA(...)
}

functionA <- function(extra = "See you tomorrow") 
{
  cat(" ")
  cat(extra)
}

hello.person("Jared")
hello.person("Jared", extra = "Goodbye")
hello.person("Jared", extra2 = "Goodbye")

functionA <- function(extra = "See you tomorrow", ...) 
{
  cat(" ")
  cat(extra)
}

hello.person("Jared", extra2 = "Goodbye")

#8.3 Return Values
double.num <- function(x)
{
  x * 2
}
double.num(5)

double.num <- function(x)
{
  return(x * 2)
}
double.num(5)

#8.4 do.call
do.call("hello.person", args=list(first="Jared",last="Lander"))
do.call(hello.person, args=list(first="Jared",last="Lander"))

run.this <- function(x, func = mean)
{
  do.call(func, args = list(x))
}
run.this(1:10)
run.this(1:10, mean)
run.this(1:10, sum)
run.this(1:10, sd)

newFunction <- function(x) {
  return(x[1]+x[2])  
}

newFunction(10:15)
run.this(1:10, newFunction)
