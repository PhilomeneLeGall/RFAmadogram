#### RFA-madogram functions and required packages for clustering and visualization
## LAST MODIF: 07/12/2021
## PACKAGES
library(cluster)#pam
library(rworldmap)#worldmap
library(RColorBrewer)#palette
library(corrplot)#colorbar
library(fpc)#pamk : silhouette criterion
## FUNCTIONS
rfa_func = function(x,y,a){
  # x and y: the stations time series
  # a: (c* in the function) 
  F2 <- ecdf(y)
  F1 <- ecdf(x)
  d= mean(abs(F2(a*x)-F1(y/a)),na.rm = TRUE)/2
  return(d)
}
D <- function(x,y, C=seq(0.1,10,by=0.1), return_c = FALSE){
  #ARGUMENTS
  # x and y time series
  # C = coefficient for rescaling between x and y
  # e.g. C="mean_ratio", "omega", "optim" (for an optimization an all positive numbers) or (a set of) scalar(s)
  #VALUE
  # d minimal distance between x and y : 1/2 E|F_2(cx)-F_1(y/c)| for several values of c (or for mean ratio)
  F2 <- ecdf(y)
  F1 <- ecdf(x)
  if(is.numeric(C)){
    proportion = C
    n = length(proportion)
    d = rep(NA,n)
    for (i in 1:n) {
      a = proportion[i]
      F2aX1 <- F2(a*x)
      F1X2a <- F1(y/a)
      d[i] = mean(abs(F2aX1-F1X2a),na.rm = TRUE)/2
    }
    c_opt = proportion[which.min(d)]
    D = min(d)
    result = D 
    if(return_c==TRUE){ result = list("c_opt"= c_opt,"distance" = D)}
  }#end c numeric
  
  if(is.character(C)){
    if(C=="mean_ratio"){c = mean(y,na.rm=TRUE)/mean(x, na.rm = TRUE)}
    if(C=="omega"){c = xi.Ratio(y)/xi.Ratio(x)}
    if(C%in%c("mean_ratio","omega")){
      F2 <- ecdf(y)
      F1 <- ecdf(x)
      F2CX1 <- F2(c*x)
      F1X2C <- F1(y/c)
      d = mean(abs(F2CX1-F1X2C),na.rm = TRUE)/2
      result = d
    }
    if(C == "optim"){
      #optimation
      optimization = optim(par = 0.1, fn = rfa_func, x=x,y = y, method = "Brent", lower = 0.001, upper = 10)
      result = optimization$value
      if(return_c==TRUE){ result = list("c_opt"= optimization$par,"distance" = optimization$value)}
      
    }
    
  }#end C = character
  return(result)
}#end optimized D

