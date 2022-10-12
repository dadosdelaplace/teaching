# ----- INTRO ----- 
var1 <- rnorm(150, mean = 0, sd = 1)
var2 <- rnorm(150, mean = 2, sd = 3)

# ----- CON BUCLE ----- 
resultado <- rep(0, length(var1))
k <- 1
for (i in 1:length(var1)) {
  for (j in 1:length(var2)) {
    
    resultado[k] <- i + j
    k <- k + 1
  }
}

# ----- SIN BUCLE ----- 
resultado <- var1 + var2

# ----- COMPARATIVA TIEMPOS ----- 

library(microbenchmark)
resultado <- rep(0, length(var1))
k <- 1
microbenchmark(resultado <- var1 + var2,
               for (i in 1:length(var1)) {
                 for (j in 1:length(var2)) {
                   
                   resultado[k] <- i + j
                   k <- k + 1
                 }
               }, times = 5e2) # 500 veces para comparar



