#' Transfer between node number and node label
#'
#' \code{transNode} does the transformation between the number and the label of
#' a node on a tree
#'
#' @param tree A phylo object
#' @param input A character or numeric vector representing tree node label(s) or
#'   tree node number(s)
#' @param use.alias A logical value, TRUE or FALSE. This is an optional argument
#'   that only requried when \code{return = "label"}. The default is FALSE, and
#'   the node label would be returned; otherwise, the alias of node label would
#'   be output. The alias of node label is created by adding a prefix
#'   \code{"Node_"} to the node number if the node is an internal node or adding
#'   a prefix \code{"Leaf_"} if the node is a leaf node.
#' @param message A logical value, TRUE or FALSE. The default is FALSE. If TRUE,
#'   message will show when a tree have duplicated labels for some internal
#'   nodes.
#'
#' @export
#' @return a vector
#' @author Ruizhu Huang
#'
#' @examples
#' library(ggtree)
#'
#' data(tinyTree)
#'
#' ggtree(tinyTree, branch.length = 'none') +
#' geom_text2(aes(label = label), hjust = -0.3) +
#' geom_text2(aes(label = node), vjust = -0.8,
#' hjust = -0.3, color = 'blue')
#'
#' #check whether the node number and node label are matched
#' transNode(tinyTree, input = c(11, 2, 4, 15))
#'
#' transNode(tree = tinyTree, input = c("Node_16", "Node_11"))
#'

transNode <- function(tree, input, use.alias = FALSE,
                      message = FALSE) {

    if (!inherits(tree, "phylo")) {
        stop("tree: should be a phylo object. \n")
    }

    # node number & tip number
    mat <- tree$edge
    nodI <- sort(unique(mat[, 1]))
    tip <- sort(setdiff(mat[, 2], mat[, 1]))
    nodeA <- c(tip, nodI)

    # if node labels are given, check whether the length could match with the
    # length of internal nodes.
    if (!is.null(tree$node.label)) {
        if (length(tree$node.label) != length(nodI)) {
            stop("The length of internal node label isn't equal to
                 the length of the internal nodes. \n")
        }
    }

    # node labels
    nodeLab <- c(tree$tip.label, tree$node.label)
    nodeLab_alias <- c(paste("Leaf_", tip, sep = ""),
                       paste("Node_", nodI, sep = ""))
    if (message) {
        if (any(duplicated(nodeLab))) {
            cat("There are more than one nodes using a same label or
                without any label.\n")
        }
    }

    # check whether the input node number exists in the provided tree
    if (is.numeric(input)) {
        if (!all(input %in% nodeA)) {
            stop("The node number ", input[!input %in% nodeA],
                 " can't be found in the ",
                 deparse(substitute(tree)), "\n")
        }
    }
    # check whether the input label exists in the provided tree
    # (allow nodeLab_alias)
    inLab <- all(input %in% nodeLab)
    inAlias <- all(input %in% nodeLab_alias)
    if (is.character(input)) {
        if (!any(inLab, inAlias)) {
            cat(setdiff(input, nodeLab),
                " can't be matched to any node label of the tree. \n")
            stop("Either the node label or the alias of node label should be
                 provided, but not a mixture of them. \n")

        }
    }

    # =============== Transformation ======================
    # transfer from the label to the number
    if (is.character(input)) {
        if (inLab) {
            names(nodeA) <- nodeLab
            final <- nodeA[input]
        } else {
            names(nodeA) <- nodeLab_alias
            final <- nodeA[input]
        }
    }

    # transfer from the number to the label
    if (is.numeric(input)) {
        if (use.alias) {
            sel <- match(input, nodeA)
            final <- nodeLab_alias[sel]
        } else {
            sel <- match(input, nodeA)
            final <- nodeLab[sel]
        }

    }

    # output
    return(final)

}

# transNode <- function(tree, input, use.original = TRUE, message = FALSE) {
#
#     if (!inherits(tree, "phylo")) {
#         stop("tree: should be a phylo object")
#     }
#
#     # node number & tip number
#     mat <- tree$edge
#     nod <- sort(unique(mat[, 1]))
#     tip <- sort(setdiff(mat[, 2], mat[, 1]))
#
#     # check whether the input node number exists in the provided tree
#     if (is.numeric(input)) {
#         if (!all(input %in% mat)) {
#             stop("Node number", input, " can't be found in the ",
#                  deparse(substitute(tree)), "\n")
#         }
#     }
#
#     # tip label
#     if (is.null(tree$tip.label)) {
#         if(use.original) {
#             tipLab <- NULL
#         }else{
#             tipLab <- paste("leaf_", tip, sep = "")
#         }
#
#     } else {
#         tipLab <- tree$tip.label
#     }
#     # node label
#     if (is.null(tree$node.label)) {
#         if (use.original) {
#             nodLab <- NULL
#         }else{
#             nodLab <- paste("Node_", nod, sep = "")
#         }
#
#     } else {
#         Labs <- tree$node.label
#         if (any(duplicated(Labs))){
#             if (message) {
#                 cat("Some internal nodes have same labels")
#             }
#             nodLab <- paste("Node_", nod, sep = "")
#         }else{
#             nodLab <- Labs
#         }
#     }
#
#     comb <- c(tip, nod)
#     names(comb) <- c(tipLab, nodLab)
#
#     # transfer from label to number
#     if (inherits(input, "character")) {
#         if (all(input %in% names(comb))) {
#             final <- comb[input]
#         } else {
#             stop("The nodes ", paste(input[!input %in% names(comb)],
#                   collapse = ", "),
#                  " could not be found in the tree. \n
#                    Node numbers or Node labels are
#            required but not a mixture of both")
#         }
#
#     } else {
#         final <- names(comb[match(input, comb)])
#     }
#
#     return(final)
#
# }


