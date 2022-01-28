# Linear_Reg_1.R
# linear reg (example from lecture)
x <- c(68,88,62,72,60,96,78,46,82,94,68,48)
y <- c(1190,1211,1004,917,770,1456,1180,710,1316,1032,752,963)
(a <- data.frame(x,y))
plot(x,y)
?lm
aa <- lm(y~x, data = a)
aa
summary(aa)
anova(aa)
qf(0.95,1,10)
aaa <- aov(aa)
summary(aaa)
