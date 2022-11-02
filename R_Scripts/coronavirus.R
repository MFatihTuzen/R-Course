devtools::install_github("RamiKrispin/coronavirus")

# coronavirus verisi
library(coronavirus)
data(coronavirus)
head(coronavirus)
tail(coronavirus)
nrow(coronavirus)
ncol(coronavirus)
summary(coronavirus)


coronavirus %>%
  filter(type == "confirmed") %>%
  group_by(date) %>%
  summarise(cases = sum(cases)) %>%
  arrange(desc(date))

library(ggplot2)
coronavirus %>%
  filter(type != "recovery") %>%
  group_by(date,type) %>%
  summarise(cases = sum(cases)) %>%
  ggplot(aes(x=date,y=cases)) +
  geom_col(col="blue") +
  facet_wrap(~type,scales = "free",nrow = 2)
