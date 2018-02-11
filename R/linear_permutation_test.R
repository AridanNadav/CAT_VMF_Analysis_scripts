fm01ML <- lmer(rt ~ PairType + (1|sub), data=(CurrentData[CurrentData$sample__1isControl_2isPatients==1,]), na.action=na.omit, REML = FALSE)
## see ?"profile-methods"
mySumm <- function(.) { s <- sigma(.)
c(beta =getME(., "beta"), sigma = s, sig01 = unname(s * getME(., "theta"))) }
(t0 <- mySumm(fm01ML)) # just three parameters
## alternatively:
mySumm2 <- function(.) {
  c(beta=fixef(.),sigma=sigma(.), sig01=sqrt(unlist(VarCorr(.))))
}
set.seed(101)
## 3.8s (on a 5600 MIPS 64bit fast(year 2009) desktop "AMD Phenom(tm) II X4 925"):
system.time( boo01 <- bootMer(fm01ML, mySumm, nsim = 100) )
## to "look" at it
if (requireNamespace("boot")) {
  boo01
  ## note large estimated bias for sig01
  ## (~30% low, decreases _slightly_ for nsim = 1000)
  ## extract the bootstrapped values as a data frame ...
  head(as.data.frame(boo01))
  ## ------ Bootstrap-based confidence intervals ------------
  ## warnings about "Some ... intervals may be unstable" go away
  ## for larger bootstrap samples, e.g. nsim=500
  ## intercept
  (bCI.1 <- boot::boot.ci(boo01, index=1, type=c("norm", "basic", "perc")))# beta
  ## Residual standard deviation - original scale:
  (bCI.2 <- boot::boot.ci(boo01, index=2, type=c("norm", "basic", "perc")))
  ## Residual SD - transform to log scale:
  (bCI.2L <- boot::boot.ci(boo01, index=2, type=c("norm", "basic", "perc"),
                           h = log, hdot = function(.) 1/., hinv = exp))
  ## Among-batch variance:
  (bCI.3 <- boot::boot.ci(boo01, index=3, type=c("norm", "basic", "perc"))) # sig01
  ## Copy of unexported stats:::format.perc helper function
  format.perc <- function(probs, digits) {
    paste(format(100 * probs, trim = TRUE,
                 scientific = FALSE, digits = digits),
          "%")
  }
  ## Extract all CIs (somewhat awkward)
  bCI.tab <- function(b,ind=length(b$t0), type="perc", conf=0.95) {
    btab0 <- t(sapply(as.list(seq(ind)),function(i)
      boot::boot.ci(b,index=i,conf=conf, type=type)$percent))
    btab <- btab0[,4:5]
    rownames(btab) <- names(b$t0)
    a <- (1 - conf)/2
    a <- c(a, 1 - a)
    pct <- format.perc(a, 3)
    colnames(btab) <- pct
    return(btab)
  }
  bCI.tab(boo01)
  ## Graphical examination:
  plot(boo01,index=3)
  ## Check stored values from a longer (1000-replicate) run:
  (load(system.file("testdata","boo01L.RData", package="lme4")))# "boo01L"
  plot(boo01L, index=3)
  mean(boo01L$t[,"sig01"]==0) ## note point mass at zero!
} ## if boot package available
