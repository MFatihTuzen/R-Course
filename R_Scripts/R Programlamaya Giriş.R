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
