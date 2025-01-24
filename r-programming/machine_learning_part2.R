

library(tidyverse)
library(mlbench)
library(caret)

## split data
split_data <- function(data){
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, size = 0.7*n)
  train_df <- data[id, ]
  test_df <- data[-id, ]
  return( list(train = train_df,test = test_df))
}

prep_df<- split_data(mtcars)

#k-fold cross validation

set.seed(42)

grid_k <- data.frame(k = c(5,9))

ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE) 
knn <- train(mpg ~ .,
             data = prep_df$train,
             method = "knn",
             metric = "MAE",
             trControl = ctrl,
             ##tuneGrid = grid_k
             # ask program to ramdom k
             tuneLength = 4)


## repeated k-fold cv

set.seed(42)

ctrl <- trainControl(method = "repeatedcv",
                     number = 5, #k
                     repeats = 5,
                     verboseIter = TRUE) 
knn <- train(mpg ~ .,
             data = prep_df$train,
             method = "knn",
             metric = "MAE",
             trControl = ctrl, 
             tuneLength = 3)



## classification problem

data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes

## check / inspect data
sum(complete.cases(df)) # if equal nrow(df) then its no missing value

## logistic regression ML

split_data(df)

prep_df2 <- split_data(df)

set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5)
logit_model <- train(diabetes ~ age + glucose + pressure,
                     data= prep_df2$train,
                     method = "glm",
                     metric = "Accuracy",
                     trControl = ctrl)

## final model

logit_model$finalModel

## variable importance
varImp(logit_model)


## confusion matrix
p <- predict(logit_model, newdata = prep_df2$test) # default threshold is 0.5
p1 <- predict(logit_model, newdata = prep_df2$test, type = "prob") # set threshold
p1 <- ifelse(p1$pos >= 0.7, "pos","neg")

t1 <- table(p, prep_df2$test$diabetes, dnn = c("Predict","Actual"))
t2 <-table(p1, prep_df2$test$diabetes, dnn = c("Predict","Actual"))

## caret confusion matrix
confusionMatrix(p,prep_df2$test$diabetes, 
                positive = "pos",
                mode = "prec_recall")

## regression => high bias
## data change => model doesn't change that much

##save model.RDS

saveRDS(logit_model,"logistic_reg_model.RDS")

 

## decision tree ML

set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5)
tree_model <- train(diabetes ~ glucose + mass,
                     data= prep_df2$train,
                     method = "rpart",  # decision tree
                     metric = "Accuracy",
                     trControl = ctrl)

tree_model$finalModel

#plot tree

library(rpart.plot)
rpart.plot(tree_model$finalModel)

## random forests ML

set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5)
forest_model <- train(diabetes ~ age + glucose + pressure,
                    data= prep_df2$train,
                    method = "rf",  # random forests
                    metric = "Accuracy",
                    trControl = ctrl)

## ridge/lasso regression ML

set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5)
glmnet_model <- train(diabetes ~ age + glucose + pressure,
                      data= prep_df2$train,
                      method = "glmnet",  # ridge/lasso regression
                      metric = "Accuracy",
                      trControl = ctrl,
                      tuneGrid = expand.grid(
                        alpha = c(0,1),    
                        lambda = c(0.01,0.10)
                      ))   ## 0 is ridge , 1 is lasso


