% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/treeAGG.R
\docType{methods}
\name{treeAGG}
\alias{treeAGG}
\alias{treeAGG,treeSummarizedExperiment-method}
\alias{treeAGG,data.frame-method}
\alias{treeAGG,DataFrame-method}
\title{Tree aggregation}
\usage{
treeAGG(data, sigf.by = "FDR", sigf.limit = 0.05, agg.by = "FDR",
  tree, message = FALSE)

\S4method{treeAGG}{treeSummarizedExperiment}(data, sigf.by, sigf.limit,
  agg.by, message)

\S4method{treeAGG}{data.frame}(data, sigf.by = "FDR",
  sigf.limit = 0.05, agg.by = "FDR", tree, message = FALSE)

\S4method{treeAGG}{DataFrame}(data, sigf.by = "FDR", sigf.limit = 0.05,
  agg.by = "FDR", tree, message = FALSE)
}
\arguments{
\item{data}{A data frame or a treeSummarizedExperiment.
\itemize{
If a data frame, it should include at least:
\item a column of node labels
     (use labels from this column to map each row to a node of tree.)
\item a column for tree aggregation
     (use value from this column to decide whether to aggregate.)
\item a column of adjusted p value
     (use value from this column to decide whether to reject a null
     hypothesis.)
}}

\item{sigf.by}{A column name. The column contains the p value or adjusted
p value.}

\item{sigf.limit}{A numeric value. The threshold value (for p value or
adjusted p value) to reject a null hypothesis. The chosen value depends on
the \code{sigf.by}.}

\item{agg.by}{A column name. The column used to do tree aggregation.
Commonly, it is the column including p value or adjusted p value.}

\item{tree}{A phylo object. A optional argument. Only use when \code{data}
is a data frame.}

\item{message}{A logical value. The default is TRUE. If TRUE, it will print
out the currenet status of a process.}
}
\value{
A data frame
}
\description{
\code{treeAGG} combines the p values with the tree structure and decide the
which nodes to be aggregated to based on the min-p algorithm.
}
\examples{

# We recommend to use treeAGG as example 2. It works in the case of example
# 1.However, it is difficult to rownames a data frame when some internal
# nodesof the tree doesn't have labels. Furthermore, it could do tree agg
# Example 1
library(ggtree)
data(tinyTree)

# data
set.seed(3)
pv <- runif(19)
pValue <- rank(pv)/length(pv)*pv
treeLab <- c(tinyTree$tip.label, tinyTree$node.label)
df <- cbind.data.frame(pV = pValue,
stringsAsFactors = FALSE)
rownames(df) <- treeLab



# tree aggregation
(tt <- treeAGG(tree = tinyTree, data = df, sigf.limit = 0.05,
sigf.by = "pV", agg.by = "pV"))

# display the tree structure and p value at each node
tt$node <- transNode(tree = tinyTree, input = rownames(tt),
                     message = FALSE)

# p value at each node is given as blue number in tree
# the selected nodes after aggregation is labelled with orange points
# these selected nodes have lower p-value than its descendant nodes if they
# have descendant nodes.
ggtree(tinyTree) \%<+\% tt + geom_text2(aes(label = label), hjust = -0.2) +
geom_text2(aes(label = round(pv, 3)), vjust = -0.5, color = "blue",
 hjust = -0.15) +
geom_point2(aes(subset = aggKeep), color = "orange", size = 2)


# Example 2
set.seed(1)
y <- matrix(rnbinom(300,size=1,mu=10),nrow=10)
colnames(y) <- paste(rep(LETTERS[1:3], each = 10), rep(1:10,3), sep = "_")
rownames(y) <- tinyTree$tip.label

rowInf <- data.frame(nodeLab = rownames(y),
                    var1 = sample(letters[1:3], 10, replace = TRUE),
                    var2 = sample(c(TRUE, FALSE), 10, replace = TRUE),
                    stringsAsFactors = FALSE)
colInf <- data.frame(gg = factor(sample(1:3, 30, replace = TRUE)),
                    group = rep(LETTERS[1:3], each = 10))
toy_lse <- leafSummarizedExperiment(tree = tinyTree,
                                    assays = list(y, (2*y), 3*y),
                                    rowData = rowInf,
                                    colData = colInf)

toy_tse <- nodeValue(data = toy_lse, fun = sum, message = TRUE)

new_tse <- runEdgeR(obj = toy_tse, use.assays = 1, design = NULL,
                    contrast = NULL, normalize = TRUE, method = "TMM",
                    adjust.method = "BH")
# option 1: provide treeSummarizedExperiment
outR1 <- treeAGG(data = new_tse)

 # or we could extract the result and the tree structure to do aggregation
 (res <- rowData(new_tse)$result_assay1$contrastNULL)
 rownames(res) <- linkData(new_tse)$nodeLab
 (Tree <- treeData(new_tse))

 # option2: provide data frame and tree structure
outR2 <- treeAGG(data = res, tree = Tree)




}
\author{
Ruizhu Huang
}
