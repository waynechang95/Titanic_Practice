setwd('C:/Users/hp/Desktop/1101/1101資料科學/GitHub/hw5-waynechang95/Titanic_Data')

df_train <- read.csv('train.csv', header = T)
## Data
# Statistics
summary(df_train)

#Chart
install.packages('tidyverse')
library(tidyverse)
library(ggplot2)


# EDA
str(df_train)
df_train$Survived <- as.factor(df_train$Survived)
df_train$Pclass <- as.factor(df_train$Pclass)
# boxplot
ggplot(df_train) +
  geom_boxplot(mapping = aes(x = Age, y = Survived),outlier.colour="red",outlier.size=2)
ggplot(df_train) +
  geom_histogram(mapping = aes(x = Age))
ggplot(df_train) +
  geom_histogram(mapping = aes(x = Age, fill = Survived), position = 'identity')

ggplot(df_train) +
  geom_boxplot(mapping = aes(x = SibSp, y = Survived),outlier.colour="red",outlier.size=2)
ggplot(df_train) +
  geom_histogram(mapping = aes(x = SibSp))

ggplot(df_train) +
  geom_boxplot(mapping = aes(x = Parch, y = Survived),outlier.colour="red",outlier.size=2)
ggplot(df_train) +
  geom_histogram(mapping = aes(x = Parch))

ggplot(df_train) +
  geom_boxplot(mapping = aes(x = Fare, y = Survived),outlier.colour="red",outlier.size=2)
ggplot(df_train) +
  geom_histogram(mapping = aes(x = Fare))
ggplot(df_train) +
  geom_histogram(mapping = aes(x = Fare, fill = Survived),bins = 50, position = 'identity', alpha = 0.5)


# bar plot
ggplot(df_train) + 
  geom_bar(mapping = aes(x = Survived, fill = Survived))

ggplot(df_train) + 
  geom_bar(mapping = aes(x = Pclass, fill = Pclass))

ggplot(df_train) + 
  geom_bar(mapping = aes(x = Sex, fill = Sex))

ggplot(df_train) + 
  geom_bar(mapping = aes(x = Embarked, fill = Embarked))

# Analysis
ggplot(df_train) + 
  geom_bar(mapping = aes(x = Survived, fill = Sex ))

ggplot(df_train) + 
  geom_bar(mapping = aes(x = Survived, fill = Embarked ))

ggplot(df_train) + 
  geom_bar(mapping = aes(x = Survived, fill = Pclass ))

## Data Processing
# Missing Value
A <- which(is.na(df_train$Age))
df_train[A,'Age'] <- mean(df_train[-A,'Age'])
B <- which(df_train$Embarked == '')
df_train[B,'Embarked'] <- 'S'

# One-Hot-Encoding
  #install.packages('mltools')
  #install.packages('data.table',type = 'binary')
library(data.table)
library(mltools)
df_train$Sex <- ifelse(df_train$Sex == 'male', 1, 0)
df_pclass <- one_hot(as.data.table(df_train$Pclass))
df_embarked <- one_hot(as.data.table(df_train$Embarked))

names(df_pclass)[1:2] <- c('Pclass_1','Pclass_2')
names(df_embarked)[2:3] <- c('Embarked_C','Embarked_Q')

df_train <- cbind(df_train, df_pclass[,1:2])
df_train <- cbind(df_train, df_embarked[,2:3])

# standardized
df_train$Age <- (df_train$Age-mean(df_train$Age))/(var(df_train$Age)**(1/2))
df_train$Fare <- (df_train$Fare-mean(df_train$Fare))/(var(df_train$Fare)**(1/2))
df_train$SibSp <- (df_train$SibSp-mean(df_train$SibSp))/(var(df_train$SibSp)**(1/2))
df_train$Parch <- (df_train$Parch-mean(df_train$Parch))/(var(df_train$Parch)**(1/2))

# PCA
install.packages('FactoMineR')
library("FactoMineR")

df_pca <- df_train[c('Age','SibSp','Parch','Fare')]
PCA(df_pca)


## Modeling
# Cross-Validation
CVgroup <- function(k,datasize,seed){
  cvlist <- list()
  set.seed(seed)
  n <- rep(1:k,ceiling(datasize/k))[1:datasize]
  temp <- sample(n,datasize)
  x <- 1:k
  dataseq <- 1:datasize
  cvlist <- lapply(x,function(x) dataseq[temp==x])
  return(cvlist)
}
cvlist <- CVgroup(6,dim(df_train)[1],seed = 110)

ans <- matrix(0,8,4)
ans[1,] <- c('set','training','validation','test')
for (i in 1:6){
  ans[i+1,1] <- paste('fold',i)
}
ans[8,1] <- 'ave.'

