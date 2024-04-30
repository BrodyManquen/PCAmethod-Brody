#' Music Genre Classification 'train' data set
#'
#' A subset of data from the Music Genre Classification data set on Kaggle
#'
#' Created during a MachineHack Hackathon, presumably from music data provided via APIs on Spotify
#' Audio features described here: https://www.kaggle.com/datasets/amitanshjoshi/spotify-1million-tracks?resource=download
#'
#' @format ## `music`
#' A data frame with 17,996 rows and 17 columns:
#' \describe{
#'   \item{Artist Name}{Artist name}
#'   \item{Track Name}{Track Name}
#'   \item{Popularity}{Track popularity based on all-time streams (0 to 100)}
#'   \item{danceability}{Track suitability for dancing (0.0 to 1.0)}
#'   \item{energy}{The perceptual measure of intensity and activity (0.0 to 1.0)}
#'   \item{key}{The key the track is in (-1 to -11)}
#'   \item{loudness}{Overall loudness of the track in decibels (-60 to 0 dB)}
#'   \item{mode}{Modality of the track (Major'1'/Minor'0')}
#'   \item{speechiness}{Presence of spoken words in the track (0.0 to 1.0)}
#'   \item{acousticness}{Confidence measure from 0 to 1 of whether the track is acoustic}
#'   \item{instrumentalness}{The likelihood the track contains vocal content (0.0 to 1.0}
#'   \item{liveness}{Presence of audience in the recordings (0.0 to 1.0)}
#'   \item{valence}{Musical positiveness (0.0 to 1.0)}
#'   \item{tempo}{Tempo of the track in beats per minute (BPM)}
#'   \item{duration_in min/ms}{Duration of the track in minutes (min) or milliseconds (ms)}
#'   \item{time_signature}{Estimated time signature (3 to 7)}
#'   \item{Class}{Genre (0-11) indicating Rock, Indie, Alt, Pop, Metal, HipHop, Alt_Music, Blues, Acoustic/Folk, Instrumental, Country, or Bollywood}
#'   ...
#' }
#' @source <https://www.kaggle.com/datasets/purumalgi/music-genre-classification/data?select=train.csv>
"music"
