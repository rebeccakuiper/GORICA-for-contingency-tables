library(gorica)

#Use set.seed(111) as the random number generator

set.seed(111)


#Displaying the data on R console

mydata <- as.table(matrix(c(7, 0, 6, 3, 2, 3), nrow = 2,
                          ncol = 3, byrow = TRUE))

mydata


#Consider evaluating Hm: eta1 > eta2 > eta3 against the unconstrained hypothesis Hu: eta1, eta2, eta3
#with eta = (eta1, eta2, eta3)^T = (pi11/(pi11+pi21), pi12/(pi12+pi22), pi13/(pi13+pi23))^T.
#Notably, the second conditional cell probability eta2 is estimated as zero. Therefore, the covariance
#matrix of the estimates for etas is not positive definite. Nevertheless, evaluating hypotheses containing 
#non-linear restrictions on cell probabilities, when some of the etas are estimated as zero because of 
#empty cells due to structural zeros is automated in the gorica package.


#The values of the likelihood and penalty parts, GORICA values
#and GORICA weights

res <- gorica(mydata, hypothesis = "a:=x[1,1]/(x[1,1]+x[2,1]);
b:=x[1,2]/(x[1,2]+x[2,2]);c:=x[1,3]/(x[1,3]+x[2,3]);
a > b & b > c")

res


#Sometimes some of the etas are estimated as one or cannot be estimated because of empty cells. For the first
#situation, consider comparison of hypothesis Hm: eta1 > eta2 against the unconstrained hypothesis
#Hu: eta1, eta2 with eta = (eta1, eta2)^T = (pi11/(pi11+pi21),pi12/(pi12+pi22))^T and pi22 is estimated
#as zero because of a structural zero:

#Use set.seed(111) as the random number generator
#to duplicate our results in the Supplementary material

set.seed(111)

#Displaying the data on R console

mydata <- as.table(matrix(c(7, 5, 8, 0), nrow = 2,
                          ncol = 2, byrow = TRUE))

mydata


#Since pi22 is estimated as zero, eta2 is estimated as one, which has no variation. Therefore, the program
#stops and gives the error message: "Some of the defined parameters are invalid due to empty cell(s) in the
#table. Please write the hypotheses."

#The values of the likelihood and penalty parts, GORICA values
#and GORICA weights

res <- gorica(mydata, hypothesis = "a:=x[1,1]/(x[1,1]+x[2,1]);
b:=x[1,2]/(x[1,2]+x[2,2]);
a > b")

res


#Therefore, hypothesis Hm: eta1 > eta2 has to be rewritten as Hm: eta1 > 1. The values of log likelihood
#and penalty parts, GORICA values and GORICA weights are obtained as follows:

#Use set.seed(111) as the random number generator
#to duplicate our results in the supplementary material

set.seed(111)

#The values of the likelihood and penalty parts, GORICA values and GORICA weights
res <- gorica(mydata, hypothesis = "a:=x[1,1]/(x[1,1]+x[2,1]); a > 1")

res 


#For the second situation, consider the comparison of hypothesis Hm: eta1 > 1 against the unconstrained
#hypothesis Hu: eta1 with eta1 = (pi11*pi22)/(pi12*pi21) and pi12 is estimated as zero because of an empty cell 


#Use set.seed(111) as the random number generator
#to duplicate our results in the supplementary material

set.seed(111)


#Displaying the data on R console

mydata <- as.table(matrix(c(5, 0, 15, 7, 3, 8, 0, 6),
                          nrow = 2, ncol = 4, byrow = TRUE))

mydata

#Since pi12 is estimated as zero, the parameter eta1 is not estimable as it has zero in the denominator.
#Therefore, the program stops and gives the error message: "Some of the defined parameters are invalid
#due to empty cell(s) in the table. Please rewrite the hypotheses."

#The values of the likelihood and penalty parts, GORICA values and GORICA weights

res <- gorica(mydata, hypothesis = "a:=(x[1,1]*x[2,2])/(x[1,1]*x[2,1]);
a > 1")

res


#After rewriting hypothesis as Hm: pi11*pi22-pi12*pi21 > 0, the values of log likelihood and penalty parts,
#GORICA values and GORICA weights are obtained as follows:

#Use set.seed(111) as the random number generator
#to duplicate our results in the Supplementary material

set.seed(111)


#The values of the likelihood and penalty parts, GORICA values and GORICA weights

res <- gorica(mydata, hypothesis = "a:=x[1,1]*x[2,2]-x[1,2]*x[2,1];
a > 0")

res















