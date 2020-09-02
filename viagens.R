# Carregando os dados
?read.csv

viagens <- read.csv(
  file = "D:/Datasets/2019_Viagem.csv",
  sep = ';',
  dec = ','
)

# Lista os dados
head(viagens)

# Lista os dados em tabela
View(viagens)

# Verifica o número de observação e colunas do dataset
dim(viagens)

# Recupera valor mínimo, máximo e média com a função summary
?summary

summary(viagens)

summary(viagens$Valor.passagens)

# install.packages("dplyr")
library(dplyr)

# Verificar o tipo dos dados de cada coluna
glimpse(viagens)

# Transformar os campos "Período...Data.de.início" e "Período...Data.de.fim" 
# de factor "fct" em tipo data
?as.Date

viagens$data.inicio <- as.Date(viagens$Período...Data.de.início,
                               "%d/%m/%y")

glimpse(viagens)

viagens$data.inicio.formatada <- format(viagens$data.inicio, "%Y-%m")

viagens$data.inicio.formatada

?format

# Análise explorartória dos dados
hist(viagens$Valor.passagens)

# Valores min, max, média.. dac oluna valor
summary(viagens$Valor.passagens)

# Visualizando os valores em um boxplot
# outliers são evidenciados no gráfico gerado
boxplot(viagens$Valor.passagens)

# Calculando o desvio padrão
sd(viagens$Valor.passagens)

?is.na
?colSums

# is.na: Verifica se existem campos com valores não preenchidos
# colSums: contabiliza a quantidade campos não preenchidos por coluna
colSums(is.na(viagens))

# Verificar a quantidade de ocorrências para cada categoria de uma
# determinada coluna
str(viagens$Situação)

# Verificar a quantidade de ocorrências para cada classe
table(viagens$Situação)

# Obter o valor em percentual
prop.table(table(viagens$Situação))*100

# 1. Quais o´rgãos estão gastndo mais com passagens aéreas?

# Criando um dataframe com os 15 órgãos que gastam mais
p1 <- viagens %>%
  group_by(Nome.do.órgão.superior) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)

names(p1) <- c("orgao","valor")

p1

# Plotando os dados com o ggplot
library(ggplot2)
ggplot(p1,aes(x= reorder(orgao,valor),y= valor))+
  geom_bar(stat="identity")+
  coord_flip()+
  labs(x="Valor",y="Órgãos")


p2 <- viagens %>%
  group_by(Destinos) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)

names(p2) <- c("destino","valor")

# Criando o gráfico
ggplot(p2,aes(x= reorder(destino,valor),y= valor))+
  geom_bar(stat="identity",fill="#0ba791")+
  geom_text(aes(label=valor), vjust=0.3, size=3)+
  coord_flip()+
  labs(x="Valor",y="Destino")

options(scipen=999)

# Quantidade de viagens realizadas por mês
p3 <- viagens %>%
  group_by(data.inicio.formatada) %>%
  summarise(qtd = n_distinct(Identificador.do.processo.de.viagem))

head(p3)

ggplot(p3,aes(x=data.inicio.formatada, y=qtd, group=1))+
  geom_line()+
  geom_point()

# Visualização dos dados
install.packages("rmarkdown")
install.packages("tinytex")

tinytex::install_tinytex()
