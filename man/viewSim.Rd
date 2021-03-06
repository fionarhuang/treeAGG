% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/viewSim.R
\name{viewSim}
\alias{viewSim}
\title{visualize simulated scenario}
\usage{
viewSim(obj, layout = "rectangular", zoomScale = 1/20,
  legend.theme = list(legend.position = c(0.15, 0.6)),
  tip.label = FALSE, legend.title = "Abundance")
}
\arguments{
\item{obj}{The output from \code{simData}}

\item{layout}{The tree layout. Select one from 'rectangular', 'slanted',
'fan', 'circular', 'radial', 'equal_angle' and 'daylight'. The default is
"rectangular".}

\item{zoomScale}{A positive numeric value. If it is above one, branches with
fold change equal to one (non-signal branch) will be zoomed in; If below
one, they will be shrinked. Default is 0.05}

\item{legend.theme}{A list of arguments used for the theme in ggplot2
package (see \code{\link[ggplot2]{theme}} ) and starting with "legend."}

\item{tip.label}{TRUE or FALSE. Default is FALSE. If TRUE, the leaves with
fold change above or below 1 will be labelled.}

\item{legend.title}{The title of the legend. The default is "Abundance"}
}
\value{
a figure
}
\description{
\code{viewSim} is to visualize the output from the function \code{simData}.
}
\examples{
set.seed(1)
y <- matrix(rnbinom(100,size=1,mu=10),nrow=10)
colnames(y) <- paste("S", 1:10, sep = "")
rownames(y) <- tinyTree$tip.label


toy_lse <- leafSummarizedExperiment(tree = tinyTree,
                                    assays = list(y))
res <- parEstimate(data = toy_lse)

set.seed(1122)
dat1 <- simData(obj = res)
viewSim(obj = dat1 )

}
