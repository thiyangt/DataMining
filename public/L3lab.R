# date: 18 June 2022
# packages
library(tidyverse)
library(randomForest)

# Split data
data(iris)
df <- iris %>% mutate(id = row_number())
## set the seed to make your partition reproducible
set.seed(123)
train <- df %>% sample_frac(.80)
dim(train)
test <- anti_join(df, train, by = 'id')
dim(test)

# Model building
?randomForest
rf1 <- randomForest(Species ~  Sepal.Length+
                      Sepal.Width+  Petal.Length + 
                      Petal.Width,
                    data=train)
rf1

rf2 <- randomForest(Species ~  Sepal.Length+
                      Sepal.Width+  Petal.Length + 
                      Petal.Width,
                    data=train, ntree=1000)
rf2

rf3 <- randomForest(Species ~  Sepal.Length+
                      Sepal.Width+  Petal.Length + 
                      Petal.Width,
                    data=train, ntree=1000,
                    mtry=3)
rf3

## Obtain predictions for the test set

pred <- predict(rf2, test)
pred
table(pred, test$Species)


## variable importance
varImpPlot(rf2, sort=T, main="Variable Importance")

## variable importance table

var.imp <- data.frame(importance(rf2, type=2))
var.imp

## Next: Permutation-based Variable Importance Measure

