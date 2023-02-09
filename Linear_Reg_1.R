# Linear_Reg_1.R
# linear reg (example from lecture)
xx <- c(68,88,62,72,60,96,78,46,82,94,68,48)
yy <- c(1190,1211,1004,917,770,1456,1180,710,1316,1032,752,963)
(a <- data.frame(x=xx,y=yy))
plot(xx,yy)
?lm
aa <- lm(y~x, data = a)
aa
summary(aa)
abline(aa, col='red')
# y_hat = 300.98 + 10.31x
anova(aa)
qf(0.95,1,10)
aaa <- aov(aa)
summary(aaa)

# predict
predict(aa, data.frame(x=(70)))
aa$coefficients
aa$coefficients[1]+aa$coefficients[2]*70

