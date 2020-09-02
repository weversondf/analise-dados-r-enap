# Carregando os dados
diabetes <- read.csv(
  file = "D:/Datasets/diabetes.csv"
)

head(diabetes)

# Preparação dos dados
?str
str(diabetes)

colSums(is.na(diabetes))

diabetes$Outcome <- as.factor(diabetes$Outcome)

summary(diabetes$Insulin)
boxplot(diabetes$Insulin)

boxplot(diabetes)

# Análise exploratória
hist(diabetes$Pregnancies)
hist(diabetes$Age)
hist(diabetes$BMI)

#install.packages("dplyr")
library(dplyr)

# Função filter para remover os valores distantes da média
diabetes2 <- diabetes %>%
  filter(Insulin <= 250)

boxplot(diabetes2$Insulin)

boxplot(diabetes2)
summary(diabetes2$Insulin)


# Construção do modelo preditivo
# Divisão dos dados

# install.packages("caTools")
library(caTools)

set.seed(123)
index = sample.split(diabetes2$Pregnancies, SplitRatio = .70)
index

train = subset(diabetes2, index == TRUE) # 70% dos dados
test  = subset(diabetes2, index == FALSE) # 30% dos dados

dim(diabetes2)
dim(train)
dim(test)


# install.packages("caret")
library(caret)

?caret::train

modelo <- train(
  Outcome ~., data = train, method = "knn")

# Acurácia para cada valor de k
modelo$results
modelo$bestTune

modelo2 <- train(
  Outcome ~., data = train, method = "knn",
  tuneGrid = expand.grid(k = c(1:20)))
modelo2$results
modelo2$bestTune
plot(modelo2)


# Naive bayes
modelo3 <- train(
  Outcome ~., data = train, method = "naive_bayes")
modelo3$results
modelo3$bestTune


# Outro modelo
set.seed(100)
modelo4 <- train(
  Outcome ~., data = train, method = "svmRadialSigma",
  preProcess=c("center"))
modelo4$results
modelo4$bestTune

#Avaliando o modelo
?predict
predicoes <- predict(modelo4,test)
predicoes

?caret::confusionMatrix
confusionMatrix(predicoes, test$Outcome)

# Realizando predições
novos.dados <- data.frame(
  Pregnancies = c(3),
  Glucose = c(111.50),
  BloodPressure = c(70),
  SkinThickness = c(20),
  Insulin = c(47.49),
  BMI = c(30.80),
  DiabetePedigreeFunction = c(0.34),
  Age = c(28)
)
novos.dados

previsao <- predict(modelo4,novos.dados)

resultado <- ifelse(previsao == 1, "Positivo","Negativo")
print(paste("Resultado:",resultado))

# Entregar os resultados da sua análise
write.csv(predicoes,'resultado.csv')