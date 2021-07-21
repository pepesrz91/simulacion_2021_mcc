# código R parte 1

list.of.packages <- c("lsa", "rpivotTable","dplyr","tidyr", "shiny","shinydashboard", "dplyr", "DT", "XLConnect")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(dplyr)
library(reshape2)
library(tidyr)
library(rpivotTable)

?dashboardHeader

#install.packages("rpivotTable")
#install.packages("shiny")
library(shiny)

Sys.setlocale("LC_ALL", 'es_ES')
content.file <- read.csv("comentarios1.json",encoding="Latin-1", header = F)
# variables de configuracion
directorio.de.trabajo <- getwd()
nombre.archivo.denue <- "INEGI_DENUE_NORTE.csv"
region.actual <- "NORTE"
ventana.prediccion <- 15.5
anio.prediccion <- 2030
# carrera.especifica <- ""
# archivo.mapeo.carreras.l4 <- "mapeocarreral4scian.csv"
# mario.molina.relevante <- c("TECMM.ATequila")  # pueden ser varios. 
limite.superior.relevancia <- 2

# datos denue
getwd()
setwd(directorio.de.trabajo)
# load("region.lookup.table.R")
# region.lookup.table
datos.primarios.denue <- read.csv(nombre.archivo.denue,stringsAsFactors = F,  fileEncoding='latin1')
colnames(datos.primarios.denue)
length(colnames(datos.primarios.denue))
head(datos.primarios.denue)
nrow(datos.primarios.denue)
str(datos.primarios.denue)
dim(datos.primarios.denue)

mis.columnas.norte <- colnames(datos.primarios.denue)
save(mis.columnas.norte, file="mis.columnas.norte.R")
load("mis.columnas.norte.R")
mis.columnas.norte

# limpiar los headers.
nombre.headers <- c("id","Clee","nombre","razon.social","codigo.scian","nombre.actividad","descripcion.estrato",
                    "tipo.vialidad","nombre.vialidad","tipo.entre.vialidad.1","nombre.entre.vialidad.1",
                    "tipo.entre.vialidad.2","nombre.entre.vialidad.2","tipo.entre.vialidad.3","nombre.entre.vialidad.3",
                    "numero.exterior","letra.exterior","edificio","edificio.piso","numero.interior","letra.interior",
                    "tipo.asentamiento","nombre.asentamiento","tipo.centro.comercial","corredor.industrial.centro.comercial.o.mercado.publico",
                    "numero.local","codigo.postal","clave.entidad","entidad.federativa","clave.municipio","nombre.municipio", "clave.localidad",
                    "nombre.localidad","ageb","manzana","numero.telefono","email","sitio.web","tipo.establecimiento","lat","long", "fecha.incorporacion")
length(nombre.headers)
nombre.headers
head(datos.primarios.denue)
colnames(datos.primarios.denue) <- nombre.headers
str(datos.primarios.denue)

unique(datos.primarios.denue$tipo.establecimiento)

columnas.elegidas <- c("id","nombre","codigo.scian","nombre.actividad","descripcion.estrato", "tipo.asentamiento",
                       "nombre.asentamiento","codigo.postal","clave.municipio","nombre.municipio","clave.localidad",
                       "nombre.localidad", "tipo.establecimiento", "lat", "long", "fecha.incorporacion")
denue.columnas.seleccion <- datos.primarios.denue[,columnas.elegidas]
str(denue.columnas.seleccion)

# asignar potencial demanda por estrato
unique(denue.columnas.seleccion.demanda$descripcion.estrato)
denue.columnas.seleccion.demanda <- denue.columnas.seleccion
denue.columnas.seleccion.demanda[denue.columnas.seleccion.demanda$descripcion.estrato=="0 a 5 personas","demanda"] <- 1
denue.columnas.seleccion.demanda[denue.columnas.seleccion.demanda$descripcion.estrato=="6 a 10 personas","demanda"] <- 2
denue.columnas.seleccion.demanda[denue.columnas.seleccion.demanda$descripcion.estrato=="11 a 30 personas","demanda"] <- 4
denue.columnas.seleccion.demanda[denue.columnas.seleccion.demanda$descripcion.estrato=="31 a 50 personas","demanda"] <- 7
denue.columnas.seleccion.demanda[denue.columnas.seleccion.demanda$descripcion.estrato=="51 a 100 personas","demanda"] <- 14
denue.columnas.seleccion.demanda[denue.columnas.seleccion.demanda$descripcion.estrato=="101 a 250 personas","demanda"] <- 30
denue.columnas.seleccion.demanda[denue.columnas.seleccion.demanda$descripcion.estrato=="251 y mas personas","demanda"] <- 50

denue.columnas.seleccion.demanda$subscian <- substr(as.character(denue.columnas.seleccion.demanda$codigo.scian),1,3)
# esta es la columna para hacer el mapeo
denue.columnas.seleccion.demanda$l4 <- substr(as.character(denue.columnas.seleccion.demanda$codigo.scian),1,4)
str(denue.columnas.seleccion.demanda)
head(denue.columnas.seleccion.demanda)
colnames(denue.columnas.seleccion.demanda)
datos.pivote <- denue.columnas.seleccion.demanda[,c("codigo.scian","descripcion.estrato","nombre.municipio",
                                                    "fecha.incorporacion","demanda","subscian","l4")]
datos.pivote$sector <- substr(as.character(datos.pivote$codigo.scian),1,2)
head(datos.pivote)

datos.pea <- read.csv("conjunto_de_datos_sdem_enoen_2021_1t.csv")
nrow(datos.pea)

# Casimiro
datos.pea.jalisco <- datos.pea[datos.pea$est == 14]
datos.pea

install.packages("readxl")
library("readxl")
# Check if you already installed the package
any(grepl("data.table", 
          installed.packages()))

# Integración
df <- read_excel("datos_madre.xlsx",
                            sheet = 1, head=FALSE)
head(df)

df <- df[-c(1,2,3,4,5),]
df <- df[, -c(5:length(df))]
head(df)
colnames(df) <- c("clave.municipio", "municipio", "total", "1990.menor.15a19, ")
head(df)
