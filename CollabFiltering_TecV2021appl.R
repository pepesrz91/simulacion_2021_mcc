# Collaborative Filtering

install.packages("r2d3")

setwd("/Users/adeobeso/Downloads")
music.usage <- read.csv('lastfm-matrix-germany.csv')
# 
str(music.usage)
summary(music.usage)
# 0.- We have data of 1257 Users / 286 Products (bands),
# if a user likes the band a 1 is set on that intersection
head(music.usage)
rownames(music.usage)
music.usage$abba
sum(music.usage$abba)

sum(music.usage$the.killers)
# Data 15k
sum(as.matrix(music.usage[,-1]))
music.usage.nouser <- music.usage[,-1]
music.usage.nouser[1,]

dot.prod <- function(v1,v2) {
  return(sum(v1 * v2))
}

magnit.vec <- function(v1) {
  sqrt(sum(v1 * v1))
}
mu
# 1.- A distance measure used to calculate similarity between products (Cosine, distance between vectors)
dist.cosine <- function(v1, v2) {
  return(dot.prod(v1,v2)/(magnit.vec(v1)*magnit.vec(v2)))
}

cos(0)

dist.cosine(c(1,1,1),c(1,1,1))
dist.cosine(c(1,0,1),c(0,1,0))
dist.cosine(c(5,10,100),c(-5,-10,-100))
dist.cosine(c(1,1,1),c(100,100,100))

indiv.1 <- music.usage.nouser[1,]
indiv.2 <- music.usage.nouser[2,]
dist.cosine(indiv.1, indiv.2)tas
dist.cosine(indiv.1, indiv.1)

colnames(music.usage.nouser)
colnames(music.usage.nouser)[1]
colnames(music.usage.nouser)[2]
group.1 <- music.usage.nouser[,1]
group.2 <- music.usage.nouser[,2]
dist.cosine(group.1, group.2)

colnames(music.usage.nouser)[1]
colnames(music.usage.nouser)[278]
group.1 <- music.usage.nouser[,1]
group.2 <- music.usage.nouser[,278]
dist.cosine(group.1, group.2)


music.usg.dist <- matrix(NA, nrow=ncol(music.usage.nouser), 
                         ncol=ncol(music.usage.nouser),
                         dimname=list(colnames(music.usage.nouser),
                                      colnames(music.usage.nouser)))
dim(music.usg.dist)
head(music.usg.dist)
# 2.- Populate distances among products
for (i in 1:ncol(music.usage.nouser)) {
  for(j in 1:ncol(music.usage.nouser)) {
    music.usg.dist[i,j] <- dist.cosine(music.usage.nouser[,i],
                                       music.usage.nouser[,j])
  } 
}

dim(music.usg.dist)
# check distances
# 3.- distance matrix
music.usg.dist
str(music.usg.dist)
music.usage.dist.df <- data.frame(music.usg.dist)

music.usg.dist[1:5,1:5]

similarity.blur <- music.usage.dist.df$blur
vector.mas.similares.blur <- order(music.usage.dist.df[,"blur"], decreasing=T)[2:11]      
vector.mas.similares.blur
head(music.usage.dist.df)
# 4.- Similar bands (to Abba)
rownames(music.usage.dist.df[vector.mas.similares.blur,])
music.usage.dist.df[vector.mas.similares.blur,"blur"]


# Collaborative Filtering
user.data <- matrix(NA, nrow=nrow(music.usage), 
                    ncol=ncol(music.usage)-1, 
                    dimnames=list(music.usage$user, 
                                  colnames(music.usage[,-1])))
dim(user.data)
user.data[1:5,1:5]
user.data["33",]

score.recommendation <- function(history, similarities) {
  return(sum(history*similarities/sum(similarities)))
}

# The previous matrix is used in this process. 
music.usage.dist.df
# 5.- This is the longest process, we are populating user.data, if the current user
# already likes the band a -1 is set, otherwise the bands similarity matrix is used to
# create a ranking of bands based on preferences of individuales with similar interests. 
head(user.data)
nrow(user.data)
tail(user.data)
dim(user.data)
dim(music.usage)
tail(music.usage)
for (i in 1:nrow(user.data)) {
  for (j in 1:ncol(user.data)){
    # user <- rownames(user.data)[i]
    user <- i
    artist <- colnames(user.data)[j]
    if (music.usage[user,artist]==1) {
      user.data[user,artist] = -1; 
    }
    else
    {
      top.artists <- head(n=6, 
                          music.usage.dist.df[order(
                            music.usage.dist.df[,artist], decreasing=T),][artist])
      top.artists.names <- rownames(top.artists)[-1]
      top.artists.sim <- (top.artists[,1])[-1]
      
      top.artists.history <-
        music.usage[user,c("user",top.artists.names)][-1]
      user.data[user,artist] =
        score.recommendation(top.artists.history, top.artists.sim)
      
      
    }  
    
  }
}

save(user.data, file="user.data.R")
getwd()
load("user.data.R")
str(user.data)
# 6.- this data.frame has all the required info
user.data

# RECOMMENDATIONS TO USERS

head(sort(user.data["1",],decreasing = T))
head(sort(user.data["33",],decreasing = T))
head(sort(user.data["1259",],decreasing = T))
head(sort(user.data[1200,],decreasing = T))



#### aux section

colnames(user.data)

user <- rownames(user.data)[1]
artist <- colnames(user.data)[245]
if (music.usage[user,artist]==1) {
  user.data[user,artist] = -1; 
}
else
{
  top.artists <- head(n=6, 
                      music.usage.dist.df[order(
                        music.usage.dist.df[,artist], decreasing=T),][artist])
  top.artists.names <- rownames(top.artists)[-1]
  top.artists.sim <- (top.artists[,1])[-1]
  
  top.artists.history <-
    music.usage[user,c("user",top.artists.names)][-1]
  user.data[user,artist] =
    score.recommendation(top.artists.history, top.artists.sim)
  
  
}  



