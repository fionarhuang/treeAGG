
# -----------------------------------------------------------------------------
### Documentation of the accessor function
### Function code is in the file allGenerics.R
# -----------------------------------------------------------------------------




# -----------------------------------------------------------------------------
### leafSummarizedExperiment
# -----------------------------------------------------------------------------

#' Accessor functions for leafSummarizedExperiment
#'
#' Accessor functions to extract different elements from
#' \strong{leafSummarizedExperiment} object.
#'
#' @param x A leafSummarizedExperiment object
#' @param ... For assay, ... may contain withDimnames, which is forwarded to
#'   assays. For rowData, arguments passed through ... are forwarded to mcols.
#'   For cbind, rbind, ... contains leafSummarizedExperiment objects to be
#'   combined. For other accessors, ignored.
#' @param withDimnames A logical(1), indicating whether dimnames should be
#'   applied to extracted assay elements. Setting withDimnames=FALSE increases
#'   the speed and memory efficiency with which assays are extracted.
#'   withDimnames=TRUE in the getter assays<- allows efficient complex
#'   assignments (e.g., updating names of assays, names(assays(x,
#'   withDimnames=FALSE)) = ... is more efficient than names(assays(x)) = ...);
#'   it does not influence actual assignment of dimnames to assays.
#' @param use.names Like \code{\link[S4Vectors]{mcols}(x)}, by default
#'   \code{rowData(x)} propagates the rownames of \code{x} to the returned
#'   \link[S4Vectors]{DataFrame} object (note that for a SummarizedExperiment
#'   object, the rownames are also the names i.e. \code{rownames(x)} is always
#'   the same as \code{names(x)}). Setting \code{use.names=FALSE} suppresses
#'   this propagation i.e. it returns a \link[S4Vectors]{DataFrame} object with
#'   no rownames. Use this when \code{rowData(x)} fails, which can happen when
#'   the rownames contain NAs (because the rownames of a SummarizedExperiment
#'   object can contain NAs, but the rownames of a \link[S4Vectors]{DataFrame}
#'   object cannot).
#' @param value	See the argument \code{value} in
#'   \code{\link[SummarizedExperiment]{SummarizedExperiment}} for more details.
#' @name leafSummarizedExperiment-accessor
#' @return Elements of \code{leafSummarizedExperiment}.
#' @author Ruizhu HUANG
#' @seealso \code{\link{treeSummarizedExperiment}}
#'   \code{\link{treeSummarizedExperiment-accessor}}
#'   \code{\link{leafSummarizedExperiment}}
#'   \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
#' @examples
#' library(S4Vectors)
#' set.seed(1)
#' y <- matrix(rnbinom(300,size=1,mu=10),nrow=10)
#' colnames(y) <- paste(rep(LETTERS[1:3], each = 10), rep(1:10,3), sep = "_")
#' rownames(y) <- tinyTree$tip.label
#'
#' rowInf <- DataFrame(nodeLab = rownames(y),
#'                     var1 = sample(letters[1:3], 10, replace = TRUE),
#'                     var2 = sample(c(TRUE, FALSE), 10, replace = TRUE))
#' colInf <- DataFrame(gg = factor(sample(1:3, 30, replace = TRUE)),
#'                     group = rep(LETTERS[1:3], each = 10))
#' toy_lse <- leafSummarizedExperiment(tree = tinyTree, rowData = rowInf,
#'                                     colData = colInf,
#'                                     assays = list(y, (2*y), 3*y))
#' rowData(toy_lse)
#' colData(toy_lse)
#' metadata(toy_lse)
#' assays(toy_lse)
NULL

