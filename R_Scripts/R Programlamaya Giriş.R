
# Giriş ----

getwd()
setwd("deneme")
dir()
dir("deneme")
list.files()
dir.create("deneme2")
file.exists("deneme")
file.exists("deneme3")


median(1:4) 
?mean

# yardımcı bilgiler




ls()
rm(a)

rm(list=ls())
q()

install.packages("dplyr")

library(dplyr)

packages <- installed.packages()

options(digits = 10)



# Atama Operatörü

a <- 5
A <- 5

x <- 1;y <- 2;z <- 3

print(a)

b <- 3
c <- a*2+b/4
c
print(c)


d <- c(1,4,5,9)
d

e <- "Merhaba"

3+5
7*8
3*(12+(5/6))

9^2

log(15)
log()
exp(1)

log(10)
log(100,2)
log(100,base=2)

log10(100)
log(100,10)

factorial(5)
sqrt(81)
abs(-5)
abs(c(-1:5))
sign(-5)
sign(5)

sin(45)

cos(90)
pi


# Mantıksal İfadeler

3 > 5

3 < 5 & 8 > 7

3 < 5 & 6 > 7

6 < 5 & 6 > 7

(5==4) | (3!=4)


a <- 3.5
class(a)
typeof(a)

is.numeric(a)
b <- 5
class(b)
is.integer(b)

c <- as.integer(b)
class(c)

class(as.integer(b))

z <- 4 + 2i
class(z)

d <- "R Programlama"
class(d)

e <- "5.5"
class(e)

as.numeric(e)

x <- TRUE ; y <- FALSE
class(c(x,y))
as.integer(c(x,y))


# Vektörler ----


v <- c(1,4,7,2,5,8,3,6,9)

v[2]
v[-2]
v[c(3,7)]

v[1:5]

length(v)

v2 <- c(v,12)
v2

v3 <- 1:10
v4 <- 11:20

v3+v4
v+v3
v3/v4

2 * v3 - v4
 # seq
seq(from = 5, to = 50, by =5)

seq(from = 5, to = 50, length = 7)

seq(5,1,-1)

# rep
rep(10)
rep(10,8)
rep(c(1,2,3),4)
rep(c(1,2,3), each = 4)

#rev
v5 <- c(3,5,6,1,NA,12,NA,8,9) # R'da NA boş gözlemi ifade eder.
rev(v5) # vektörü tersine çevirir

rank(v5) # elemanların sıra numarasını verir
rank(v5, na.last = TRUE) # NA leri son sıraya atar.
rank(v5, na.last = FALSE) # NA leri en başa koyar.
rank(v5,na.last = NA) # NA değerlere yer verilmez

rank(v5, na.last = "keep") # NA değerler oldukları gibi görünürler.


#all

all(v5>5)
all(v5>0)
all(v5>0, na.rm = TRUE)

# any
any(v5>6)

any(v5==9)
any(v5==15,na.rm = TRUE)

# unique

v6 <- rep(1:5,3)
v6
unique(v6)

duplicated(v6)
v6[duplicated(v6)]

# sort
sort(v5)
sort(v5,decreasing = TRUE)


# diff
diff(v5)

na.omit(v5)
diff(na.omit(v5))


#is.na

is.na(v5)
is.nan(v5)
v5[is.na(v5)]

# which

which(v5==12)

which.max(v5)
which.min(v5)

v5[which.min(v5)]


#mean,min,max ...
mean(v5,na.rm = TRUE)
median(v5,na.rm = TRUE)

sum(v5,na.rm = TRUE)
min(v5,na.rm = TRUE)
max(v5,na.rm = TRUE)

sd(v5,na.rm = TRUE)
var(v5,na.rm = TRUE)

v5
v5[(length(v5)-2):(length(v5))]
tail(v5,2) # son gözlemler
head(v5) # ilk gözlemler
head(v5,3)

sum(is.na(v5)) 3 # vektör içerisindeki NA saydırma




# Matrisler ----

v1 <- c(3,4,6,8,5)
v2 <- c(4,8,4,7,1)
v3 <- c(2,2,5,4,6)
v4 <- c(4,7,5,2,5)


matris <- cbind(v1, v2, v3, v4)

is.matrix(matris)
dim(matris)

matrix(nrow = 3, ncol = 3, 1:9)
matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)


mat <- seq(3, 21, by = 2)
matrix(mat,5,2,TRUE)

set.seed(1234)

MA <- rnorm(16, 0, 1)
MA <- matrix(MA, nrow = 4, ncol = 4)

MB <- rnorm(16, 90, 10)
MB <- matrix(MB, nrow = 4, ncol = 4)

m <- rbind(MA, MB)
m

cbind(MA, MB)

colnames(m) <- LETTERS[1:4]
rownames(m) <- tail(LETTERS,8)
colnames(m) <- c("rnorm1","rnorm2","rnorm3","rnorm4")
m

m[1,1]
m[8,4]
m[1,]
m[,3]

m[-3,]


diag(2,nrow=3) # köşegen matris

diag(1,nrow=5)
t(m)


m1 <- matrix(1:4,nrow=2)
m2 <- matrix(5:8,nrow=2)

m2 <- matrix(1:8,nrow=2)
m1;m2

m1+m2
m1 * m2

m1 %*% m2

solve(m2)

rowSums(m1)
rowMeans(m1)
colSums(m1)
colMeans(m1)

# List ----


x <- c(3,5,7)
y <- letters[1:10]
z <- c(rep(TRUE,3),rep(FALSE,4))

list <- list(x,y,z)
list

class(list)
str(list)


names(list) <- c("numeric","karakter","mantıksal")
list

list$karakter


list[[2]]
list[2]

list$numeric2 <- c(4:10)
list

list$numeric <- NULL
list

vek <- unlist(list)

# dataframe -----


set.seed(12345)
data <- data.frame(
  row_num = 1:20,
  col1 = rnorm(20),
  col2 = runif(20), # uniform dağılımdam 20 gözlem üret
  col3 = rbinom(20,size=5,prob = 0.5), # binom dağılımdam 20 gözlem üret
  col4 = sample(c("TRUE","FALSE"),20,replace = TRUE),
  col5 = sample(c(rep(c("E","K"),8),rep(NA,4))),
  stringsAsFactors = TRUE # karakter olanlar faktör olarak değerlendirilsin
)
head(data,10)
class(data)

tail(data,-2) # ilk iki gözlem hariç
head(data,-1) # son gözlem hariç

str(data)
summary(data)

head(data$col1)

data_cols <- names(data)

data[,"col1"]
head(data[,c("col1","col2")])

data[1:5,data_cols[1:3]]

data[c(3,5),c(2,4)]


data$row_num > 12
data[data$row_num > 12,]

subset(data,
       row_num >= 10 & col4 == 'TRUE',
       select = c(row_num, col1, col2, col4))

names(data)
colnames(data)


cols <- c("col1","col2","col5")
head(data[cols])

data$col1 <- NULL
head(data)


data$col1 <- rnorm(20)
head(data)



head(data[c("col1","row_num","col2","col3","col4","col5")])

head(data[order(data$col3),]) # artan
head(data[order(-data$row_num),]) # azalan
head(data[order(data$col3,-data$row_num),])


tail(is.na(data))
tail(is.na(data$col5))
data[!is.na(data$col5),]


rowSums(is.na(data))
colSums(is.na(data))


sum(is.na(data))

complete.cases(data)
data[complete.cases(data),]

data[!complete.cases(data),]


na.omit(data)
