library(ggplot2)

mpg

colnames(mpg)
nrow(mpg)
ncol(mpg)
head(mpg)
tail(mpg,10)
str(mpg)

summary(mpg)


df <- mpg
df$class <- factor(df$class)
levels(df$class)

library(dplyr)
glimpse(df)

library(funModeling)

profiling_num(df)

freq(df)

plot_num(df, bins = 10)

library(skimr)

skim(df)


# Sürekli Tek Değişken

summary(df$cty)
var(df$cty)
sd(df$cty)


# 1 mile= 1.609 km
# 1 galon = 3.79 lt
# litre başına km hesaplama
galonmil_to_ltkm <- function(x){
  km <- x * 1.609/3.79
  return(km)
}
df$cty_ltkm <- galonmil_to_ltkm(df$cty)
df$hwy_ltkm <- galonmil_to_ltkm(df$hwy)
quantile(df$cty_ltkm)
quantile(df$hwy_ltkm)


hist(df$cty_ltkm,freq = FALSE,col = "red",border = "blue")
lines(density(df$cty_ltkm), col = "black", lwd = 2)

hist(df$hwy_ltkm,xlim = c(4,20), ylim = c(0,60), breaks = 10)


# Boxplot
boxplot(df$cty_ltkm, main = "Boxplot cty")
fivenum(df$cty_ltkm)

boxplot(df$cty_ltkm)$out

which(df$cty_ltkm %in% boxplot(df$cty_ltkm)$out)

boxplot(hwy_ltkm ~ cyl, data = df, xlab = "Silindir Sayısı",
        ylab = "Litre Başına KM", main = "Mileage Data")


boxplot(hwy_ltkm ~ cyl, data = df,
        xlab = "Silindir Sayısı",
        ylab = "Litre Başına KM",
        main = "Mileage Data",
        notch = TRUE,
        varwidth = TRUE,
        col = c("green","yellow","purple","blue"),
        names = c("2 Silindir","4 Silindir","6 Silindir","8 Silindir")
)


# Kategorik Tek Değişken

summary(df$class)

table(df$class)

xtabs(~class,data=df)

prop.table(table(df$class))

tab <- table(df$class)
barplot(tab,col="blue",border="red")
pie(tab)


par(mfrow = c(1, 2))
barplot(tab)
pie(tab)
dev.off()
# Sürekli İki Değişken

summary(df$displ)

with(df,cor(displ,cty_ltkm))


plot(df$displ,df$cty_ltkm,
     main = "Motor Hacmi- Yakıt Tüketimi Saçılım Grafiği",
     col="red",
     xlab = "Motor Hacmi",
     ylab = "Yakıt Tüketimi")


# birden fazla değişkenin saçılım grafiği
pairs(~hwy_ltkm+cty_ltkm+displ+cyl,data = df,main = "Scatterplot Matrix")

# Bir Sürekli Bir Kategorik Değişken

# Silindir düzeyinde yakıt tüketimi

tapply(df$cty_ltkm, df$cyl, mean)

# Same using aggregate()
aggregate(cty_ltkm ~ cyl, data = df, FUN = mean)

boxplot(cty_ltkm ~ cyl, data = df)

# İki Kategorik Değişken

xtabs(~ trans + class,data=df)
table(df$year,df$class)

prop.table(table(df$year,df$class),1) # satır toplamları 1' eşittir
prop.table(table(df$year,df$class),2)

proportions(xtabs(~ manufacturer + year, data = df), 1)
proportions(xtabs(~ manufacturer + year, data = df), 2)


# araç sınıfı ile drv değişkenine birlikte bakalım
# f = front-wheel drive (önden çekiş),
# r = rear wheel drive (arkadan çekiş),
# 4 = 4wd (4 çeker)
png("plot3.png")
plot(class ~ factor(drv), data = df)
dev.off()


# Zaman Serisi
AirPassengers
class(AirPassengers)

diff(AirPassengers,2)

stats::lag(AirPassengers,-1)


plot(AirPassengers,type = "p", col = "red")
plot(AirPassengers,type = "l", col = "red") # line
plot(AirPassengers,type = "o", col = "red") # points and line


plot(log(AirPassengers),type = "l", col = "red") # line
plot(diff(AirPassengers),type = "l", col = "red") # line
plot(diff(log(AirPassengers)),type = "l", col = "red") # line



ts <- ts(rnorm(length(AirPassengers),250,100),start = c(1949,1),frequency=12)
ts


