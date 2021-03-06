% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/allClass.R
\docType{class}
\name{treeSummarizedExperiment-class}
\alias{treeSummarizedExperiment-class}
\title{An S4 class treeSummarizedExperiment}
\description{
The class \strong{treeSummarizedExperiment} is an extension class of standard
\code{\link[SummarizedExperiment]{SummarizedExperiment}} class. It has six
slots. Four of them are traditional slots from
\code{\link[SummarizedExperiment]{SummarizedExperiment}} class:
\code{assays}, \code{rowData} \code{colData} and \code{metadata}. The other
two slots are \code{linkData} and \code{treeData}. The class
\strong{treeSummarizedExperiment} is designed to store rectangular data for
entities (e.g., microbes or cell types) (\code{assays}), information about
the hiearchical structure of entities (\code{treeData}), and information
about the mapping between the rows of the rectangular data and the nodes of
the tree (\code{linkData}).
}
\section{Slots}{

\describe{
\item{\code{linkData}}{A \code{\link[S4Vectors]{DataFrame}} object. It gives map
information between the rows of rectangular data and the nodes of tree.
\itemize{
\item \strong{nodeLab} The node labels on the tree.
\item \strong{nodeLab_alias} An alias of column \code{nodeLab}. It is
created only when there are missing value or duplicated value in column
\code{nodeLab}. A prefix "Node_" and "Leaf_" is added to the node number
(column \code{nodeNum}) for the internal nodes and the leaf nodes,
respectively.
\item \strong{nodeNum} The node numbers on the tree.
\item \strong{isLeaf} This indicates whether a node is a leaf node.
\item \strong{rowID} The row number in \code{assays}.
}}

\item{\code{treeData}}{A phylo object. It gives information about the hiearchical
structure of the entities.}

\item{\code{...}}{See \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
for more details about the slots inherited from \code{SummarizedExperiment}
class.}
}}

\section{Constructor}{

See \code{\link{treeSummarizedExperiment-constructor}} for constructor
functions.
}

\section{Accessor}{

See \code{\link{treeSummarizedExperiment-accessor}} for accessor functions.
}

\seealso{
\code{\link{treeSummarizedExperiment}}
  \code{\link{treeSummarizedExperiment-accessor}}
  \code{\link{leafSummarizedExperiment}}
  \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
}
