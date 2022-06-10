#library
library(tidyverse)
library(cluster) 
library(dendextend) 
library(factoextra) 
library(fpc) 
library(gridExtra) 
library(readxl)

#load data, view, move ID to rows
mcdonalds <- read.table("data/MCDONALDS.csv", sep = ";", header = T, dec = ",")
View(mcdonalds)
rownames(mcdonalds) <- mcdonalds[,1]
mcdonalds <- mcdonalds[,-1]
View(mcdonalds)
#                 Valor.Energetico  Carboidratos  Proteinas ... Calcio  Ferro
# Big Mac         504               41            25            162     6.50
# Big Tasty       843               45            41            381     8.20  
# Quarterao       558               36            31            275     10.00
#   ...   
# Angus Bacon     861               57            54            193     4.00
# Angus Deluxe    863               56            51            197     3.80
# CBO             643               56            27            236     6.90

#standardize variables
mcdonalds.padronizado <- scale(mcdonalds)
#                 Valor.Energetico  Carboidratos  ...   Ferro
# Big Mac         0.05977885        -0.0386353          0.75738115       
# Big Tasty       2.03878557        0.3906458           1.34040412      
# Quarterao       0.37501885        -0.5752367          1.95772257      
#   ...   
# Angus Bacon     2.14386557        1.6784891           -0.10000559          
# Angus Deluxe    2.15554112        1.5711688           -0.16859653
# CBO             0.87122998        1.5711688           0.89456302  

#calculate the distances of the matrix using the Euclidean distance
distancia <- dist(mcdonalds.padronizado, method = "euclidean")

#calculate the Cluster: available "single" method
cluster.hierarquico <- hclust(distancia, method = "single" )

#dendrogram
plot(cluster.hierarquico, cex = 0.6, hang = -1)

#Create the graph and highlight the groups
rect.hclust(cluster.hierarquico, k = 2)

#Checking the Elbow Method
fviz_nbclust(mcdonalds.padronizado, FUN = hcut, method = "wss")

#creating 4 groups of snacks
grupo_lanches4 <- cutree(cluster.hierarquico, k = 4)
table(grupo_lanches4)
# grupo_lanches4
# 1   2   3   4
# 
# 21  1   1   2

#transforming cluster output into data frame
Lanches_grupos <- data.frame(grupo_lanches4)

#joining with the original base
Base_lanches_fim <- cbind(mcdonalds, Lanches_grupos)
View(Base_lanches_fim)
#                 Valor.Energetico  Carboidratos  Proteinas ... grupo_lanches4
# Big Mac         504               41            25            1
# Big Tasty       843               45            41            2
# Quarterao       558               36            31            1
#   ...   
# Angus Bacon     861               57            54            4
# Angus Deluxe    863               56            51            4
# CBO             643               56            27            1

#descriptive analysis
mediagrupo <- Base_lanches_fim %>% 
  group_by(grupo_lanches4) %>% 
  summarise(n = n(),
            Valor.Energetico = mean(Valor.Energetico), 
            Carboidratos = mean(Carboidratos), 
            Proteinas = mean(Proteinas),
            Gorduras.Totais = mean(Gorduras.Totais), 
            Gorduras.Saturadas = mean(Gorduras.Saturadas), 
            Gorduras.Trans = mean(Gorduras.Trans),
            Colesterol = mean(Colesterol), 
            Fibra.Alimentar = mean(Fibra.Alimentar), 
            Sodio = mean(Sodio),
            Calcio = mean(Calcio), 
            Ferro = mean(Ferro) )
df <- data.frame(mediagrupo)
View(df)
# grupo_lanches4  n   Valor.Energetico  Carboidratos  Proteinas ... Ferro
# 1               21  445.3333          40.2381       24.0          4.161429
# 2               1   843.0000          45.0000       41.0          8.200000
# 3               1   425.0000          31.0000       39.0          3.900000
# 4               2   862.0000          56.5000       52.5          3.900000