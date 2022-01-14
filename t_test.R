# t_test
# Data from Stat.Quality Control, Montgomery
(x <- c(3193,3124,3153,3145,3093,3466,3355,2979,3182,3227,3256,3332,3204,3282,3170))
(x_bar <-mean(x))
(x_sd <- sd(x))
(n <- length(x))
alpha <- 0.05
mu0 <- 3200
(t0 <- (x_bar - mu0) / (x_sd/sqrt(n)))
(cv <- qt(1-(alpha/2),n-1))
# find confidence interval
tmp <- cv * x_sd / sqrt(n)
(l <- x_bar - tmp)
(u <- x_bar + tmp)
(p <- 2*(1-pt(abs(t0),n-1)))
t.test(x,alternative = "two.sided", mu= 3200, conf.level = 0.95)
t.test(x,alternative = "two.sided", mu= 3300, conf.level = 0.95)
t.test(x,alternative = "two.sided", mu= 3300, conf.level = 0.99)
tTest <- t.test(x,alternative = "two.sided", mu= 3300, conf.level = 0.99)
tTest
attributes(tTest)
tTest$p.value
tTest$statistic

#one-sided
#upper-tailed test
(p <- 1-pt(t0,n-1))
(cv <- qt(1-alpha,n-1))
tmp <- cv * x_sd / sqrt(n)
#lower-bound of mu
(L <- x_bar - tmp)
t.test(x,alternative = "greater", mu= 3200, conf.level = 0.95)

#one-sided
#lower-tailed test
(p <- pt(t0,n-1))
(cv <- qt(1-alpha,n-1))
tmp <- cv * x_sd / sqrt(n)
#upper-bound of mu
(U <- x_bar + tmp)
t.test(x,alternative = "less", mu= 3200, conf.level = 0.95)
########################################################################