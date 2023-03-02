# knn.R

library(caret)  # classification and regression training
library(mlbench)  # ML benchmark problems

# Example-1 Classification
data <- read.csv('https://raw.githubusercontent.com/trasapong/R/main/binary.csv')
str(data)
data$admit[data$admit == 0] <- 'no'
data$admit[data$admit == 1] <- 'yes'
data$admit <- factor(data$admit)
data$rank <- factor(data$rank)
str(data)

# Data partition
set.seed(1234)
ind <- sample(2, nrow(data), replace = T, prob=c(.7, .3))
training <- data[ind==1, ]
test <- data[ind==2, ]

# K-NN
trControl <- trainControl(method = "repeatedcv", #repeated cross-validation
                          number = 10,  # sets of folds to for repeated cross-validation
                          repeats = 3)  # number of resampling iterations

fit <- train(admit ~ ., 
                 data = training,
                 tuneGrid = expand.grid(k = 1:60),
                 method = "knn",
                 trControl = trControl,
                 preProc = c("center", "scale"))  # necessary task

# Model performance
fit
plot(fit)

pred <- predict(fit, newdata = test )
pred
confusionMatrix(pred, test$admit, positive = 'yes' )


# Example-2 Regression
data(BostonHousing)
data <- BostonHousing
str(data)

# Data partition
set.seed(1234)
ind <- sample(2, nrow(data), replace = T, prob=c(.7, .3))
training <- data[ind==1, ]
test <- data[ind==2, ]

# K-NN
trControl <- trainControl(method = "repeatedcv", #repeated cross-validation
                          number = 10,  # sets of folds to for repeated cross-validation
                          repeats = 3)  # number of resampling iterations
fit <- train(medv ~ ., 
             data = training,
             tuneGrid   = expand.grid(k = 1:50),
             method = "knn",
             metric = "RMSE",
             trControl = trControl,
             preProc = c("center", "scale"))

# Model performance
fit
plot(fit)
pred <- predict(fit, newdata = test)
pred
test$medv
RMSE(pred, test$medv)

###############EOF
