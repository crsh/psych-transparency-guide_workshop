library("readxl")
library("xlsx")
library("wakefield")
library("dplyr")

set.seed(29751)

iq_data <- read_xls("material/perceived-iq-data.xls") %>%
  mutate(
    `mother tounge` = language(
      n = nrow(.)
      , x = c("Czech", "German", "English", "Polish", "Italian")
      , prob = c(0.8, 0.1, 0.05, 0.025, 0.025)
    )
    , `timestamp` = paste0(
      date_stamp(nrow(.))
      , "-"
      , time_stamp(nrow(.), seq(9, 18, length.out = nrow(.)), random = TRUE)
    )
  ) %>%
  select(ID, timestamp, sex, age, `mother tounge`, everything())

write.csv(iq_data, file = "material/perceived-iq-data-alt.csv")
write.xlsx2(iq_data, file = "material/perceived-iq-data-alt.xlsx")
