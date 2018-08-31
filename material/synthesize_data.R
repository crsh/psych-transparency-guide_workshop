library("dplyr")
library("wakefield")

n <- 30
stimuli <- list.files(path = "stimuli/", pattern = "jpg")


# Raw data

ids <- id_factor(n)

for(i in ids) {
  i_data <- data_frame(
    id = i
    , date = date_stamp(1, x = seq(as.Date("2018-06-12"), length = 30, by = "1 days"))
    , time = time_stamp(1, seq(9, 18, by = 1/(60 * 60 * 9)))
    , sex = gender(1)
    , age = age(1, x = 18:35)
    , stimulus = factor(stimuli)
    , stimulus_gender = factor(if_else(grepl("CF", stimulus), "Female", "Male"))
    , iq = iq(length(stimuli))
    , perceived_iq = iq + iq(length(stimuli), mean = 0, sd = 20) * sample(c(1, -1), length(stimuli), replace = TRUE)
    , perceived_attractiveness = likert_7(length(stimuli), x = 1:7)
  )

  write.csv(i_data, file = file.path("raw_data", paste0("perceived_iq_", i, ".csv")), row.names = FALSE)
}
