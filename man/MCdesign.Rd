\name{MCdesign}
\alias{MCdesign}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Monte Carlo sampling for metrology applications
}
\description{
  Creates Monte Carlo sampling designs for metrology applications
}
\usage{
  MCdesign(N,k,distrib,distrib.pars,x)
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
  
  This function creates a sampling design based on a Monte Carlo simulation.
  
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
  A table containing the MC design with margins in \code{distrib}.
}

\author{
  Severine Demeyer \email{severine.demeyer@lne.fr}
}

\examples{
  
  N<- 100
  k<- 4
  x<- list("X1","X2","X3","X4")
  distrib<- list("norm","norm","unif","t.scaled")
  distrib.pars<- list(list(0,2),list(0,1),list(20,150),list(2,0,1))
  MCdesign(N,k,distrib,distrib.pars,x)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
