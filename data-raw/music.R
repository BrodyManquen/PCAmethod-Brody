# The **music** dataset is used for example purposes.
# Source: https://www.kaggle.com/datasets/purumalgi/music-genre-classification/data?select=train.csv
# Creation: during a MachineHack Hackathon.
# Contents: 17,996 songs with 17 metrics (artist name; track name; popularity; ‘danceability’; energy; key; loudness; mode; ‘speechiness’; ‘acousticness’; ‘instrumentalness’; liveness; valence; tempo; duration in milliseconds and time_signature).
# **Class** is the target variable (genre) ranging from 0-10 and indicating Rock, Indie, Alt, Pop, Metal, HipHop, Alt_Music, Blues, Acoustic/Folk, Instrumental, Country, or Bollywood.

f <- "data/music.csv"
music <- readr::read_csv(f, col_names = TRUE)
usethis::use_data(music, overwrite = TRUE)
# overwrite argument replaces the data if it already exists
