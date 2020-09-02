mensagem <- "Hello world!"
print(mensagem)

# Isto é um comentário

# Ajuda sobre a função
?print

# Instalando um novo pacote
install.packages("ggplot2")

# Carregando um pacote
library(ggplot2)

# Vídeo 7: Estruturas de dados
# Vetores
cidade <- c("Brasília",
            "São Paulo",
            "Rio de Janeiro",
            "Porto Alegre"
            )

cidade

temperatura <- c(32,22,35,17)

regiao <- c(1,2,2,3)

?c()

# Acessando o primeiro elemento
cidade[1]

# Acessando um intervalo de elementos
temperatura[1:3]

# Copiando um vetor
cidade2 <- cidade
cidade2

# Excluindo o segundo elemento da consulta
temperatura[-2]

# Alterando um vetor
cidade2[3] <- "Belo Horizonte"

# Adicionando um novo elemento
cidade2[5] <- "Curitiba"
cidade2

# Deletando o vetor
cidade2 <- NULL
cidade2

# Fatores
?factor

UF <- factor(c("DF","SP","RJ","RS"))
UF

grau.instrucao <- factor(c("Nível Médio",
                            "Superior",
                            "Nível Médio",
                            "Fundamental"),
                  levels = c("Fundamental",
                            "Nível Médio" ,
                            "Superior"),
                  ordered = TRUE)
grau.instrucao

# Listas
?list()
pessoa <- list(sexo = "M", cidade = "Brasília", idade="20")
pessoa

# Acessando o primeiro elemento da lista
pessoa[1]

# Acessando o valor do primeiro elemento da lista
pessoa[[1]]

# Editando a lista
pessoa[["idade"]] <- 22
pessoa

# Deletando elemento da lista
pessoa[["idade"]] <- NULL
pessoa

# Filtrando elementos da lista
pessoa[c("cidade","idade")]

# Lista de listas
cidades <- list(cidade = cidade,
                temperatura = temperatura,
                regiao = regiao)
cidades

# Criando um data frame com vetores
df <- data.frame(cidade, temperatura)
df

# Criando um dataframe com lista
df2 <- data.frame(cidades)
df2

# Filtrando valors do dataframe
# recuperando o valor da linha 1, coluna 2
df[1,2]

# Todas as linhas da primeira coluna
df[,1]

# Primeira linha e todas as colunas
df[1,]

# Selecionando as 3 primeiras linhas
# da primeira e ultima coluna
df2[c(1:3), c(1,3)]

# Verificando o nome das colunas
names(df)

# Verificando numero de linhas X colunas
dim(df)

# Verificando os tipos de dados
str(df)

# Acessar uma coluna do dataframe
df$cidade
df['cidade']

# Matrizes
?matrix()
m <- matrix(seq(1:9), nrow = 3)
m

m2 <- matrix(seq(1:25),
            ncol = 5,
            byrow = TRUE,
            dimnames = list(c(seq(1:5)),
                            c('A','B','C','D','E')
                            )
            )
m2

# Filtrando a matriz
m2[c(1:2),c("B","C")]


# Vídeo 8: Estruturas de repetição

# Loops

# For

# for (valor in sequencia){
#   codigo...
# }

#Exemplo for
for (i in seq(12)){
  print(i)
}

# While

# while (condicao){
#   codigo...
# }

i <- 0
while(i <= 10){
  # codigo
  print(i)
  i = i + 1
}

# Vídeo 9: Controle de fluxo
# if (condicao){
#   codigo...
# }

x = 10
if (x > 0) {
  print("Número positivo")
}

nota = 4
if (nota >= 7) {
  print("Aprovado")
} else if (nota > 5 && nota < 7) {
  print("Recuperação")
} else {
  print("Reprovado")
}

# Vídeo 10: Criando funções
par.impar <- function(num){
  if((num %% 2) == 0) {
    return("Par")
  } else 
    return("Impar")
}

# Usando a função
num = 3
par.impar(num)

# Vídeo 11: Utilizando funções apply
# Apply()
?apply

x <- seq(1:9)
matriz <- matrix(x, ncol=3)
matriz

result1 <- apply(matriz,1,sum)
result1

result2 <- apply(matriz,2,sum)
result2

?list

numeros.p <- c(2,4,6,8,10,12)
numeros.i <- c(1,3,5,7,9,11)
numeros <- list(numeros.p,numeros.i) # agrupar em uma lista

numeros


?lapply
lapply(numeros, mean)

?sapply
sapply(numeros, mean)



# Vídeo 12: Criando gráficos
# Dataset pré-carregado da linguagem R
?mtcars
carros <- mtcars[,c(1,2,9)]

head(carros)

# Gráfico em coluna
hist(carros$mpg)

# Gráfico de dispersão
plot(carros$mpg, carros$cyl)

# Gráfico com o ggplot
#install.packages("ggplot2")
library(ggplot2)
ggplot(carros,aes(am))+
  geom_bar()

# Vídeo 13: Utilizando junções/joins

df1 <- data.frame(Produto = c(1,2,3,5),Preco = c(15,10,25,20))
head(df1)

df2 <- data.frame(Produto = c(1,2,3,4),Preco = c("A","B","C","D"))
head(df2)

# Carregar o pacote "dplyr"
#install.packages("dplyr")
library(dplyr)

df3 <- left_join(df1,df2,"Produto")
head(df3)

df4 <- right_join(df1,df2,"Produto")
head(df4)

df5 <- inner_join(df1,df2,"Produto")
head(df5)

# Vídeo 14: Selecionando os dados
#DPLYR
?iris

# Dataset pré-carregado da linguagem R
head(iris)

# Observar tipo e valores das colunas
glimpse(iris)

# Filter - filtrando os dados - apenas versicolor
versicolor <- filter(iris, Species == "versicolor")
dim(versicolor)

# Slice - selecionando algumas linhas específicas
slice(iris,5:10)

# Select - selecionando alguma colunas
select(iris,2:4)

# Todas colunas exceto Sepal width
select(iris, -Sepal.Width)

# Criando uma nova coluna com base em colunas existentes
iris2 <- mutate(iris, nova.coluna = Sepal.Length + Sepal.Width)
iris2[,c("Sepal.Length","Sepal.Width","nova.coluna")]

# Arrange - Ordenar
?arrange
select(iris,Sepal.Length) %>%
arrange((Sepal.Length))

?group_by
# Group by
iris %>% group_by(Species) %>%
  summarise((mean(Sepal.Length)))

# Vídeo 15: Transformando os dados
# Carregar o pacote "tidyr"
# install.packages("tidyr")
library(tidyr)
# Quantidade de vendas por ano e produto
dfDate <- data.frame(Produto=c('A','B','C'),
                    A.2015 = c(10,12,20),
                    A.2016 = c(20,25,35),
                    A.2017 = c(15,20,30)
                    )
head(dfDate)

?gather
dfDate2 <- gather(dfDate, "Ano", "Quantidade", 2:4)
head(dfDate2)

?separate
dfDate3 <- separate(dfDate2, Ano, c("A", "Ano"))
dfDate3 <- dfDate3[-2]                    
dfDate3

# Acrescentando uma coluna Mes
dfDate3$Mes <- c('01','02','03')
dfDate3

# Juntar os dados de diferentes colunas
?unite
dfDate4 <- dfDate3 %>%
  unite(Data, Mes, Ano, sep='/')
head(dfDate4)
