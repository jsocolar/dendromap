% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assemble_lineage.R
\name{assemble_lineage}
\alias{assemble_lineage}
\title{Plot dendromap object}
\usage{
assemble_lineage(
  rc_tbl,
  rc_relations. = rc_relations,
  rc_table. = rc_table,
  row.tree. = row.tree,
  rowDescendants. = rowDescendants,
  colDescendants. = colDescendants
)
}
\arguments{
\item{rc_tbl}{see \code{\link{make_rc_table}}. Subset of \code{rc_table}}

\item{rc_relations}{see \code{\link{get_rc_relations}}}

\item{rc_table}{see \code{\link{make_rc_table}}}

\item{row.tree}{\code{phylo} class object}

\item{rowDescendants}{List of descendants made from \code{edge_registry}. Element \code{i} contains all edges descendant from edge \code{i} in the row tree}

\item{colDescendants}{List of descendants made from \code{edge_registry}. Element \code{j} contains all edges descendant from edge \code{j} in the column tree}
}
\description{
Plot dendromap object
}
