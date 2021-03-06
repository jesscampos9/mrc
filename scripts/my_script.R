# devtools::install_github("jvcasillas/untidydata")
library(untidydata)

library(xaringan)
library(plot3D)
library(tidyverse)

# load language_diversity datasets
str(language_diversity)
head(language_diversity)
unique(language_diversity$Measurement)

ld <- language_diversity %>%
  filter(., Continent == "Africa") %>%
  spread(., Measurement, Value) %>%
  select(., country = Country,
            pop = Population, 
            area = Area,
            lang = Langs) %>%
  mutate(., logArea = log(area),
            logPop = log(pop))

#check normality, transform, and plot

#checks normality, use log to make distribution a little more normal
hist(log(ld$area))
hist(log(ld$pop))

ld %>%
  ggplot(., aes(x = logPop, y = lang, color = logArea)) +
  geom_point()

#hyp 1: area is more important
#hyp 2: pop is more important

#5. fit a model (MRC, 3 parameters)

my_mod <- lm(lang ~logPop + logArea, data = ld)
summary(my_mod)


#these two are the same
#always use summary()
my_int <- lm(lang ~logPop + logArea + logPop:logArea, data = ld)
my_int <- lm(lang ~logPop * logArea, data = ld)
summary(my_int)

# args(function) to find what the function needs to work 


#convert to an html presentation (xaringan)











