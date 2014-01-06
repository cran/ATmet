\name{sensitivityMet}
\alias{sensitivityMet}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Sensitivity analysis for metrology applications
}
\description{
Performs a sensitivity analysis for metrology applications
}
\usage{
sensitivityMet(model, x, y, nboot, method,conf)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{
a function representing a measurement model with an explicit mathemtical expression
}
  \item{x}{
a data frame that contains the input sample.
}
  \item{y}{
a vector of model responses.
}
  \item{nboot}{
an integer that denotes the number of bootstrap replicates.
}
  \item{method}{
a method for the evaluation of the sensitivity. Two methods are currently supported by sensitivityMet : "SRRC" for the standardized Rank Regression Coefficient and "Sobol" for the Sobol indices.
}
  \item{conf}{
  the confidence level of the bootstrap confidence intervals
  }
}
\details{

If \option{method = "SRRC"}, the function uses \option{src} function from the package \option{sensitivity}, with the option \option{rank=TRUE} to compute SRRC sensitivity indices. This method needs the specification of both the input sample \option{X} and either the vector of model responses \option{y} either the measurement model as a R function in \option{model}. 

If \option{method = "Sobol"}, the function uses \option{sobol2007} function from the package \option{sensitivity}. The input sample \option{x} is divided into two samples of equal dimensions. \option{Xdesign} is returned, containing the design for the computation of Sobol indices. The user should evaluate \option{Xdesign} with the computational code and provide the corresponding output values using \option{tell} function. Details on the computation of Sobol indices are given in Sobol et al. (2007).

Both methods are applicable whether the measurement model is an explicit function (defined in \option{model} as a R function) or an external code. 

The argument \option{nboot} is required in order to evaluate a confidence interval with a specified confidence level for the sensitivity indices. Default is 0 : in this case no bootstrap replicates and no confidence intervals are computed.

The argument \option{conf} defines the confidence level for the bootstrap confidence intervals. Default is 0.95.
}

\value{

  \option{sensitivityMet} returns a list with the following components :
  
    \item{model}{
a function representing a measurement model with an explicit mathemtical expression
}
    \item{method}{
  The method used for the evaluation of the sensitivity indices
  }
If \option{method = "SRRC"} :

  \item{x}{
a data frame that contains the random sample of the input quantities.
}
  \item{y}{
a vector of model responses.
}

  \item{S1}{
  a data frame wihch summarizes the first order sensitivity indices obtained with the SRRC.
  }


If \option{method = "Sobol"} :

    \item{SI}{an object of class \option{sobol2007} for the computation of the Sobol sensitivity indices with the following list of components :} 
    
  \item{model}{a function representing a measurement model with an explicit mathemtical expression}
  \item{X1}{the first random sample}
  \item{X2}{the second random sample}
  \item{nboot}{the number of bottstrap replicates}
  \item{conf}{the confidence level for bootstrap confidence intervals}
  \item{X}{a \option{data.frame} containing the design of experiment}
  \item{call}{the matched call of the function \option{sobol2007}}
  \item{y}{the response used}
  \item{V}{the estimations of Variances of the Conditional Expectations (VCE) with respect to each factor and also with respect to the complementary set of each factor ("all but Xi")}
  \item{S}{the estimations of the Sobol first order indices}
  \item{T}{the estimations of the Sobol total sensitivity indices}

      }



\references{
I.M. Sobol, S. Tarantola, D. Gatelli, S.S. Kucherenko and W. Mauntz, 2007, Estimating the approximation errors when fixing unessential factors in global sensitivity analysis, Reliability Engineering and System Safety, 92, 957-960.

A. Saltelli, P. Annoni, I. Azzini, F. Campolongo, M. Ratto and S. Tarantola, 2010, Variance based sensitivity analysis of model output. Design and estimator for the total sensitivity index, Computer Physics Communications 181, 259-270.
}
\author{
Alexandre Allard \email{alexandre.allard@lne.fr}
}

\examples{
rm(list=ls())

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
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Sobol}
\keyword{SRRC}
\keyword{metrology}
