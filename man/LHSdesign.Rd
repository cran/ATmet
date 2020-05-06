\name{LHSdesign}
\alias{LHSdesign}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Latin hypercube sampling for metrology applications
}
\description{
  Creates latin hypercube sampling designs for metrology applications
}
\usage{
  LHSdesign(N,k,distrib,distrib.pars,x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{N}{
    The number of design points.
  }
   
  \item{k}{
    The number of the input variables of the numerical code.
  }
  \item{distrib}{
    A named list of length \code{k} of names of distribution functions associated with the input variables of the code. See Details for defaults.
  }
  \item{distrib.pars}{
    A named list of lists of parameters describing the distributions associated with \code{distrib}. If \code{distrib} is present but \code{distrib.pars} is not the function uses the standardized versions of the distributions, see Details.
  }  
  \item{x}{
   A named list containing the names of the input variables of the numerical code. See Details for defaults.
  }
  
  
 }

\details{
  
  This function contains a wrapper for the optimumLHS function in package lhs.
  
  If \code{distrib} or members of it are missing, an error message is displayed. Distributions have to be chosen among uniform(\code{unif}), triangular(\code{triang}), normal(\code{norm}), truncated normal(\code{tnorm}), student(\code{t}), location-scale student(\code{t.scaled}).
  
  If \code{distrib.pars} is missing or misspecified, the standardized parameters of the associated distributions in \code{distrib} are used for all the variables in \code{x}:
  
  unif :    \code{min=0}, \code{max=1}
  
  triang : \code{min=0}, \code{max=1}, \code{mode=0.5}
  
  norm : \code{mean=0}, \code{sd=1}
  
  tnorm : \code{mean=0}, \code{sd=1}, \code{lower=0}, \code{upper=+Inf}
  
  t : \code{nu=100}
  
  t.scaled :  \code{nu=100}, \code{mean=0}, \code{sd=1}
  
  If \code{x} or members of it are missing, arbitrary names of the form 'Xn' are applied to the columns of the output table. Names are automatically abbreviated to 15 characters.
  
  
}
\value{
  
  \code{design.unif} A table containing the LHS design in the uniform space.
  
  \code{design.phys} A table containing the LHS design with margins in \code{distrib}.
}

\author{
  Severine Demeyer \email{severine.demeyer@lne.fr}
}

\examples{
\donttest{   
  N<- 100
  k<- 4
  x<- list("X1","X2","X3","X4")
  distrib<- list("norm","norm","unif","t.scaled")
  distrib.pars<- list(list(0,2),list(0,1),list(20,150),list(2,0,1))
  LHSdesign(N,k,distrib,distrib.pars,x)
  }
}

