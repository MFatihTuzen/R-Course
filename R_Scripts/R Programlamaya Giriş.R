
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

# Faktörler ----

data <- c(rep("erkek",5),rep("kadın",7))
print(data)

is.factor(data)

factor_data <- factor(data)
is.factor(factor_data)

factor_data

as.numeric(factor_data)


boy <- c(132,151,162,139,166,147,122)
kilo <- c(48,49,66,53,67,52,40)
cinsiyet <- c("erkek","erkek","kadın","kadın","erkek","kadın","erkek")

df <- data.frame(boy,kilo,cinsiyet)
str(df)


df$cinsiyet <- factor(cinsiyet)
str(df)
print(is.factor(df$cinsiyet))
print(df$cinsiyet)


df2 <- c(rep("düşük",4),rep("orta",5),rep("yüksek",2))
factor_df2 <- factor(df2)
print(factor_df2)


order_df2 <- factor(factor_df2,levels = c("yüksek","orta","düşük"))
print(order_df2)


order_df2 <- factor(factor_df2,levels = c("yüksek","orta","düşük"),ordered = TRUE)
print(order_df2)


faktor <- gl(n=3, k=4, labels = c("level1", "level2","level3"),ordered = TRUE)
print(faktor)

# Fonksiyonlar ----

f_kare <- function(x) {
 x^2

}

f_kare(15)
f_kare(10)


set.seed(123) # Pseudo-randomization
x1 <- rnorm(1000, 0, 1.0)
x2 <- rnorm(1000, 0, 1.5)
x3 <- rnorm(1000, 0, 5.0)

sd1 <- sqrt(sum((x1 - mean(x1))^2) / (length(x1) - 1))
sd2 <- sqrt(sum((x2 - mean(x2))^2) / (length(x2) - 1))
sd3 <- sqrt(sum((x3 - mean(x1))^2) / (length(x3) - 1))
c(sd1 = sd1, sd2 = sd2, sd3 = sd3)


f_sd <- function(x) {
  result <- sqrt(sum((x - mean(x))^2) / (length(x) - 1))
  return(result)
}


sd1 <- f_sd(x1)
sd2 <- f_sd(x2)
sd3 <- f_sd(x3)
c(sd1 = sd1, sd2 = sd2, sd3 = sd3)

f_std <- function(x) {
  m <- mean(x)
  s <- sd(x)
  (x - m) / s
}

x4 <- rnorm(10,5,10)
x4

f_std(x4)


# Kontrol İfadeleri

x <- 8
if (x < 10) {
  print("x 10'dan küçüktür")
} else {
  print("x 10'dan büyüktür ya da 10'a eşittir")
}


df <- data.frame(value = 1:9)
df$group <- ifelse(df$value <= 3,1,ifelse(df$value > 3 & df$value <= 6,2,3))
df


for (i in 1:5) {
  print(i)
}

v <- LETTERS[1:4]
for ( i in v) {
  print(i)
}


for (i in 1:nrow(df)){
  df[i,"multiply"] <- df[i,"value"] * df[i,"group"]
}


# i yerine farklı ifade de kullanılabilir
(x <- data.frame(age=c(28, 35, 13, 13),
                 height=c(1.62, 1.53, 1.83, 1.71),
                 weight=c(65, 59, 72, 83)))

for (var in colnames(x)) {
  m <- mean(x[, var])
  print(paste("Average", var, "is", m))
}

x <- 0
while (x^2 < 20) 
  {
  print(x) # Print x
  x <- x + 1 # x'i bir artır
}

x <- 0
repeat {
  if (x^2 > 20) break # bu koşul sağlandığında döngüyü bitir
  print(x)
  x <- x + 1 # x'i bir artır
}

# next
for(i in 1:7) {
  if (i==4) next # i=4 olduğunda atla
  print(1:i)
}


(s <- seq(1,10,1))


for (i in s) {
  if (i%%2 == 1) { # mod
    next
  } else {
    print(i)
  }
}


(mat <- matrix(nrow=4, ncol=4))

nr <- nrow(mat)
nc <- ncol(mat)

# matrisin içini dolduralım
for(i in 1:nr) {
  for (j in 1:nc) {
    mat[i, j] = i * j
  }
}


# Tarih-ZamaN İşlemleri ---

Sys.Date()
Sys.time()

myDate <- as.Date("2022-01-04")
class(myDate)

as.Date("12/31/2021")
as.Date("12/31/2021", format = "%m/%d/%Y")
as.Date("1/31/2021", format = "%m/%d/%Y")


format(myDate, "%Y")
as.numeric(format(myDate, "%Y"))

weekdays(myDate)
months(myDate)
quarters(myDate)


date_week <- seq(from = as.Date("2021-10-1"),
                 to = as.Date("2021/12/31"),
                 by = "1 week")
date_week

date_day <- seq(from = as.Date("2021-12-15"),
                to = as.Date("2021/12/31"),
                by = "day")
date_day


date_month <- seq(from = as.Date("2021-1-15"),
                  to = as.Date("2021/12/31"),
                  by = "month")
