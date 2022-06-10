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

#rotate the model
mcdonalds.k2 <- kmeans(mcdonalds.padronizado, centers = 2)

#view the clusters
fviz_cluster(mcdonalds.k2, data = mcdonalds.padronizado, main = "Cluster K2")

#create clusters
mcdonalds.k3 <- kmeans(mcdonalds.padronizado, centers = 3)
mcdonalds.k4 <- kmeans(mcdonalds.padronizado, centers = 4)
mcdonalds.k5 <- kmeans(mcdonalds.padronizado, centers = 5)

#create graphs
G1 <- fviz_cluster(mcdonalds.k2, geom = "point", data = mcdonalds.padronizado) + ggtitle("k = 2")
G2 <- fviz_cluster(mcdonalds.k3, geom = "point",  data = mcdonalds.padronizado) + ggtitle("k = 3")
G3 <- fviz_cluster(mcdonalds.k4, geom = "point",  data = mcdonalds.padronizado) + ggtitle("k = 4")
G4 <- fviz_cluster(mcdonalds.k5, geom = "point",  data = mcdonalds.padronizado) + ggtitle("k = 5")

#show graphics on the same screen
grid.arrange(G1, G2, G3, G4, nrow = 2)

#analyzing Elbow method
fviz_nbclust(mcdonalds.padronizado, kmeans, method = "wss")

#convert to data frame (4 groups)
mcdonalds2 <- read.table("data/MCDONALDS.csv", sep = ";", header = T, dec = ",")
mcdonalds2 <- mcdonalds2[,-1]
mcdonaldsfit <- data.frame(mcdonalds.k4$cluster)

#joining with the original base (4 groups)
mcdonaldsFinal <-  cbind(mcdonalds2, mcdonaldsfit)
#                 Valor.Energetico  Carboidratos   ...  mcdonalds.k4.cluster
# Big Mac         504               41                  2
# Big Tasty       843               45                  3
# Quarterao       558               36                  2
#   ...   
# Angus Bacon     861               57                  3
# Angus Deluxe    863               56                  3
# CBO             643               56                  2

#descriptive analysis
mediagrupo <- mcdonaldsFinal %>% 
  group_by(mcdonalds.k4.cluster) %>% 
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
# 1               7   489.7143          48.71429      30.71429      2.928571
# 2               5   567.4000          40.80000      29.20000      8.880000
# 3               3   855.6667          52.66667      48.66667      5.333333
# 4               10  351.2000          33.10000      18.20000      2.639000