# -----------------------------------------------------------------------------
### treeSummarizedExperiment
# -----------------------------------------------------------------------------
#' Accessor functions for treeSummarizedExperiment
#'
#' Accessor functions to extract different elements from
#' \strong{treeSummarizedExperiment} object.
#'
#' @param x A treeSummarizedExperiment object
#' @param ... For assay, ... contains \code{use.nodeLab}, which is forwarded to
#'   assays. For rowData, arguments passed through ... are forwarded to mcols.
#'   For cbind, rbind, ... contains leafSummarizedExperiment objects to be
#'   combined. For other accessors, ignored.
#' @param internal TRUE or FALSE. Only for \code{rowData}. If TRUE, the columns
#'   with \code{int_rowData} class are visible; otherwise, they would be hiden.
#'   These columns are usually result tables that users obtain from their
#'   customized analysis and  are written back to the
#'   \code{treeSummarizedExperiment} object that stores the original data.
#' @param use.nodeLab A logical(1), indicating whether the rownames of assay
#'   elements should use node labels (the column \code{nodeLab} in
#'   \code{linkData} if there is not duplicated values; otherwise the column
#'   \code{nodeLab_alias} in \code{linkData} is used.)
#' @param withDimnames A logical(1), indicating whether dimnames should be
#'   applied to extracted assay elements. Setting withDimnames=FALSE increases
#'   the speed and memory efficiency with which assays are extracted.
#'   withDimnames=TRUE in the getter assays<- allows efficient complex
#'   assignments (e.g., updating names of assays, names(assays(x,
#'   withDimnames=FALSE)) = ... is more efficient than names(assays(x)) = ...);
#'   it does not influence actual assignment of dimnames to assays.
#' @param use.names Like \code{\link[S4Vectors]{mcols}(x)}, by default
#'   \code{rowData(x)} propagates the rownames of \code{x} to the returned
#'   \link[S4Vectors]{DataFrame} object (note that for a SummarizedExperiment
#'   object, the rownames are also the names i.e. \code{rownames(x)} is always
#'   the same as \code{names(x)}). Setting \code{use.names=FALSE} suppresses
#'   this propagation i.e. it returns a \link[S4Vectors]{DataFrame} object with
#'   no rownames. Use this when \code{rowData(x)} fails, which can happen when
#'   the rownames contain NAs (because the rownames of a SummarizedExperiment
#'   object can contain NAs, but the rownames of a \link[S4Vectors]{DataFrame}
#'   object cannot).
#' @param value	See the argument \code{value} in
#'   \code{\link[SummarizedExperiment]{SummarizedExperiment}} for more details.
#' @param i,j The subscripts that can act to subset the rows and columns of
#'   \code{x}, that is the matrix elements of assays.
#' @name treeSummarizedExperiment-accessor
#' @return Elements from \code{treeSummarizedExperiment}.
#' @author Ruizhu HUANG
#' @seealso \code{\link{treeSummarizedExperiment}}
#'   \code{\link{treeSummarizedExperiment-accessor}}
#'   \code{\link{leafSummarizedExperiment}}
#'   \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
#' @examples
#' library(S4Vectors)
#' set.seed(1)
#' y <- matrix(rnbinom(300,size=1,mu=10),nrow=10)
#' colnames(y) <- paste(rep(LETTERS[1:3], each = 10), rep(1:10,3), sep = "_")
#' rownames(y) <- tinyTree$tip.label
#'
#' rowInf <- DataFrame(nodeLab = rownames(y),
#'                     var1 = sample(letters[1:3], 10, replace = TRUE),
#'                     var2 = sample(c(TRUE, FALSE), 10, replace = TRUE))
#' colInf <- DataFrame(gg = factor(sample(1:3, 30, replace = TRUE)),
#'                     group = rep(LETTERS[1:3], each = 10))
#' toy_tse <- treeSummarizedExperiment(tree = tinyTree, rowData = rowInf,
#'                                     colData = colInf,
#'                                     assays = list(y, (2*y), 3*y))
#' rowData(toy_tse)
#' colData(toy_tse)
#' metadata(toy_tse)
#' linkData(toy_tse)
#' assays(toy_tse)
NULL
