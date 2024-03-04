# PCA: Principal Component Analysis

require(calibrate)
URL = "https://raw.githubusercontent.com/trasapong/R/main/marks.dat"
my.classes = read.csv(URL)
head(my.classes)
plot(my.classes,cex=0.9,col="blue",main="Plot of Physics Scores vs. Stat Scores")
options(digits=5)
head(my.classes)

# Scale the data

standardize <- function(x) {(x - mean(x))}
my.scaled.classes = apply(my.classes,2,function(x) (x-mean(x)))
plot(my.scaled.classes,cex=0.9,col="blue",main="Plot of Physics Scores vs. Stat Scores",sub="Mean Scaled",xlim=c(-30,30))

# Find Eigen values of covariance matrix

(my.cov <- cov(my.scaled.classes))
(my.eigen <- eigen(my.cov))
rownames(my.eigen$vectors)=c("Physics","Stats")
colnames(my.eigen$vectors)=c("PC1","PC2")
my.eigen
# Note that the sum of the eigen values equals the total variance of the data
# Av = lambda*v
my.cov%*%as.matrix(my.eigen$vectors[,1])            #LHS1
my.eigen$values[1]*as.matrix(my.eigen$vectors[,1])  #RHS1
my.cov%*%as.matrix(my.eigen$vectors[,2])            #LHS2
my.eigen$values[2]*as.matrix(my.eigen$vectors[,2])  #RHS2

# sum of eigen val. = sum of var
sum(my.eigen$values)
var(my.scaled.classes[,1]) 
var(my.scaled.classes[,2]) 
var(my.scaled.classes[,1]) + var(my.scaled.classes[,2])

# The Eigen vectors are the principal components. We see to what extent each variable contributes

(loadings <- my.eigen$vectors)

# Let's plot them 

(pc1.slope <- my.eigen$vectors[1,1]/my.eigen$vectors[2,1])
(pc2.slope <- my.eigen$vectors[1,2]/my.eigen$vectors[2,2])

abline(0,pc1.slope,col="red")
abline(0,pc2.slope,col="green")

textxy(12,10,"(-0.710,-0.695)",cex=0.7,col="red")
textxy(-12,10,"(0.695,-0.719)",cex=0.7,col="green")

# See how much variation each eigenvector accounts for
pc1.var <- 100*round(my.eigen$values[1]/sum(my.eigen$values),digits=4)
pc2.var <- 100*round(my.eigen$values[2]/sum(my.eigen$values),digits=4)
(xlab <- paste("PC1 - ",pc1.var," % of variation",sep=""))
(ylab <- paste("PC2 - ",pc2.var," % of variation",sep=""))

# Multiply the scaled data by the eigen vectors (principal components)
# T (score) = X * W (loadings)
scores <- my.scaled.classes %*% loadings
head(scores)
head(my.classes)
sd <- sqrt(my.eigen$values)
rownames(loadings) <- colnames(my.classes)

plot(scores, asp=1, main="Data in terms of EigenVectors / PCs",xlab=xlab,ylab=ylab)
abline(0,0,col="red")
abline(0,90,col="green")

# Correlation BiPlot
(scores.min <- min(scores[,1:2]))
(scores.max <- max(scores[,1:2]))

plot(scores[,1]/sd[1],scores[,2]/sd[2], main="My First BiPlot",xlab=xlab,ylab=ylab,type="n")
head(scores)
rownames(scores)
rownames(scores) <- seq(1:nrow(scores))
head(scores)
abline(0,0,col="red")
abline(0,90,col="green")

# This is to make the size of the lines more apparent
factor <- 5

# First plot the variables as vectors
arrows(0,0,loadings[,1]*sd[1]/factor,loadings[,2]*sd[2]/factor,length=0.1, lwd=2,angle=20, col="red")
text(loadings[,1]*sd[1]/factor*1.2,loadings[,2]*sd[2]/factor*1.2,rownames(loadings), col="red", cex=1.2)

# Second plot the scores as points
text(scores[,1]/sd[1],scores[,2]/sd[2], rownames(scores),col="blue", cex=0.7)
sapply(my.classes,mean)
my.classes[75,]
my.classes[7,]
my.classes[2,]
my.classes[63,]
my.classes[64,]
my.classes[18,]

# princomp() or prcomp()
# princomp() uses different approach, can't handle large# features
# prcomp is preferred

(pc <- princomp(my.classes))
summary(pc)
pc$loadings
my.eigen
plot(pc) #scree plot
screeplot(pc, type = "line", main = "Scree Plot")
biplot(pc)

(my.prc <- prcomp(my.classes, center=TRUE, scale=FALSE))
summary(my.prc)
my.prc$sdev ^ 2 # eigen (select > 1)
screeplot(my.prc, main="Scree Plot", xlab="Components")
screeplot(my.prc, main="Scree Plot", type="line" )
biplot(my.prc, cex=c(1, 0.7))

