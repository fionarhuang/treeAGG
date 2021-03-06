% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runEdgeR.R
\name{runEdgeR}
\alias{runEdgeR}
\title{Test for differential abundance: method 'treeAGG-DA-edgeR'}
\usage{
runEdgeR(obj, design = NULL, contrast = NULL, normalize = TRUE,
  method = "TMM", adjust.method = "BH", prior.count = 0.125,
  use.assays = NULL)
}
\arguments{
\item{obj}{A treeSummarizedExperiment object.}

\item{design}{A numeric matrix. It must be of full column rank. Defaults to
use all columns of \code{colData} to create design matrix. Note: Users should
check whether the default created design matrix is exactly what they want or
create their own design matrix using \code{\link[stats]{model.matrix}}.}

\item{contrast}{numeric vector specifying one contrast of
the linear model coefficients to be tested equal to zero. Its length
must equal to the number of columns of design. If NULL, the last
coefficient will be tested equal to zero.}

\item{normalize}{A logical value, TRUE or FALSE. The default is TRUE.}

\item{method}{Normalization method to be used. See
\code{\link[edgeR]{calcNormFactors}} for more details.}

\item{adjust.method}{A character string stating the method used to adjust
p-values for multiple testing, passed on to \code{\link[stats]{p.adjust}}.
It could be "bonferroni", "holm", "hochberg", "hommel", "BH", or "BY".}

\item{prior.count}{average prior count to be added to observation to shrink
the estimated log-fold-changes towards zero. See \code{prior.count} in
\code{\link[edgeR]{glmFit}}}

\item{use.assays}{A numeric vector. It specifies which matrix-like elements
in assays will be used to do analysis.}
}
\value{
A treeSummarizedExperiment
\item{assays}{It stores a list of tables extracted from a \code{DGELRT}
object that is generated by \code{\link[edgeR]{glmLRT}}}
\item{rowData}{It stores the information of rows in \code{assays}}
\item{colData}{NULL}
\item{metadata}{
   \itemize{
   \item \code{assaysInput} the assays from the input data
   \item \code{use.assays} which elements in the \code{assaysInput} have been
   used to run differential abundance analysis.
   \item \code{design} the design matrix as input.
   \item \code{contrast} the contrast vector as input.
   \item \code{dgeGLM} the output from \code{\link[edgeR]{glmFit}}. A object
   of \code{\link[edgeR]{DGEGLM-class}}
   }
}
}
\description{
Test differential abundance of entities using functions from the
\code{\link{edgeR}} (Robinson et al. 2010, \emph{Bioinformatics}; McCarthy et
al. 2012, \emph{Nucleic Acids Research}) to fit models and calculate
moderated test for each entity. We have used
\code{\link[edgeR]{estimateGLMRobustDisp}} to estimate the dispersion. The
statistical methods implemented in the \code{edgeR} package were originally
designed for the analysis of gene expression data such as RNA-sequencing
counts. Here, we apply these methods to counts that might be from microbes or
cells.
}
\details{
The experimental design must be specified using a design matrix. The
customized design matrix could be given by \code{design}.

Normalization for samples is automatically performed by \code{edgeR} package.
More details about the calculation of normalization factor could be found
from \code{\link[edgeR]{calcNormFactors}}. A sample might include entities
corresponding to leaf nodes and internal nodes of tree. Only entities
corresponding to leaf nodes are used to calculate the library size of each
sample. The reason is that the abundance of an entity, corresponding to an
internal node, is calculated by taking sum of the abundance from its
descendant leaf nodes.
}
\examples{

library(S4Vectors)
set.seed(1)
y <- matrix(rnbinom(300,size=1,mu=10),nrow=10)
colnames(y) <- paste(rep(LETTERS[1:3], each = 10), rep(1:10,3), sep = "_")
rownames(y) <- tinyTree$tip.label

rowInf <- DataFrame(nodeLab = rownames(y),
                    var1 = sample(letters[1:3], 10, replace = TRUE),
                    var2 = sample(c(TRUE, FALSE), 10, replace = TRUE))
colInf <- DataFrame(gg = factor(sample(1:3, 30, replace = TRUE)),
                    group = rep(LETTERS[1:3], each = 10))
toy_lse <- leafSummarizedExperiment(tree = tinyTree, rowData = rowInf,
                                    colData = colInf,
                                    assays = list(y, (2*y), 3*y))

toy_tse <- nodeValue(data = toy_lse, fun = sum, tree = tinyTree,
message = TRUE)

# build the model
contrastList <- list(contrast1 = c(0, 0, 0, -1, 1),
                     contrast2 = c(0, -1, 1, 0, 0))
mod <- runEdgeR(obj = toy_tse, contrast = contrastList)
# results are stored as the column result_assay1, result_assay2, and
# result_assay3
(res <- rowData(mod, internal = TRUE))
# show results gained from the second element of the assasy
# sort by PValue
topNodes(mod, sort.by = "PValue", use.assays = 2)
}
