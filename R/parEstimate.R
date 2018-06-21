#' estimate parameters for dirichlet distribution
#'
#' \code{parEstimate} is to estimate parameters for dirichlet distribution from a real data (count table).
#'
#' @param data a count table. Samples in the column and entities in the row.
#' @importFrom dirmult dirmult
#' @export
#' @details use the default setting from \code{dirmult} (see \code{\link[dirmult]{dirmult}})
#' @return a list including \dQuote{pi} and \dQuote{theta}

parEstimate <- function(data){

  if(inherits(data, "list")){
    ind <- setequal(names(data), c("pi", "theta"))
    if(!ind){
      stop("Error: data is a list;
           it should provide pi and theta")
    }
    parList <- data
    }else{

      DirMultOutput<- dirmult::dirmult(data = t(data))
      # tip proportion
      estP<-DirMultOutput$pi
      names(estP) <- names(DirMultOutput$pi)

      # parameter alpha for dirichlet distribution
      theta <- DirMultOutput$theta
      parList <-  list(pi = estP, theta = theta)
    }

  return(parList)
}