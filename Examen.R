my.favorite.numbers <- c(3,7,23,49,101) 
mi.matriz <- matrix(1:9, nrow = 5, ncol = 9)
mi.matriz

library(lsa)

Vector.1 <- c(1,1,0,1,1,1,0,0,1)
Vector.2 <- c(1,1,0,0,0,1,0,1,1)
cosine(Vector.1, Vector.2)

library(datasets)
data(iris)

df <- data(iris)
df
df.head()

iris$

iris$Petal.Width
petal.width.mayor.a.tres <- iris[iris$Petal.Width >= .3]
head(petal.width.mayor.a.tres)
iris_filter <- filter(iris, petal.width > 3)

library(dplyr)
iris_filter <- filter(iris, Petal.Width > .3)
print(iris_filter)

mtx.1 <- matrix(data=1:100, nrow=10, ncol=10)
mtx.2 <- matrix(data=1:100, nrow=10, ncol=10, byrow = T)
mtx.1 == t(mtx.2)


my.data.fernando <- data.frame(name="fernando", age=19, lastname="gggggg", countryoforigin="united states", cityoforigin="rockford", 
                               favoritebook="the alchemist", lengthofhair=1, familysize=4, degree="system engineering", height=1.73,
                               fear="everything", nativelanguage="spanish", semester=5, stringsAsFactors = F)

my.data.fernando.2 <- data.frame(name="fernando", age=19, lastname="hhhhhh", countryoforigin="united states", cityoforigin="rockford", 
                                 favoritebook="the alchemist", lengthofhair=1, familysize=4, degree="system engineering", height=1.73,
                                 fear="death", language="spanish", semester=5, stringsAsFactors = F)


rbind(my.data.fernando, my.data.fernando.2)

array.2 <- c(1,T,F,0)
array.2
