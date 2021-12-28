# Ethereum Price Prediction

library(tidyverse)
library(lubridate)

# data from https://ethereumprice.org
setwd("C:/Users/trasa/Google Drive/work/Courses/R_teaching_resources/R_code/data")
data <- read.csv('ethereum.csv', header = T)
str(data)
names(data)
names(data)[1] <- 'Date'
str(data)

data <- select(data, Date, open)
data$Date <- as.Date(as.POSIXct(data$Date, origin='1970-01-01'))
str(data)
data$open <- as.numeric(data$open)
summary(data)

ggplot(data) + geom_point(aes(x=Date,y=open))

# log transformation to see details in low value range
data <- mutate(data, logPrice = log(open))

ggplot(data) + geom_point(aes(x=Date,y=logPrice))

# Forecasting with Facebook's prophet package

#install.packages('prophet')
library(prophet)
?prophet

# prepare data for prophet
data <- select(data, ds=Date, y=logPrice)

# https://cran.r-project.org/web/packages/prophet/prophet.pdf

m <- prophet(data)
str(m)
# y is stored in history var. 

future <- make_future_dataframe(m, periods = 365)
tail(future)
forecast <- predict(m, future)

# Plot forecast
dyplot.prophet(m, forecast)

# June 16,2022, Predicted = 9.88 <- in log scale
# to find in normal scale
exp(9.88)

prophet_plot_components(m, forecast)
