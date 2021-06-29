# Introducción R

# Tipos Primarios - Todo en R es un objeto

var.integer <- 20
var.integer <- as.integer(10)
class(var.integer)

var.numeric <- 2.3
class(var.numeric)
NULL


complex <- complex(real=5, imaginary=4)
complex

c.1 <- c(4,5,6)
c.2 <- c(4,5,"hello", TRUE)
c.2

c.1 + c.2
 c.3
 
 
 
 
 datos.jose.suarez <- data.frame(
   nombre="jose juan",
   edad=30,
   pelicula.favorita="the lord of the rings",
   peso=73.2,
   estatura=1.745,
   usa.lentes=T,
   lenguaje.favorito="javascript",
   semestre.cursado=6,
   lugar.trabajo="flourish savings",
   apodo="pepe"
 )
 
 alumnos.v.2021
 getwd()
 save(alumnos.v.2021, file="alumnos.v.2021")
 
 load("alumnos.v.2021")
 
 