#' Manifest children for row tree, sensitive to depth of col.nodes
#' 
#' @export
#' @param node row tree node whose children need to be found
#' @param row.tree \code{phylo} class object
#' @param row.nb \code{\link{nodeBank}} for \code{row.tree}
#' @param col.nb \code{\link{nodeBank}} for \code{col.tree}
#' @param col.nodes nodes from column tree
#' @param decay.rate exponential rate of decay for past nodes. Probability of draw will be exp(-decay.rate*dT) where dT is the time from column node to row node. Only implemented if \code{use.depths=TRUE}
#' @param use.depths logical - whether or not to use depth-based filtering through propensities in \code{col.nb}
manifestRowChildren <- function(node,row.tree,row.nb,col.nb,col.nodes,decay.rate=0,use.depths=F){
  if (use.depths){
    colnds <- c(col.nodes,unlist(phangorn::Descendants(col.tree,col.nodes,'all')))
    colnds <- colnds[colnds>ape::Ntip(col.tree)]
    col.depths <- col.nb[node%in%colnds,c('node','depth','propensity')]
    NB <- row.nb[depth>=min(col.depths)]
    
    if (nrow(NB)==0){
      MAP <- NULL
    } else {
      if (node %in% NB$node){
        m <- node
      } else {
        snb <- row.nb
        snb[,manifest:=FALSE]
        snb[node %in% NB$node,manifest:=TRUE]
        m <- manifestChildren(node,row.tree,snb)
      }
      MAP <- NULL
      while (length(m)>0){
        
        map <- depthDraw(NB[match(m,node),depth],col.depths$depth,col.depths$propensity,decay.rate)
        map[,row.node:=m[row]]
        m <- map[col==0,row.node]
        map <- map[col>0]
        map[,col.node:=col.depths$node[col]]
        map[,orientation:=sign(rnorm(.N))]
        map[,terminated:=row.node %in% row.nb[terminal==T,node] | 
                         col.node %in% col.nb[terminal==T,node]]
        MAP <- rbind(MAP,map[,c('row.node','col.node','orientation','terminated')])
        if (length(m)>0){
          ch <- sapply(m,labelledChildren,row.tree)
          m <- c(ch)
          m <- m[m>ape::Ntip(row.tree)]
        }
      }
    }
  } else {
    
    MAP <- data.table('row.node'=manifestChildren(nd = node,tree=row.tree,nodebank=row.nb))
    if (length(col.nodes)>1){
      MAP[,col.node:=sample(col.nodes,nrow(MAP),T,prob=col.nb[match(col.nodes,node),propensity])]
    } else {
      MAP[,col.node:=col.nodes]
    }
    MAP[,orientation:=sign(rnorm(.N))]
    MAP[,terminated:=row.node %in% row.nb[terminal==T,node] | 
          col.node %in% col.nb[terminal==T,node]]
  }
  return(MAP)
}
