
library(dplyr)
counties <- readRDS("datasets/counties.rds")
# veri setinin yapısı hakkında bilgi sağlar
str(counties)

glimpse(counties)

# select ----
counties %>%
  select(state, county, population, unemployment)

# belli aralıkta bütün sütunların seçilmesi
counties %>%
  select(state, county, drive:work_at_home)

# belirli bir ifadeyi içeren sütunları seçmek
counties %>%
  select(state, county, contains("employed"))

# belirli bir ifade ile başyalan sütunları seçmek
counties %>%
  select(state, county, starts_with("income"))

# belirli bir ifade ile biten sütunları seçmek
counties %>%
  select(state, county, ends_with("work"))


# belirli sütunları hariç tutarak seçmek
counties %>%
  select(census_id:population,-c(men:land_area))

# belirli veri tipindeki sütunları seçmek
counties %>%
  select(where(is.character))


# arrange ----

counties_selected <- counties %>%
  select(state, county, population, unemployment)

# artan sıralama (ascending)
counties_selected %>%
  arrange(population)

# azalan sıralama (descending)
counties_selected %>%
  arrange(desc(population))

counties_selected %>%
  arrange(state,desc(population))

# filter ----

# sadece New York'u filtrele
counties_selected %>%
  arrange(desc(population)) %>%
  filter(state == "New York")

# işsizlik oranı 6'dan küçük olanları filtrele
counties_selected %>%
  arrange(desc(population)) %>%
  filter(unemployment < 6)


# birden fazla koşul
counties_filtered <- counties_selected %>%
  arrange(desc(population)) %>%
  filter(state == "New York" , unemployment < 6)

class(counties_filtered)

# mutate ----
# işsiz nüfus sayısına ilişkin değişken üretme

counties_selected %>%
  mutate(unemployed_population = population * unemployment / 100)

counties_selected %>%
  mutate(unemployed_population = population * unemployment / 100) %>%
  arrange(desc(unemployed_population))

counties %>%
  select(state, county, population, men,women) %>%
  mutate(population = men + women)


counties %>%
  select(state, county, population, men,women) %>%
  mutate(men_ratio = men/population*100,
         women_ratio = women/population*100)

counties %>%
  select(state, county, population, men,women) %>%
  transmute(men_ratio = men/population*100,
            women_ratio = women/population*100)

scale2 <- function(x, na.rm = FALSE) (x - mean(x, na.rm = na.rm)) / sd(x, na.rm)

counties_selected %>%
  mutate_at(c("population","unemployment"),scale2)

counties_selected %>% # birden fazla argüman kullanımı
  mutate_at(c("population","unemployment"),scale2,na.rm = TRUE)

# mutate_if ile koşula göre birden fazla değişkende değişiklik yapılabilir.
str(counties_selected)


counties_selected <- counties_selected %>%
  mutate_if(is.character,as.factor)

str(counties_selected)

# rename -----

# yeniden isimlendirmede eşitliği sol tarafı yeni isim olmalı
counties_selected %>%
  rename(unemployment_rate = unemployment)

# select ile beraber de yeniden isimlendirme yapılabilir
counties_selected %>%
  select(state, county, population, unemployment_rate = unemployment)

# count ----

# count ile veri setinde sayma işlemleri yapılır
counties %>%
  count()


counties %>%
  count(state)


counties %>%
  count(state, sort = TRUE)

counties %>%
  count(state) %>% 
  arrange(desc(n))

counties %>%
  count(state, wt = population, sort = TRUE)


# group_by ve summarise ----

counties %>%
  summarize(total_population = sum(population))


counties %>%
  summarize(total_population = sum(population),
            average_unemployment = mean(unemployment))

counties %>%
  group_by(state) %>%
  summarize(total_pop = sum(population),
            average_unemployment = sum(unemployment))


counties %>%
  group_by(state) %>%
  summarize(total_pop = sum(population),
            average_unemployment = mean(unemployment)) %>%
  arrange(desc(average_unemployment))


counties %>%
  group_by(state, metro) %>%
  summarize(total_pop = sum(population))


counties %>%
  group_by(state, metro) %>%
  summarize(total_pop = sum(population)) %>%
  ungroup()


counties_selected %>%
  group_by(state) %>%
  top_n(2, population) # her eyaletteki en yüksek nüfuslu yer

counties_selected %>%
  group_by(state) %>%
  top_n(-1, population) # her eyaletteki en düşük nüfuslu yer

counties_selected %>% summarise_all(nlevels)
counties_selected %>% summarise_all(mean)


counties_selected %>%
  select(-county) %>%
  group_by(state) %>%
  summarise_all(mean)

counties_selected %>%
  select(-county) %>%
  group_by(state) %>%
  summarise_at("population",mean)


# summarise_if ile koşula göre özetleme yapar
counties_selected %>%
  summarize_if(is.numeric, mean, na.rm = TRUE)

# case_when ----
# case_when ile yeniden kodlama yapılabilir.
# gelir değişkenini sınıflandıralım

summary(counties$income)

counties_income <- counties %>%
  select(state, county,income) %>%
  mutate(income_new= case_when(
    between(income,19328,38827) ~"low",
    between(income,38828,52249)~"medium",
    income > 52249 ~"high")
  )
counties_income


table(counties_income$income_new)

# reshaping -----

library(tidyr)
# gather tabloyu yatay formattan dikey formata dönüştürür (transpose).

counties_gender <- counties %>%
  select(state,county,men,women) %>%
  gather(key="gender",value = "population",-c(state,county))


counties_gender


counties_race <- counties %>%
  select(state,county,hispanic:pacific) %>%
  gather(key="race",value = "ratio",-c(state,county))
counties_race


# spread tabloyu dikey formattan yatay formata dönüştürür (transpose).
counties_gender_hor <- counties_gender %>%
  spread(key=gender,value = population)
counties_gender_hor

# unite
counties_unite <- counties %>%
  select(state:population) %>%
  unite("region_metro",c(region,metro))
counties_unite

counties_unite <- counties %>%
  select(state:population) %>%
  unite("region_metro",c(region,metro),sep = "-",remove = FALSE)
counties_unite


counties_separate <- counties_unite %>%
  separate(region_metro,c("region2","metro2"),sep = "-")
counties_separate
