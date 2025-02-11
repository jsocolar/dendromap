% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_lineages_and_stats.R
\name{get_lineages_and_stats}
\alias{get_lineages_and_stats}
\title{Get lineages with all lineage F-statistics}
\usage{
get_lineages_and_stats(
  p_thresh,
  rc_table,
  rc_relations,
  rowDescendants,
  colEdgeTips,
  rowEdgeTips,
  cl = NULL
)
}
\arguments{
\item{p_thresh}{Positive numeric, threshold P-value for inclusion of rc-pairs}

\item{rc_table}{see \code{\link{make_rc_table}}}

\item{rc_relations}{see \code{\link{get_rc_relations}}}

\item{rowDescendants}{List of descendants made from \code{edge_registry}. Element \code{i} contains all edges descendant from edge \code{i} in the row tree}

\item{colEdgeTips}{\code{\link{edge_tips}} for col.tree}

\item{rowEdgeTips}{\code{\link{edge_tips}} for row.tree}

\item{cl}{cluster initialized internally with \code{\link{dendromap}}}

\item{colDescendants}{List of descendants made from \code{edge_registry}. Element \code{j} contains all edges descendant from edge \code{j} in the column tree}
}
\description{
Get lineages with all lineage F-statistics
}
