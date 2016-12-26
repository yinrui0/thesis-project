rm(list=ls())
cat("\014")

#read dlnp
imput1 <- read.csv("diameters_ln_intervals_2014.csv", skip=16, header = FALSE)

#read dN/dlnp
imput2 <- read.csv("size_distributions__2014_09.csv", skip = 16, header = FALSE)
num <- 3544

#read diameter
imput3 <- read.csv("diameters_ln_intervals_2014.csv", skip=14, nrows=1, header = FALSE)
p <- matrix(unlist(imput3[4:90]),ncol = 87, byrow = TRUE)

#normalize pdf
dNdlnp <- matrix(unlist(imput2[4:90]),ncol = num, byrow = TRUE)
dNdlnp <- t(dNdlnp)
dNdlnp[1,]
dlnp <- matrix(unlist(imput1[4:90]),ncol = 87, byrow = TRUE)
dlnp <- t(dlnp)
dlnp[,1]
N <- dNdlnp %*% dlnp
NN <- matrix(rep(N,times=87), ncol=87)
dndlnp <- dNdlnp/NN
dndlnp[1,]

#get mean diameter
PP <- t(p)*dlnp
mu <- dndlnp %*% PP
mu
myData <- data.frame(imput2$V1,imput2$V3, mu)
colnames(myData) <- c("date","julday","mean diameter")
write.csv(myData, file = "mu_2014_09.csv")
  
  
  