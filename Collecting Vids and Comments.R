setwd("D:/SCIT/SEM-3/Social Media Analytics/YouTube")

##
library(tuber)
library(tidyverse)
library(lubridate)
library(stringi)
library(wordcloud)
library(gridExtra)

## Authenticate
yt_oauth("441706213125-671sgnr0ufss5oh9otu6hd3tiha5r41m.apps.googleusercontent.com", "e9LC-a88VZQPLM7gp-ZIcfJf",token =" ")


## Get Stats
pewdiepie_stats <- get_channel_stats("UC-lHJZR3Gqxm24_Vd_AJ5Yw")

## PlayLists
MEME_REVIEW = get_playlist_items(filter = c(playlist_id = "PLYH8WvNV1YEn_iiBMZiZ2aWugQfN1qVfM"))
view(MEME_REVIEW)
write.csv(MEME_REVIEW,'MEME_REVIEW.csv')

REDDIT = get_playlist_items(filter = c(playlist_id = "PLYH8WvNV1YEn6-a2cGz0yoK5Q2TMzwNc-"))
view(REDDIT)
write.csv(REDDIT,'REDDIT.csv')

MINECRAFT = get_playlist_items(filter = c(playlist_id = "PLYH8WvNV1YEn9PkI2stxJWMs8GRit66Rz"))
view(MINECRAFT)
write.csv(MINECRAFT,'MINECRAFT.csv')

YLYL = get_playlist_items(filter = c(playlist_id = "PLYH8WvNV1YEnblnazwa6y27kkeqg35dfz"))
view(YLYL)
write.csv(YLYL,'YLYL.csv')

###

comments = lapply(as.character(MEME_REVIEW$contentDetails.videoId), function(x){
  get_comment_threads(c(video_id = x), max_results = 100, simplify = TRUE)
})
View(comments)
write.csv(comments,'MEME_REVIEW_COMMENTS.csv')
comments <- do.call("rbind", comments)


comments = lapply(as.character(REDDIT$contentDetails.videoId), function(x){
  get_comment_threads(c(video_id = x), max_results = 100)
})
View(comments)
write.csv(comments,'REDDIT_COMMENTS.csv')
comments_min <- do.call("rbind", comments_min)

comments_min = lapply(as.character(YLYL$contentDetails.videoId), function(x){
  get_comment_threads(c(video_id = x), max_results = 100)
})
View(comments_min)
write.csv(comments_min,'YLYL_COMMENTS.csv')


#####

videostats = lapply(as.character(MINECRAFT$contentDetails.videoId), function(x){
  get_stats(video_id = x)
})
View(videostats)
videostats <- do.call("rbind", videostats)
