library(gorica)

#Structural zeros example for local odds ratios (Online Supplementary material,
#section "Rewriting hypotheses based on eta-hat = 1 or eta is not estimable").
#The table below is an illustrative 2 x 4 table (the Supplementary material gives
#no data for this example) with two empty cells due to structural zeros: pi12 = pi23 = 0.

#Use set.seed(111) as the random number generator

set.seed(111)


#Displaying the data on R console

mydata <- as.table(matrix(c(12, 0, 9, 6,
                            7, 10, 0, 8), nrow = 2, ncol = 4, byrow = TRUE))

mydata


#Consider evaluating Hm: eta1 > eta2 > eta3 against the unconstrained hypothesis Hu, with the
#three local odds ratios
#eta = (eta1, eta2, eta3)^T = (pi11*pi22/(pi12*pi21), pi12*pi23/(pi13*pi22), pi13*pi24/(pi14*pi23))^T.
#Because pi12 and pi23 are estimated as zero, eta1 and eta3 are not estimable (zero in the
#denominator) and eta2 is estimated as zero. Therefore, the program stops and gives the error
#message: "Some of the defined parameters are invalid due to empty cell(s) in the table.
#Please rewrite the hypotheses." The call is wrapped in try() so that the script continues.

res <- try(gorica(mydata, hypothesis = "a:=(x[1,1]*x[2,2])/(x[1,2]*x[2,1]);
b:=(x[1,2]*x[2,3])/(x[1,3]*x[2,2]);
c:=(x[1,3]*x[2,4])/(x[1,4]*x[2,3]);
a > b & b > c"))


#After multiplying both sides of eta1 > eta2 and of eta2 > eta3 by their (positive)
#denominators, the hypothesis can be rewritten as Hm: eta1* > eta2*, eta3* > eta4* with
#eta* = (pi11*pi13*pi22^2, pi12^2*pi21*pi23, pi12*pi14*pi23^2, pi13^2*pi22*pi24)^T.
#Because of the two empty cells, eta2* and eta3* are estimated as zero. The gorica package
#then automatically rewrites the hypothesis as Hm: eta1* > 0, eta4* < 0 (displayed as
#"a>0&-d>0" in the output below), which does not require any further user intervention.
#Note that the order-restricted MLE of eta4* is zero, since all cell probabilities and,
#consequently, all eta*s are positive.

#Use set.seed(111) as the random number generator

set.seed(111)


#The values of the likelihood and penalty parts, GORICA values and GORICA weights

res <- gorica(mydata, hypothesis = "a:=x[1,1]*x[1,3]*x[2,2]*x[2,2];
b:=x[1,2]*x[1,2]*x[2,1]*x[2,3];
c:=x[1,2]*x[1,4]*x[2,3]*x[2,3];
d:=x[1,3]*x[1,3]*x[2,2]*x[2,4];
a > b & c > d")

res


#Displaying the estimates of eta*, their covariance matrix, and the order-restricted MLEs

res$estimates

res$Sigma

res$restricted_estimates


#Software environment used

sessionInfo()
