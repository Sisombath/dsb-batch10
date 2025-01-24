library(caret)
library(mlbench)
library(tidyverse)

## load data
mtcars

## split data 70:30
set.seed(24)
n <- nrow(mtcars)
id <- sample(1:n, size = 0.7*n)
train_df <- mtcars[id, ]
test_df <- mtcars[-id, ]

## train a linear regression model
set.seed(24)
lm_model <- train(mpg~ hp + wt + am, 
                  data = train_df,
                  method = "lm")

## Train KNN model
knn_model <- train(mpg~ hp + wt + am, 
                  data = train_df,
                  method = "knn")
## score
p_test <- predict(lm_model, newdata = test_df)
p_test_knn <- predict(knn_model, newdata = test_df)
## evaluate MAE, MSE, RMSE
error <- test_df$mpg - p_test
error_knn <- test_df$mpg - p_test_knn

mae <- mean(abs(error_knn))
mse <- mean(error_knn**2) 
rmse <- sqrt(mean(error_knn**2))











