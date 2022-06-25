## packages
library(adabag)
library(tidyverse)

# Split data
data(iris)
df <- iris %>% mutate(id = row_number())
## set the seed to make your partition reproducible
set.seed(123)
train <- df %>% sample_frac(.80)
dim(train)
test <- anti_join(df, train, by = 'id')
dim(test)



## adaboost
model <- boosting(Species ~  Sepal.Length+
                    Sepal.Width+  Petal.Length + 
                    Petal.Width, data=train, boos=TRUE, mfinal=50)
model
print(names(model))
print(model$trees[1])
      
## making predictions using adaboost
pred <- predict(model, test)
print(pred$confusion)
print(pred$error)

# probability of each class in test data.
result <- data.frame(test$Species, pred$prob, pred$class)
print(result)


## gradient boosting for regression
library(gbm)
model_gbm <- gbm(Petal.Length ~ Sepal.Length+
                  Sepal.Width+ Species,
                data = train,
                distribution = "gaussian",
                cv.folds = 10,
                shrinkage = .01,
                n.minobsinnode = 10,
                n.trees = 500)

print(model_gbm)
summary(model_gbm)

## making predictions
pred_y <- predict.gbm(model_gbm, test$Petal.Length)
pred_y

## model accuracy
residuals <- test$Petal.Length - pred_y
RMSE <- sqrt(mean(residuals^2))
RMSE