plot(AirPassengers,type = "l",col = "red")
lines(ts, type = "l", col = "blue")

# yüzde değişim
growth <- AirPassengers/stats::lag(AirPassengers,-1)*100-100

growth
plot(growth,type = "l", col = "red")


# ggplot2 

library(ggplot2)
library(dplyr)

# Saçılım Grafikleri
p1 <- ggplot(df,aes(x=displ,y=cty_ltkm)) +
  geom_point(size=2,color="red")

p1


p2 <- ggplot(df,aes(x=displ,y=cty_ltkm,colour=as.factor(year))) +
  geom_point(size=2) +
  # grafiğe başlık ekleme
  ggtitle("Motor Hacmi ve Yakıt Tüketimi Saçılım Grafiği") +
  #eksenleri isimlendirme
  xlab("Motor Hacmi") +
  ylab("Yakıt Tüketimi")+
  theme_minimal() + # tema değiştirme
  theme(legend.position = "bottom", # gruplama değişkeninin poziyounun değiştirme
        plot.title = element_text(face = "bold"), # kalın başlık
        legend.title = element_blank()) # grup başlığını kaldırma
p2


ggplot(df,aes(x=displ,y=cty_ltkm)) +
  geom_point(aes(size=factor(cyl)),color="red")


p1 + geom_smooth(method = lm, se = TRUE)
p1 + geom_smooth(method = loess, se = TRUE)


p3 <- df %>%
  ggplot(aes(x=displ,y=cty_ltkm,color=as.factor(cyl))) +
  geom_point() +
  geom_smooth(method = lm, se = TRUE)
p3

p3 + facet_wrap(~ year)
p3 + facet_wrap(~ year+drv)

p3 + facet_grid(drv ~ year) # eksen aralıkları sabit

p3 + facet_grid(drv ~ year,scales = "free")

# Zaman Serisi Grafikleri
economics

summary(economics)


p4 <- economics %>%
  ggplot(aes(x=date,y=pce)) +
  geom_line(color="blue") +
  theme_gray() +
  labs(x = "",
       y = "Personal Consumption Expenditures",
       title = "Personal Consumption Expenditures Time Series",
       caption = "Economics Data",
       subtitle = "Economics Data (1967-2015)")
p4


p4 +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  theme(axis.text.x = element_text(angle = 45), legend.position = "top")

p4 +
  scale_x_date(date_breaks = "2 year", date_labels = "%Y",expand = c(0,0)) +
  theme(axis.text.x = element_text(angle = 45), legend.position = "top")


economics %>%
  ggplot(aes(x=date,y=pce)) +
  geom_line(linetype = "dashed", size = 1, colour = "blue")

economics %>%
  ggplot(aes(x=date,y=pce)) +
  geom_line(linetype = "dotted", size = 0.5, colour = "blue")


economics %>%
  filter(lubridate::year(date) >= 2010) %>%
  ggplot(aes(x=date,y=pce)) +
  geom_line()+
  geom_point(size = 3, shape= 10, colour = "red")


economics %>%
  ggplot(aes(x=date,y=pce)) +
  geom_area(color="blue",fill="red",alpha=0.8) +
  # y ekseni aralıklarını ayarlama
  scale_y_continuous(breaks = seq(0, max(economics$pce), by = 1000))

economics %>%
  ggplot(aes(x=date,y=uempmed )) +
  geom_area(color="blue",fill="red",alpha=0.5) +
  theme_light()


economics_long %>% 
ggplot(aes(x=date,y=value,color=variable))+
  geom_line()

economics_long %>%
  ggplot(aes(x=date,y=value))+
  geom_line() +
  facet_wrap(~variable,scales = "free_y")


economics_long %>%
  ggplot(aes(x=date,y=value))+
  geom_line() +
  facet_wrap(~variable,scales = "free_y")+
  scale_y_log10() # y eksenlerinin logatirması alınır


# Sütun grafikleri

diamonds
summary(diamonds)


ggplot(diamonds, aes(cut)) +
  geom_bar()


ggplot(diamonds, aes(cut, fill = color)) +
  geom_bar(position = position_dodge()) +
  xlab("Pirlanta kaliteleri") +
  ylab("Gozlenme Sikliklari")


ggplot(diamonds, aes(x=cut, y=carat,fill = color)) +
  geom_bar(stat = "identity")


ggplot(diamonds, aes(x=cut, y=carat,fill = color)) +
  # fill ile oransal olarak gösterim yapılır
  geom_bar(stat = "identity",position = "fill")