#################################################
library(lattice)
URL = "https://raw.githubusercontent.com/trasapong/R/main/wines.csv"
(my.wines <- read.csv(URL, header=TRUE))

# Look at the correlations

library(gclus)
#my.abs     <- abs(cor(my.wines[,-1]))
#my.colors  <- dmat.color(my.abs)
#my.ordered <- order.single(cor(my.wines[,-1]))
#cpairs(my.wines, my.ordered, panel.colors=my.colors, gap=0.5)

GGally::ggpairs(my.wines[,-1])

# Do the PCA 
my.prc <- prcomp(my.wines[,-1], center=TRUE, scale=TRUE)
summary(my.prc)
my.prc$sdev ^ 2 # eigen (select > 1)
screeplot(my.prc, main="Scree Plot", xlab="Components")
screeplot(my.prc, main="Scree Plot", type="line" )

# DotPlot PC1

(load <- my.prc$rotation)
sorted.loadings <- load[order(load[, 1]), 1]
myTitle <- "Loadings Plot for PC1" 
myXlab  <- "Variable Loadings"
dotplot(sorted.loadings, main=myTitle, xlab=myXlab, cex=1.5, col="red")

# DotPlot PC2

sorted.loadings <- load[order(load[, 2]), 2]
myTitle <- "Loadings Plot for PC2"
myXlab  <- "Variable Loadings"
dotplot(sorted.loadings, main=myTitle, xlab=myXlab, cex=1.5, col="red")

# Now draw the BiPlot
biplot(my.prc, cex=c(1, 0.7))

# iris example
head(iris)
str(iris)
summary(iris)
#partition data
set.seed(111)
(ind <- sample(2, nrow(iris),
              replace = TRUE,
              prob = c(0.8,0.2)))
training <- iris[ind==1,]
testing <- iris[ind==2,]
nrow(training)
nrow(testing)

# correlation plot
library(psych)
pairs.panels(training[,-5],
             gap = 0,
             bg = c("red","yellow","blue")[training$Species],
             pch = 21)
# High correlation -> Multicollinearity problem

pc <- prcomp(training[,-5], center=TRUE, scale. = TRUE)
attributes(pc)
pc$center
pc$scale
pc
summary(pc)
pairs.panels(pc$x,
             gap = 0,
             bg = c("red","yellow","blue")[training$Species],
             pch = 21)
# no multicollinearity problem
#install.packages("remotes")
#remotes::install_github("vqv/ggbiplot")
library(ggbiplot)
ggbiplot(pc, obs.scale = 1, var.scale = 1,
  groups = training$Species,
  ellipse = TRUE,
  circle = TRUE,
  ellipse.prob = 0.95) + 
  scale_color_discrete(name='') +
  theme(legend.direction = 'horizontal',
        legend.position = 'top')
pc

# prediction
(trg <- predict(pc, training))
(trg <- data.frame(trg, training[5]))
(tst <- predict(pc, testing))
(tst <- data.frame(tst, testing[5]))

# Multinomial Logistic Regression with First Two PCs
library(nnet)
trg$Species <- relevel(trg$Species, ref = "setosa")
mymodel <- multinom(Species~PC1+PC2, data=trg)
summary(mymodel)

# Confusion Matrix & Misclassification Error - Training
p <- predict(mymodel,trg)
(tab <- table(p, trg$Species))
sum(diag(tab))/sum(tab) # Accuracy
1-sum(diag(tab))/sum(tab) # Misclassification

# Confusion Matrix & Misclassification Error - Testing
p <- predict(mymodel,tst)
(tab <- table(p, tst$Species))
sum(diag(tab))/sum(tab) # Accuracy
1-sum(diag(tab))/sum(tab) # Misclassification

# try using original data
mymodel1 <- multinom(Species~Sepal.Width+Sepal.Length, data=training)
summary(mymodel1)
p <- predict(mymodel1,training)
(tab <- table(p, training$Species))
sum(diag(tab))/sum(tab) # Accuracy
1-sum(diag(tab))/sum(tab) # Misclassification

p <- predict(mymodel1,testing)
(tab <- table(p, testing$Species))
sum(diag(tab))/sum(tab) # Accuracy
1-sum(diag(tab))/sum(tab) # Misclassification

# another wine data
data(wine)
head(wine)
str(wine)
wine.class
wine.pca <- prcomp(wine, scale. = TRUE)
ggbiplot(wine.pca, obs.scale = 1, var.scale = 1,
         groups = wine.class, ellipse = TRUE, circle = TRUE) +
  scale_color_discrete(name = '') +
  theme(legend.direction = 'horizontal', legend.position = 'top')

############ EOF