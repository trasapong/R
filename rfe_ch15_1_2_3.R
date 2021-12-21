# R for Everyone, ch 15, Basic Statistics

#15.1 Summary Statistics
x <- sample(x = 1:100, size=100, replace = TRUE)
x
mean(x)
y <- x
a <- sample(x = 1:100, size=20, replace = FALSE)
y[a]
y[sample(x = 1:100, size=20, replace = FALSE)] <- NA
y
mean(y)
mean(y, na.rm = TRUE)

grades <- c(95,72,87,66)
weights <- c(1/2,1/4,1/8,1/8)
mean(grades)
weighted.mean(x=grades, w=weights)

var(x)
sum((x-mean(x))^2)/(length(x)-1)
sqrt(var(x))
sd(x)
sd(y)
sd(y,na.rm=TRUE)
min(x)
max(x)
median(x)
min(y)
min(y,na.rm=TRUE)
summary(x)
summary(y)

#quantile
quantile(x,probs=c(0.25,0.75))
quantile(y,probs=c(0.25,0.75))      # Error
quantile(y,probs=c(0.25,0.75), na.rm=TRUE)
quantile(x,probs=c(0.1,0.25,0.5,0.75,0.99))

#15.2 Correlation and Covariance
require(ggplot2)
head(economics)
?economics
cor(economics$pce, economics$psavert)
(xPart <- economics$pce - mean(economics$pce))
(yPart <- economics$psavert - mean(economics$psavert))
(nMinusOne <- (nrow(economics) - 1))
(xSD <- sd(economics$pce))
(ySD <- sd(economics$psavert))
(sum(xPart * yPart)/(nMinusOne * xSD * ySD))
cor(economics[,c(2,4:6)])     # only col 2,4-6
GGally::ggpairs(economics[,c(2,4:6)])

require(reshape2)
require(scales) #for some extra plotting features
econCor <- cor(economics[,c(2,4:6)])
econCor
econMelt <- melt(econCor, varnames = c("x","y"),
                 value.name = "Correlation")
econMelt
econMelt <- econMelt[order(econMelt$Correlation),]
econMelt
ggplot(econMelt, aes(x=x,y=y)) +
  geom_tile(aes(fill=Correlation)) +
  scale_fill_gradient2(low=muted("red"), mid ="white",
                       high="steelblue",
                       guide=guide_colorbar(ticks = FALSE, barheight = 10),
                       limits = c(-1,1)) +
  theme_minimal() +
  labs(x=NULL,y=NULL)

# how to handle missing values
m <- c(9, 9, NA, 3, NA, 5, 8, 1, 10, 4)
n <- c(2, NA, 1, 6, 6, 4, 1, 1, 6, 7)
p <- c(8, 4, 3, 9, 10, NA, 3, NA, 9, 9)
q <- c(10, 10, 7, 8, 4, 2, 8, 5, 5, 2)
r <- c(1, 9, 7, 6, 5, 6, 2, 7, 9, 10)
(theMat <- cbind(m,n,p,q,r))
?cor   # see 'use' option
cor(theMat)
cor(theMat, use = "everything")
cor(theMat, use = "all.obs")

# 'complete.obs'& 'na.or.complete' are the same, 
# except if no complete case 'complete' gives error
# 'na.or.complete' gives NA
cor(theMat, use = "complete.obs")
cor(theMat, use = "na.or.complete")
cor(theMat[c(1,4,7,9,10),])
identical(cor(theMat, use = "complete.obs"),
          cor(theMat[c(1,4,7,9,10),]))
cor(theMat, use = "pairwise.complete.obs")
cor(theMat[,c("m","n")], use = "complete.obs")
cor(theMat[,c("m","p")], use = "complete.obs")

data(tips, package = "reshape2")
head(tips)
GGally::ggpairs(tips)

require(RXKCD)
getXKCD(which="552")

#covariance
cov(economics$pce, economics$psavert)
cov(economics[,c(2, 4:6)])
cov(economics$pce, economics$psavert)/(sd(economics$pce)*sd(economics$psavert))
cor(economics$pce, economics$psavert)

#15.3 T-Tests
head(tips)
unique(tips$sex)
unique(tips$day)

#15.3.1 one-sample T-test
t.test(tips$tip, alternative = "two.sided", mu = 2.5)

randT <- rt(30000, df = nrow(tips)-1)
randT
tipTTest <- t.test(tips$tip, alternative = "two.sided", mu = 2.5)
tipTTest
tipTTest$statistic
ggplot(data.frame(x=randT)) +
  geom_density(aes(x=x), fill="grey",color="grey") +
  geom_vline(xintercept = tipTTest$statistic) +
  geom_vline(xintercept = mean(randT) + c(-2,2)*sd(randT), linetype=2)

aggregate(tip~sex, data = tips, var)
#test for normality
shapiro.test(tips$tip)
shapiro.test(tips$tip[tips$sex=="Female"])
shapiro.test(tips$tip[tips$sex=="Male"])
ggplot(tips, aes(x=tip,fill=sex)) +
  geom_histogram(binwidth = .5, alpha=1/2)
#since not normal data, use nonpara Ansari-Bradley test to examine variance equality
ansari.test(tip~sex, tips)
t.test(tip~ sex, data=tips, var.equal = TRUE)
require(plyr)
tipSummary <- ddply(tips, "sex", summarize,
                    tip.mean=mean(tip), tip.sd=sd(tip),
                    Lower=tip.mean-2*tip.sd/sqrt(NROW(tip)),
                    Upper=tip.mean+2*tip.sd/sqrt(NROW(tip)))
tipSummary
ggplot(tipSummary, aes(x=tip.mean, y=sex)) + geom_point() +
  geom_errorbarh(aes(xmin=Lower, xmax=Upper), height=0.2)

#15.3.3 Paired Two-Sample T-Test
require(UsingR)
head(father.son)
t.test(father.son$fheight, father.son$sheight, paired =  TRUE)
heightDiff <- father.son$fheight - father.son$sheight
ggplot(father.son, aes(x=fheight - sheight)) +
  geom_density() +
  geom_vline(xintercept = mean(heightDiff)) +
  geom_vline(xintercept = mean(heightDiff) +
               2 * c(-1,1) * sd(heightDiff)/sqrt(nrow(father.son)),
             linetype = 2)
############################ EOF #####################################
