# anova
a1 <- c(2,3,7,2,6)
a2 <- c(10,8,7,5,10)
a3 <- c(10,13,14,13,15)
(d <- data.frame(a1,a2,a3))
(dd <- stack(d))
(aaa <- aov(values~ind,data=dd))
summary(aaa)
# manually calculate 
# Total sum of squares = Sum of squares b/w groups +
#                        Sum of squares within

# Sum of squares within
(tmp1 <- aggregate(values~ind,data = dd, FUN = mean))
(tmp2 <- rep(tmp1$values, each = nrow(d)))
(SSW <- sum((dd$values - tmp2)^2))

# Total sum of squares
(grandMean <- mean(dd$values))
(SST <- sum((dd$values - grandMean)^2))

# Sum of squares b/w groups or SS Treatment
tmp1
(SSTR <- sum((tmp1$values - grandMean)^2)*nrow(d))

# MS treatment = SS treatment/df_treatment
# df_treatment = #groups - 1
(MSTR <- SSTR/2)
# MSE (Error) = SSW/df_error
# df_error = (#obs - 1)*#groups
(MSE <- SSW/((nrow(d)-1)*3))

# F ratio
(F <- MSTR/MSE)

# p-value
(p <- 1 - pf(F,2,12))
(qf(0.95,2,12)) # critical value
(tk <- TukeyHSD(aaa))
plot(tk)
#data2
a1 <- c(2,3,7,2,6)
a2 <- c(5,8,7,5,5)
a3 <- c(6,7,7,7,8)
(d <- data.frame(a1,a2,a3))
(dd <- stack(d))
(aaa <- aov(values~ind,data=dd))
summary(aaa)
(tk <- TukeyHSD(aaa))
plot(tk)
#data3
a1 <- c(2,3,7,2,6)
a2 <- c(5,8,7,5,5)
a3 <- c(6,7,7,6,6)
(d <- data.frame(a1,a2,a3))
(dd <- stack(d))
(aaa <- aov(values~ind,data=dd))
summary(aaa)
(tk <- TukeyHSD(aaa))
plot(tk)