## Logistic Regression
for (i in 1:6){
  ### Split into training / validation / test
  test_index <- i
  if (i == 6){
    validation_index <- 1
  } else if (i != 6){
    validation_index <- i+1
  }
  train <- df_train[-c(cvlist[[test_index]],cvlist[[validation_index]]),]
  test <- df_train[cvlist[[test_index]],]
  validation <- df_train[cvlist[[validation_index]],]
  ### Model
  fmla <- 'Survived~Sex+Age+Fare+SibSp+Parch+Pclass_1+Pclass_2+Embarked_C+Embarked_Q'
  model <- glm(fmla,data=train, family = binomial(link = 'logit'))
  
  ### Training
  resultframe <- data.frame(truth=train$Survived,pred=ifelse(predict(model, type = 'response')>=0.6,1,0))
  rtab <- table(resultframe)
  accuracy_train <- (sum(diag(rtab)))/(sum(rtab))
  ans[i+1,2] <- as.numeric(round(accuracy_train,2))
  
  ### Validation
  resultframe <- data.frame(truth=validation$Survived,pred=ifelse(predict(model, newdata = validation, type="response")>=0.6,1,0))
  rtab <- table(resultframe)
  accuracy_validation <- (sum(diag(rtab)))/(sum(rtab))
  ans[i+1,3] <- as.numeric(round(accuracy_validation,2))
  
  ### Test
  resultframe <- data.frame(truth=test$Survived,pred=ifelse(predict(model, newdata = test, type="response")>=0.6,1,0))
  rtab <- table(resultframe)
  accuracy_test <- (sum(diag(rtab)))/(sum(rtab))
  ans[i+1,4] <- as.numeric(round(accuracy_test,2))
}

library(car)
summary(model)
vif(model)

## Decision Tree
library(rpart)
for (i in 1:6){
  ### Split into training / validation / test
  test_index <- i
  if (i == 6){
    validation_index <- 1
  } else if (i != 6){
    validation_index <- i+1
  }
  train <- df_train[-c(cvlist[[test_index]],cvlist[[validation_index]]),]
  test <- df_train[cvlist[[test_index]],]
  validation <- df_train[cvlist[[validation_index]],]
  ### Model
  fmla <- 'Survived~Sex+Age+Fare+SibSp+Parch+Pclass_1+Pclass_2+Embarked_C+Embarked_Q'
  model <- rpart(fmla,data=train, control=rpart.control(minsplit = 5,cp = 0.0001,maxdepth=30),method="class")
  
  ### Training
  resultframe <- data.frame(truth=train$Survived,pred=predict(model, type="class"))
  rtab <- table(resultframe)
  accuracy_train <- (sum(diag(rtab)))/(sum(rtab))
  ans[i+1,2] <- as.numeric(round(accuracy_train,2))
  
  ### Validation
  resultframe <- data.frame(truth=validation$Survived,pred=predict(model, newdata = validation, type="class"))
  rtab <- table(resultframe)
  accuracy_validation <- (sum(diag(rtab)))/(sum(rtab))
  ans[i+1,3] <- as.numeric(round(accuracy_validation,2))
  
  ### Test
  resultframe <- data.frame(truth=test$Survived,pred=predict(model, newdata = test, type="class"))
  rtab <- table(resultframe)
  accuracy_test <- (sum(diag(rtab)))/(sum(rtab))
  ans[i+1,4] <- as.numeric(round(accuracy_test,2))
}

plot(model)
summary(model)

# Random Forest
library(randomForest)
for (i in 1:6){
  ### Split into training / validation / test
  test_index <- i
  if (i == 6){
    validation_index <- 1
  } else if (i != 6){
    validation_index <- i+1
  }
  train <- df_train[-c(cvlist[[test_index]],cvlist[[validation_index]]),]
  test <- df_train[cvlist[[test_index]],]
  validation <- df_train[cvlist[[validation_index]],]
  ### Model
  model <- randomForest(Survived~Sex+Age+Fare+SibSp+Parch+Pclass_1+Pclass_2+Embarked_C+Embarked_Q, data = train, importane = T)
  
  ### Training
  resultframe <- data.frame(truth=train$Survived,pred=predict(model, type="class"))
  rtab <- table(resultframe)
  accuracy_train <- (sum(diag(rtab)))/(sum(rtab))
  ans[i+1,2] <- as.numeric(round(accuracy_train,2))
  
  ### Validation
  resultframe <- data.frame(truth=validation$Survived,pred=predict(model, newdata = validation, type="class"))
  rtab <- table(resultframe)
  accuracy_validation <- (sum(diag(rtab)))/(sum(rtab))
  ans[i+1,3] <- as.numeric(round(accuracy_validation,2))
  
  ### Test
  resultframe <- data.frame(truth=test$Survived,pred=predict(model, newdata = test, type="class"))
  rtab <- table(resultframe)
  accuracy_test <- (sum(diag(rtab)))/(sum(rtab))
  ans[i+1,4] <- as.numeric(round(accuracy_test,2))
}

## Result (Average)
for (i in 2:4){
  ans[8,i] <- round(sum(as.numeric(ans[2:7,i]))/6,2)
}
ans

## Evaluation

model <- randomForest(Survived~Sex+Age+Fare+SibSp+Parch+Pclass_1+Pclass_2+Embarked_C+Embarked_Q, data = df_train, importane = T)


# Importance
model$importance

# Roc Curve
install.packages('pRoc')
library(pROC)

truth <- as.numeric(test$Survived)
pred <- as.numeric(predict(model, newdata = test, type="class"))
roc1 <- roc(pred, truth)


