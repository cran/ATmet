\name{ATmet-package}
\alias{ATmet-package}
\alias{ATmet}
\docType{package}
\title{
Advanced Tools for Metrology
}
\description{
This package provides functions for smart sampling and sensitivity analysis for metrology applications, including computationally expensive problems.
}
\details{
\tabular{ll}{
Package: \tab ATmet\cr
Type: \tab Package\cr
Version: \tab 1.2\cr
Date: \tab 2014-01-06\cr
License: \tab GPL-3 \cr
}

The function for smart sampling implements the Latin Hypercube Sampling (LHS) method using the \option{lhs} package.
The functions for sensitivity analysis implement the Standardized Rank Regression Coefficient (SRRC) and the Sobol' sensitivity indices using the \option{sensitivity} package. These methods can be used for computationally expensive problems.

}
\note{This work is part of a joint research project within the European Metrology Research Programme (EMRP) called "Novel Mathematical and Statistical Approaches to Uncertainty Evaluation". The EMRP is jointly funded by the EMRP participating countries within EURAMET and the European Union.}

\author{
Severine Demeyer and Alexandre Allard

Maintainer: \email{severine.demeyer@lne.fr} \email{alexandre.allard@lne.fr}

}

\keyword{ latin hypercube sampling, srrc, sobol }
\seealso{

 \code{\link{lhs}} 
 
 \code{\link{sensitivity}}
}
\examples{
# **********************
# Smart sampling method
# **********************

N<- 100
  k<- 4
  x<- list("X1","X2","X3","X4")
  distrib<- list("norm","norm","unif","t.scaled")
  distrib.pars<- list(list(0,2),list(0,1),list(20,150),list(2,0,1))
  LHSdesign(N,k,distrib,distrib.pars,x)
  
# **********************
# Sensitivity analysis
# **********************
  
##Simulate the input sample
M=10000
Xmass <- data.frame(X1 = rnorm(M, 100, 5e-5),
                    X2 = rnorm(M, 0.001234, 2e-5),
                    X3 = runif(M, 1100, 1300),
                    X4 = runif(M,7000000,9000000),
                    X5 = runif(M,7950000,8050000))#Data-frame

#Define the measurement model (GUM-S1, 9.3)
calibMass <-function(x){
  return(((x[,1]+x[,2])*(1+(x[,3]-1200)*(1/x[,4]-1/x[,5]))-100)*1e3)
}

#####   Use SRRC with a model function    #####
#Apply sensitivityMet function to evaluate the associated SRRC indices
S_SRRC=sensitivityMet(model=calibMass,x=Xmass, nboot=100, method="SRRC", conf=0.95)
##Print the results
#First order indices
S_SRRC$S1

#####   Use Sobol with a computational code   #####
#Creation of the design for the computation of Sobol sensitivity indices
S_Sobol=sensitivityMet(model=NULL,x=Xmass,y=NULL, nboot=100, method="Sobol", conf=0.95)

#Obtain the design of experiment to submit to the code
XDesign=S_Sobol$SI$X

#Run the computational code with XDesign as a sample of the input quantities
#We use calibMass function (see GUM-S1) as an example
YDesign=calibMass(XDesign)

#Run the Sobol indices calculations with the outputs of the code
S_Sobol$SI=tell(x=S_Sobol$SI,y=YDesign)

##Print the results
#First order indices
S_Sobol$SI$S
#Total order indices
S_Sobol$SI$T 
  
}
