# https://github.com/WinVector/zmPDSwR/tree/master/Protein

protein <- read.table("https://raw.githubusercontent.com/trasapong/R/main/protein.txt", sep="\t", header=TRUE)
head(protein)
summary(protein)

vars.to.use <- colnames(protein)[-1]
vars.to.use
pmatrix <- scale(protein[,vars.to.use])
pmatrix
summary(pmatrix)
# keep some attr for later use
pcenter <- attr(pmatrix, "scaled:center")
pcenter
pscale <- attr(pmatrix, "scaled:scale")
pscale
d <- dist(pmatrix, method = "euclidean")
d
print(d,digits=2)
# note: name method name change
pfit <- hclust(d, method = "ward.D2")
pfit
plot(pfit, labels = protein$Country)
rect.hclust(pfit, k=5)
plot(pfit, labels = protein$Country)
rect.hclust(pfit, k=4)
plot(pfit, labels = protein$Country)
rect.hclust(pfit, k=3)
groups <- cutree(pfit, k=5)
groups
groups2 <- cutree(pfit, k=4)
groups2
print_clusters <- function(labels,k) {
  for(i in 1:k) {
    print(paste("cluster",i))
    print(protein[labels==i,c("Country","RedMeat","Fish","Fr.Veg")])
  }
} 
print_clusters(groups, 5)
library(ggplot2)
princ <- prcomp(pmatrix)
princ
summary(princ)
princ$x
first2 <- princ$x[,1:2]
first2
first2.plus <- cbind(as.data.frame(first2),
                  cluster=as.factor(groups),
                  country=protein$Country)
first2.plus
ggplot(first2.plus, aes(x=PC1,y=PC2)) +
  geom_point(aes(shape=cluster)) +
  geom_text(aes(label=country),
            hjust=0, vjust=1)

library(fpc)
kbest.p <- 5
cboot.hclust <- clusterboot(pmatrix,clustermethod = hclustCBI,
                            method = "ward.D2", k=kbest.p)
summary(cboot.hclust$result)
groups <- cboot.hclust$result$partition
print_clusters(groups, kbest.p)
cboot.hclust$bootmean
cboot.hclust$bootbrd
