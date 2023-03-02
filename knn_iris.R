# knn_iris.R

data(iris)
head(iris)
str(iris)
table(iris$Species)

# problem: ordered by Species (too organized) -> need to mix up
set.seed(9850)
runif(5)
gp <- runif(nrow(iris))
gp
order(gp)
iris2 <- iris[order(gp),]
str(iris2)
str(iris)
head(iris2,12)
# need to re-scale, different ranges
summary(iris2)
iris2[,1:4] <- scale(iris2[,1:4])
head(iris2,12)
summary(iris2)
sd(iris$Petal.Length)
sd(iris$Petal.Width)
sd(iris2$Petal.Length)
sd(iris2$Petal.Width)
# test set at least 10%
# create training set
iris_train <- iris2[1:129,1:4]
iris_test <- iris2[130:150,1:4]
iris_train_target <- iris2[1:129,5]
iris_test_target <- iris2[130:150,5]
require(class)
?knn
sqrt(150)
# must not choose k as a multiple of #classes
m1 <- knn(train=iris_train,test=iris_test,cl=iris_train_target, k=13)
m1
# confusion matrix
(cm <- table(iris_test_target, m1))
(acc <- sum(diag(cm))/sum(cm))

iris_train <- iris2[1:50,1:4]
iris_test <- iris2[51:150,1:4]
iris_train_target <- iris2[1:50,5]
iris_test_target <- iris2[51:150,5]
(m2 <- knn(train=iris_train,test=iris_test,cl=iris_train_target, k=13))
# confusion matrix
(cm <- table(iris_test_target, m2))
(acc <- sum(diag(cm))/sum(cm))

(m3 <- knn(train=iris_train,test=iris_test,cl=iris_train_target, k=1))
# confusion matrix
(cm <- table(iris_test_target, m3))
(acc <- sum(diag(cm))/sum(cm))

iris_train <- iris2[1:129,1:4]
iris_test <- iris2[130:150,1:4]
iris_train_target <- iris2[1:129,5]
iris_test_target <- iris2[130:150,5]
(m4 <- knn(train=iris_train,test=iris_test,cl=iris_train_target, k=1))
# confusion matrix
(cm <- table(iris_test_target, m4))
(acc <- sum(diag(cm))/sum(cm))