ggplot(diamonds, aes(x=cut,y=carat, fill = color)) +
  geom_col() # y ekseni toplanarak yığılmış


ggplot(diamonds, aes(x=cut,y=carat, fill = color)) +
  geom_col(position = "dodge") # y ekseni değerleri


economics %>%
  mutate(uemploy_mom=unemploy/lag(unemploy) * 100 - 100,
         growth=ifelse(uemploy_mom>0,"pozitif","negatif")) %>%
  na.omit() %>%
  filter(lubridate::year(date)>=2010) %>%
  ggplot(aes(x=date,y=uemploy_mom,fill=growth))+
  geom_col() +
  theme(legend.position = "none") +
  labs(y="Aylık Değişim",
       title="Yıllar İtibarıyla Aylık İstihdam Değişimi (2010-2015)")


ggplot(diamonds, aes(price)) +
  geom_histogram()


ggplot(diamonds, aes(price)) +
  geom_histogram(binwidth = 1000,fill = "green")


ggplot(diamonds, aes(price)) +
  geom_density()


ggplot(diamonds, aes(price)) +
  geom_density(alpha = 0.8, fill = "blue")


ggplot(diamonds, aes(price)) +
  geom_histogram(aes(y = ..density..),fill = "red") +
  geom_density(size=1,fill = "blue")


ggplot(diamonds, aes(price)) +
  geom_histogram() +
  facet_wrap( ~ cut ,scales = "free" )

ggplot(diamonds, aes(price)) +
  geom_histogram() +
  facet_grid(cut ~ color,scales = "free" )


ggplot(diamonds, aes(x=price,fill=cut)) +
  geom_density(alpha=.3)


# freqpoly
ggplot(diamonds, aes(x=price)) +
  geom_freqpoly()


# boxplot'a ortalama eklemek
ggplot(diamonds, aes(x=cut,y=price)) +
  geom_boxplot(color="blue")+
  stat_summary(fun.y = "mean", geom = "point", shape = 5, size = 3)


# ısı haritası


economics %>% 
  mutate(year=lubridate::year((date)),
         month=lubridate::month(date,label = TRUE,abbr = FALSE)) %>%
  ggplot()+
  geom_tile(aes(x=year,y=month,fill=pce))+
  scale_fill_distiller(palette = "Spectral",
                       type = "seq")


USD <- readxl::read_excel("datasets/USD.xlsx")
str(USD)
head(USD)

USD %>% 
  mutate(date=lubridate::ym(Tarih),
         year=lubridate::year((date)),
         month=lubridate::month(date,label = TRUE,abbr = FALSE)) %>% 
  ggplot()+
  geom_tile(aes(x=year,y=month,fill=USD))+
  scale_fill_viridis_c()+
  scale_x_continuous(expand = c(0,0))+
  theme(legend.position = "bottom",
        legend.key.width = unit(1, "cm"),
        legend.title = element_blank(),
        panel.background = element_rect(fill = "white", colour = "gray"))
 
USD %>% 
  mutate(date=lubridate::ym(Tarih),
         year=lubridate::year((date)),
         month=lubridate::month(date)) %>% 
  ggplot(aes(x = year, y = month, fill = ..level..)) +
  stat_density_2d(geom = "polygon") +
  scale_fill_viridis_c()

library(tidyr)
cor_data <- data.frame(cor(economics[2:6]))

cor_data %>% 
  mutate(var1=rownames(cor_data)) %>% 
  gather(key = "var2",value = "value",-var1) %>% 
  ggplot(aes(x = var1,y = var2,fill = value))+
  geom_tile()+
  #scale_fill_gradient(high = "green", low = "white")+
  scale_fill_distiller(palette = "Spectral")
  

# grafiği kaydetme

my_plot <- economics %>%
  mutate(uemploy_mom=unemploy/lag(unemploy ) * 100 - 100,
         growth=ifelse(uemploy_mom>0,"pozitif","negatif")) %>%
  na.omit() %>%
  filter(lubridate::year(date)>=2010) %>%
  ggplot(aes(x=date,y=uemploy_mom,fill=growth))+
  geom_col() +
  theme(legend.position = "none") +
  labs(y="Aylık Değişim",
       title="Yıllara göre Aylık İstihdam Değişimi (2010-2015)")

ggsave("myplot.pdf", my_plot, width = 20, height = 8, units = "cm")
ggsave("myplot.png", my_plot,width = 20, height = 8, unit = "cm", dpi = 300)


#nycflights13 paketi ile pratik yapılacak.
