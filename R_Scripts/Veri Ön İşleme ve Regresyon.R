# Eksik Veriler

df <- data.frame(weight=c(rnorm(15,70,10),rep(NA,5)),
                 height=c(rnorm(17,165,20),rep(NA,3)))
set.seed(12345)
rows <- sample(nrow(df))
df2 <- df[rows, ]
is.na(df2)

which(is.na(df2))
sum(is.na(df2))

colSums(is.na(df2))
df2[!complete.cases(df2), ]
df2[complete.cases(df2), ]$weight

na.omit(df2)
df2[complete.cases(df2), ]

# İmputasyon

# eksik verilere basit değer atama
df2$weight2 <- ifelse(is.na(df2$weight),mean(df2$weight, na.rm = TRUE),df2$weight)
sapply(df2, function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x ))


library(zoo)
sapply(df2, function(x) ifelse(is.na(x), na.locf(x), x )) # carry forward
sapply(df2, function(x) ifelse(is.na(x), na.locf(x,fromlast=FALSE), x ))

sapply(df2, function(x) ifelse(is.na(x), na.approx(x), x )) # linear interpolation
sapply(df2, function(x) ifelse(is.na(x), na.spline(x), x )) # cubic interpolation


# KNN

library(dplyr)
library(DMwR2)
# airquality verisi
df_air <- as_tibble(airquality)
df_air

anyNA(df_air)


set.seed(1234)
row_num <- sample(1:nrow(airquality),5)
row_num # bu satırdaki değerlere NA atanacak

airquality_2 <- airquality
airquality_2[row_num,"Wind"] <- NA
airquality_2[row_num,"Wind"]

head(airquality_2,20)
tail(airquality_2,10)

knn_df_air <- knnImputation(airquality_2, k = 5) # k komşu sayısı
result <- data.frame(row=row_num,
                     orig=airquality[row_num,"Wind"],
                     knn=knn_df_air[row_num,"Wind"])
result

mean(result$orig-result$knn)


# Aykırı Değer Analizi

library(ggplot2)
# mpg verisindeki hwy değişkeni üzerinden inceleyelim
summary(mpg$hwy)


ggplot(mpg) +
  aes(x = hwy) +
  geom_histogram(bins = 20, fill = "blue") +
  theme_minimal()


ggplot(mpg) +
  aes(x = "", y = hwy) +
  geom_boxplot(fill = "blue") +
  theme_minimal()


# outlier değrlerine erişim
boxplot.stats(mpg$hwy)$out

hwy_out <- boxplot.stats(mpg$hwy)$out
hwy_out_sira <- which(mpg$hwy %in% c(hwy_out))
hwy_out_sira

mpg[hwy_out_sira, ]


alt_sinir <- quantile(mpg$hwy, 0.025)
alt_sinir

ust_sinir <- quantile(mpg$hwy, 0.975)
ust_sinir


outlier_sira <- which(mpg$hwy < alt_sinir | mpg$hwy > ust_sinir)
outlier_sira


mpg[outlier_sira,]

# Sınırları biraz daha küçültelim
alt_sinir <- quantile(mpg$hwy, 0.01)
ust_sinir <- quantile(mpg$hwy, 0.99)
outlier_sira <- which(mpg$hwy < alt_sinir | mpg$hwy > ust_sinir)
mpg[outlier_sira, ]


std_z <- function(x){
  z=(x-mean(x))/sd(x)
  return(z)
}

mpg$hwy_std <- std_z(mpg$hwy)
mpg[,c("hwy","hwy_std")]

outliers_zskor <- which(mpg$hwy_std < -3 | mpg$hwy_std > +3)
outliers_zskor
mpg[outliers_zskor, ]

# Veri Normalleştirme
# 0 ile 1 arasi dönüşüm

set.seed(12345)
dat <- data.frame(x = rnorm(20, 10, 3),
                  y = rnorm(20, 30, 8),
                  z = rnorm(20, 25, 5))
dat
summary(dat)


std_0_1 <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

apply(dat, 2, std_0_1)
summary(apply(dat, 2, std_0_1))

library(dplyr)
dat %>% mutate_all(std_0_1) %>% summary()

#-1 ile +1 arası dönüşüm
std_1_1 <- function(x) {
  ((x - mean(x)) / max(abs(x - mean(x))))
}

# a ile b arası dönüşüm
std_min_max <- function(x,a,b) {
  # a min değer
  # b max değer
  (a + ((x - min(x)) * (b - a)) / (max(x) - min(x)))
}

dat %>% mutate_all(std_min_max, a = -2, b = 2) %>% summary()

par(mfrow=c(1,2))
hist(dat$x,main="original data",col="blue")
hist(std_0_1(dat$x),main="normalize data",col="red")


# Doğrusal Regresyon

library(gapminder)
library(dplyr)
library(ggplot2)


glimpse(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp)) +
  geom_point()
summary(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp)) +
  geom_point() +
  geom_smooth(method = "lm",se=TRUE)


model1 <- lm(lifeExp ~ gdpPercap, data = gapminder)
model1

model1$residuals

ggplot(mapping=aes(sample = resid(model1))) +
  stat_qq() +
  stat_qq_line(col="red",size=1.25) +
  theme_minimal()

summary(model1)


qqnorm(resid(model1))
qqline(resid(model1))


library(olsrr)
ols_plot_resid_qq(model1)
ols_test_normality(model1)
ols_plot_resid_fit(model1)
ols_plot_resid_hist(model1)


ggplot(gapminder, aes(log(gdpPercap), lifeExp)) +
  geom_point() +
  geom_smooth(method = "lm",se=TRUE)

model2 <- lm(lifeExp ~ log(gdpPercap), data = gapminder)
summary(model2)


model3 <- lm(lifeExp ~ log(gdpPercap) + continent + year, data = gapminder)
summary(model3)
str(gapminder)


model4 <- lm(lifeExp ~ log(gdpPercap) * continent + year, data = gapminder)
summary(model4)


gap_pred <- data.frame(lifeExp=c(70,75,80),
                       gdpPercap=c(9000,12000,15000),
                       continent=c("Asia","Americas","Europe"),
                       year=c(2012,2012,2012))
predict(model4, newdata = gap_pred,interval = "confidence", level = 0.99)


fitted <- data.frame(predict=model4$fitted.values)
head(fitted,10)


ggplot(gapminder, aes(gdpPercap)) +
  geom_point(aes(y = lifeExp)) +
  geom_point(aes(y = fitted$predict), color = "blue", alpha = 0.25)

ME <- function(model){
  mean(residuals(model))
}

RMSE <- function(model){
  sqrt(sum(residuals(model)^2) / df.residual(model))
}


adj.R2 <- function(model){
  summary(model)$adj.r.squared
}

metrics <-
  data.frame(
    model = c("model1", "model2", "model3", "model4"),
    ME = c(ME(model1), ME(model2), ME(model3), ME(model4)),
    AIC = c(AIC(model1), AIC(model2), AIC(model3), AIC(model4)),
    adj.R2 = c(
      adj.R2(model1),
      adj.R2(model2),
      adj.R2(model3),
      adj.R2(model4)
    ),
    RMSE = c(RMSE(model1), RMSE(model2), RMSE(model3), RMSE(model4))
  )
metrics

library(broom)
# Katsayılar düzeyinde sonuçlar
tidy(model4)

#model düzeyinde sonuçlar
glance(model4)

# gözlem düzeyinde sonuçlar
augment(model4)
