# ----- INTRO ----- 
library(tidyverse)
paciente <- 1:21
sexo <- c("hombre", "hombre", "mujer", "mujer", "mujer",
          "mujer", "mujer", "mujer", "hombre", "hombre",
          "mujer", "mujer", "hombre", "mujer", "mujer",
          "hombre", "hombre", "hombre", "mujer", "mujer", "mujer")
distancia <- c(3.9, 12.5, 5.05, 0.5, 4.35, 1.3, 3.4, 4.25,
               12.25, 13.3, 0.35, 2.8, 8.75, 0.25, 3.85,
               1.25, 8.05, 2.1, 17.65, 15.75, 2.4)

# ----- CON BUCLE -----
j <- k <- 1
hombres <- mujeres <- as.vector(0)
for (i in 1:length(sexo)) {
  if (sexo[i] == "hombre") {
    
    hombres[j] <- distancia[i]
    j <- j+1
    
  } else {
    
    mujeres[k] <- distancia[i]
    k <- k+1
    
  }
}


# ----- SIN BUCLE (PROGRAMACIÓN VECTORIAL) -----

hombres <- distancia[sexo == "hombre"]
mujeres <- distancia[sexo == "mujer"]

# Podríamos incluso tener los datos en una base de datos
datos <- tibble("sexo" = sexo, "distancia" = distancia)
hombres <- datos %>% filter(sexo == "hombre") %>% pull(distancia)
mujeres <- datos %>% filter(sexo == "mujer") %>% pull(distancia)



# ----- COMPARATIVA TIEMPOS ----- 

library(microbenchmark)

# Definimos función para luego aplicarla en microbenchmark
funcion_sexo_distancia <- function(sexo, distancia) {
  
  hombres1 <- distancia[sexo == "hombre"]
  mujeres1 <- distancia[sexo == "hombre"]
  
  return(list(hombres1, mujeres1))
}

# Inicializamos parámetros del bucle
j <- k <- 1
hombres2 <- mujeres2 <- as.vector(0)

# Comparammos: primera opción sin bucle, segunda opción con bucle
microbenchmark(funcion_sexo_distancia(sexo, distancia),
              for (i in 1:length(sexo)) {
                if (sexo[i] == "hombre") {
                  hombres2[j] <- distancia[i]
                  j <- j+1
                } else {
                  mujeres2[k] <- distancia[i]
                  k <- k+1
                }
              }, times = 5e3) # 5000 veces para comparar
            