date_month


class(Sys.time())


myDateTime <- "2021-12-11 22:10:35"
myDateTime
class(myDateTime)
as.POSIXct(myDateTime)
class(as.POSIXct(myDateTime))
Sys.timezone()


myDateTime.POSIXlt <- as.POSIXlt(myDateTime)
myDateTime.POSIXlt$sec
myDateTime.POSIXlt$min

#lubridate

library(lubridate)

ymd(20211215)
ymd_hm(202112121533)

mdy("December 13, 2021")
mdy("12 18, 2021")

dmy(241221)
dmy(24122021)

today <- Sys.time()
today


year(today)
month(today)
day(today)
hour(today)
minute(today)
second(today)

month(today,label = TRUE,abbr = FALSE)
wday(today, label = TRUE,abbr = FALSE)
yday(today)

library(zoo)

as.yearmon(today)
format(as.yearmon(today), "%B %Y")
format(as.yearmon(today), "%Y-%m")
as.yearqtr(today)

df <-
  data.frame(date = c(
    "2010-02-01",
    "20110522",
    "2009/04/30",
    "2012 11 05",
    "11-9-2015"
  ))
df$date2 <- as.Date(parse_date_time(df$date, c("ymd", "mdy")))
df

#Metin İşlemleri ----

as.character(3.14)
class(as.character(3.14))


first <- "Fatih"
last <- "Tüzen"
paste(first,last)
paste0(first,last)


paste("R","Python","SPSS",sep = "-")


x <- c("R programı","program","istatistik","programlama dili","bilgisayar","matematik")
grep("program",x)

grep("^ist",x)
grep("tik$",x)

grepl("tik$",x)
x[grepl("tik$",x)]


nchar(x)
nchar("R Programlama")
toupper("program")
tolower(c("SPSS","R","PYTHON"))

substr("123456789",start = 3, stop = 6)
substring("123456789", first =3, last = 6)


x <- "R Programlama"
substr(x,nchar(x)-3,nchar(x)) # son 4 karakteri getir
strsplit("Ankara;İstanbul;İzmir",split = ";")

# Apply Ailesi ----
# apply
x <-matrix(rnorm(30), nrow=5, ncol=6)
x

apply(x, 2 ,sum)
apply(x, 1 ,sum)
apply(x, 2 ,sd)

mat <- matrix(c(1:12),nrow=4)

apply(mat,2,function(x) x^2)


apply(mat,2, quantile,probs=c(0.25,0.5,0.75))

# lapply
a <-matrix(1:9, 3,3)
b <-matrix(4:15, 4,3)
c <-matrix(8:10, 3,2)
mylist<-list(a,b,c)
mylist

lapply(mylist,mean)
lapply(mylist,sum)
lapply(mylist, function(x) x[,1])

mylist2 <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
mylist2
lapply(mylist2, mean)

# sapply
nrow(cars)
head(cars)

lapply(cars,sum)
sapply(cars,sum)

#mapply

l1 <- list(a=c(1:5),b=c(6:10))
l2 <- list(c=c(11:15),d=c(16:20))
mapply(sum,l1$a,l1$b,l2$c,l2$d) # gözlemlerin toplamı

mapply(prod,l1$a,l1$b,l2$c,l2$d)

# tapply

df <- data.frame(x =round(runif(15,min=1,max=10)),
                 group=sample(c(1:3),15,replace = TRUE))
df

tapply(df$x,df$group, FUN = mean)

tapply(df$x,df$group, FUN = length)


# import ----



# delimiter/separator , ise
mtcars_csv <- read.csv("datasets/mtcars_csv.csv")
str(mtcars_csv)

mtcars_csv <- read.csv("datasets/mtcars_csv.csv",
                       stringsAsFactors = TRUE)
str(mtcars_csv)


mtcars_csv2 <- read.csv2("datasets/mtcars_csv2.csv")
str(mtcars_csv2)


mtcars_csv <- read.table("datasets/mtcars_csv.csv",
                         sep = ",",
                         header = TRUE)

mtcars_csv2 <- read.table("datasets/mtcars_csv2.csv",
                         sep = ";",
                         header = TRUE)

mtcars_txt <- read.table("datasets/mtcars_txt.txt",
                         sep = ";",
                         header = TRUE)

library(readxl)
mtcars_excel <- read_excel("datasets/mtcars_excel.xlsx",
                           sheet = "mtcars")
str(mtcars_excel)


mtcars_excel2 <- read_excel("datasets/mtcars_excel.xlsx",
                            sheet = "mtcars2",
                            skip = 1)

# export
write.csv(mtcars_csv,"write_mtcars.csv",
          row.names = FALSE)
write.table(mtcars_csv,"write_mtcars.csv",
            row.names = FALSE,
            sep = ";")



openxlsx::write.xlsx(mtcars_csv,"write_mtcars.xlsx")


# hazır verisetleri
data()
data(package = .packages(all.available = TRUE))


saveRDS(mtcars, "datasets/mtcars.rds")
my_data <- readRDS("datasets/mtcars.rds")
