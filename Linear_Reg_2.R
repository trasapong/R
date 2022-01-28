# Linear_Reg_2.R
# Linear Regression
setwd("C:/Users/trasa/Google Drive/work/Courses/R_teaching_resources/R_code/data")

LungCapData <- read.table(file="LungCapData.txt", header = TRUE, sep=",")
head(LungCapData)
str(LungCapData)

attach(LungCapData)
class(Age)
class(LungCap)
plot(Age, LungCap, main = "Scatterplot")
cor(Age, LungCap)
?lm
mod <- lm(LungCap ~ Age)
summary(mod)
# F-test in the last line for all coef are 0
attributes(mod)
mod$coefficients
coef(mod)
plot(Age, LungCap, main = "Scatterplot")
abline(mod)
abline(mod, col="red", lwd=3)
confint(mod)
confint(mod, level = 0.99)
summary(mod)
anova(mod) # for the F-test in the last line of summary
# Residual Standard Error in Summary is sqrt(Mean Sq of Residual in Anova)
plot(mod) #checking validity   --> Regression diagnostic plots

# The diagnostic plots show residuals in four different ways:
# 1. Residuals vs Fitted. Used to check the linear relationship assumptions.
#    A horizontal line, without distinct patterns is an indication for a linear 
#    relationship.
# 2. Normal Q-Q. Used to examine whether the residuals are normally distributed. 
# 3. Scale-Location (or Spread-Location). Used to check the homogeneity of 
#    variance of the residuals (homoscedasticity). Horizontal line with equally 
#    spread points is a good indication of homoscedasticity. 
# 4. Residuals vs Leverage. Used to identify influential cases. 

# see examples:
# https://data.library.virginia.edu/diagnostic-plots/

par(mfrow=c(2,2))
plot(mod)
par(mfrow=c(1,1))

# Try non-constant variance
set.seed(123)
x <- 1:50
y <- 0.5*x + (4+(0.1*x))*rnorm(50) 
plot(x,y)

mod2 <- lm(y ~ x)
abline(mod2)
plot(mod2)

# try non-linear
xx <- 1:50
yy <- -0.01*xx^2 + 0.6*xx + 1.2*rnorm(50) 
plot(xx,yy)
mod3 <- lm(yy ~ xx)
abline(mod3)
plot(mod3)

# multiple linear regression
model1 <- lm(LungCap ~ Age + Height)
summary(model1)
# f-test for all coef are 0 (beta_age and beta_height are 0)

cor(Age, Height, method="pearson")
confint(model1, level = 0.95)

model2 <- lm(LungCap ~ Age + Smoke)
summary(model2)
# note the dummy var. or indicators
# y_hat = b0+ b_age*X_age + b_smoke*X_smoke
# = 1.09 + 0.56*X_age -0.65*X_smoke
# where X_smoke = 1 (smoke=yes), 0 (smoke=no) 

# default -> alphabetically
# to change reference 

table(Smoke)
Smoke <- factor(Smoke)
Smoke <- relevel(Smoke, ref = "yes")
table(Smoke)
model2 <- lm(LungCap ~ Age + Smoke)
summary(model2)
# change back
Smoke <- relevel(Smoke, ref = "no")
table(Smoke)
model2 <- lm(LungCap ~ Age + Smoke)
summary(model2)

plot(Age[Smoke=="no"],LungCap[Smoke=="no"], col="blue", ylim=c(0,15),
     xlab="Age",ylab="LungCap", main = "LungCap vs. Age,Smoke")
points(Age[Smoke=="yes"], LungCap[Smoke=="yes"],col="red", pch = 16)
legend(3,15, legend = c("NonSmoker","Smoker"), col=c("blue","red"),
       pch=c(1,16), bty="n")
abline(a=1.08, b=0.555,col="blue", lwd=3)
abline(a=0.431, b=0.555,col="red", lwd=3)
# parallel lines => no interaction between age and smoking

model3 <- lm(LungCap ~ Age*Smoke)
coef(model3)
model4 <- lm(LungCap ~ Age+Smoke+Age:Smoke)
coef(model4)
summary(model4)
# show regression equations for smoker and non-smoker
plot(Age[Smoke=="no"],LungCap[Smoke=="no"], col="blue", ylim=c(0,15),
     xlab="Age",ylab="LungCap", main = "LungCap vs. Age,Smoke")
points(Age[Smoke=="yes"], LungCap[Smoke=="yes"],col="red", pch = 16)
legend(3,15, legend = c("NonSmoker","Smoker"), col=c("blue","red"),
       pch=c(1,16), bty="n")
abline(a=1.052, b=0.558,col="blue", lwd=3)
abline(a=1.278, b=0.498,col="red", lwd=3)
# Questions: should we include the interaction term in our model?
# (1) making any senses? (2) statistically significant?

# in this case, we should not include the interaction term

# Comparing models using partial F-test 
# partial f-test is used in model building can variable selection
# to help decide if a variable can be removed from a model without
# making the model significantly worse

# Larger model = Full model
# smaller model (w/ 1 or more var. removed) = Reduced model

# Partial f-test
# H0: No significant difference in SSE of full and reduced models.
#     or : models do not significantly differ.
# H1: Full model has a significantly lower SSE than the reduced model.
#     or : Full model is significantly better than the reduced model.

# test statistic is:
# F = (SSE(Reduced)-SSE(Full))/(change in # of parameters)
#     ----------------------------------------------------
#                         MSE(Full)
# the larger the value of test stat.-> larger the change in SSE 
# -> larger the difference b/w the two models' SSE

# ex.1

Full.Model <- lm(LungCap ~ Age + I(Age^2))
summary(Full.Model)
Reduced.Model <- lm(LungCap ~ Age)
summary(Reduced.Model)

# Partial f-test
anova(Reduced.Model,Full.Model)
# fail to reject null -> we do not have enough evidence to believe that the 
# full model is significantly better.
# It's not necessary to include the AGE^2 in our model.

# ex.2

Full.Model <- lm(LungCap ~ Age + Gender + Smoke + Height)
summary(Full.Model)
Reduced.Model <- lm(LungCap ~ Age + Gender + Smoke)
summary(Reduced.Model)

# Partial f-test
anova(Reduced.Model,Full.Model)
# reject null -> we have enough evidence to believe that the 
# full model is significantly better.
# It's necessary to include the 'Height' in our model.

# EOF--------------------------------------