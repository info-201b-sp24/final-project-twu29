library(tidyverse)

sleep_dataset <- read_csv("info final/Sleep_health_and_lifestyle_dataset.csv")

sleep_dataset <- sleep_dataset %>% 
  select(Gender, Age, `Quality of Sleep`, `Physical Activity Level`, `Sleep Disorder`)
