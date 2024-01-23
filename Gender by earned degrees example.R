

#Use set.seed(111) as the random number generator to duplicate the results
#in Table 9 (in the main text)

library(gorica)
set.seed(111)

#Displaying the data on R console

mydata <- as.table(matrix(c(933, 402, 51, 26, 661, 260, 44, 26),
                          nrow = 2, ncol = 4, byrow = TRUE))

mydata


#The values of the likelihood and penalty parts, GORICA values and
#GORICA weights for the gender by earned degrees example

res <- gorica(mydata, hypothesis = "a:=x[2,1]/(x[1,1]+x[2,1]);
b:=x[2,2]/(x[1,2]+x[2,2]); c:=x[2,3]/(x[1,3]+x[2,3]);
d:=x[2,4]/(x[1,4]+x[2,4]);
a > (b,c,d); a = b & c > d;a >b & b > c & c > d")

res


res$relative_weights


#Displaying the estimates of conditional cell probabilities and their covariance matrix

res$estimates

res$Sigma


#Displaying the order-restricted MLEs for conditional cell probabilities

res$restricted_estimates


