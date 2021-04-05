setwd("Path/YouTube")
rm(list = ls())
list.files()

aaa<-read.csv("YLYL_COMMENTS.csv")
bbb<-read.csv("REDDIT_COMMENTS.csv")
ccc<-read.csv("MEME_REVIEW_COMMENTS.csv")

ddd<-read.csv("disliked_comments.csv")

View(bbb)

android_data<- rbind(aaa,bbb,ccc)
#android_data=android_data Original
View(android_data)

write.csv(android_data,"All_Comments.csv")

View(btotal_comments)
android_data<-read.csv(file.choose())



android_data$textOriginal=gsub("&amp", "", android_data$textOriginal)
android_data$textOriginal = gsub("&amp", "", android_data$textOriginal)
android_data$textOriginal = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", android_data$textOriginal)
android_data$textOriginal = gsub("@\\w+", "", android_data$textOriginal)
android_data$textOriginal = gsub("[[:punct:]]", "", android_data$textOriginal)
android_data$textOriginal = gsub("[[:digit:]]", "", android_data$textOriginal)
android_data$textOriginal = gsub("http\\w+", "", android_data$textOriginal)
android_data$textOriginal = gsub("[ \t]{2,}", "", android_data$textOriginal)
android_data$textOriginal = gsub("^\\s+|\\s+$", "", android_data$textOriginal)
android_data$textOriginal <- iconv(android_data$textOriginal, "UTF-8", "ASCII", sub="")


write.csv(android_data,'clean_comments.csv')
android_data = android_data$textOriginal

########################################################3


emotions <- get_nrc_sentiment(android_data)
head(emotions)

k<-get_sentiment(android_data)

most.positive <- android_data[k == max(k)]
most.positive

most.negative<-android_data[k==min(k)]
most.negative

emo_bar = colSums(emotions)
emo_sum = data.frame(count=emo_bar, emotion=names(emo_bar))
emo_sum$emotion = factor(emo_sum$emotion, levels=emo_sum$emotion[order(emo_sum$count, decreasing = TRUE)])

p <- plot_ly(emo_sum, x=~emotion, y=~count, type="bar", color=~emotion) %>%
  layout(xaxis=list(title=""), showlegend=FALSE,
         title="Emotions for Pewdiepie")
p

#create corpus
docs <- Corpus(VectorSource(android_data))

#text cleaning
docs = tm_map(docs, tolower)
docs = tm_map(docs, removePunctuation)
docs = tm_map(docs, removeWords, c(stopwords("english")))
#docs = tm_map(docs, removeWords, c("ios"))
#docs = tm_map(docs, removeWords, c("apple"))
docs = tm_map(docs, removeNumbers)
docs = tm_map(docs, stripWhitespace)
#docs = tm_map(docs, stemDocument)

# create document term matrix
dtm = TermDocumentMatrix(docs)
m = as.matrix(dtm)
v = sort(rowSums(m),decreasing=TRUE)
d = data.frame(word = names(v),freq=v)
head(d, 10)

#
write.csv(d,'all_comments_cleaner.csv')

#word frequencies
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")

d=read.csv("all_comments_cleaner.csv")

#wordcloud
set.seed(9)
wordcloud(words = d$word, freq = d$freq, min.freq = 3,
          max.words=200, random.order=FALSE, rot.per=0.30, 
          colors=brewer.pal(8, "Dark2"))

View(d)

#d
wordcloud2(d, size = 0.7, shape = 'diamond', color = "red")
wordcloud2(d, figPath = "Path/YouTube/PewDiePie-Logo.jpg")
letterCloud(d, word="A", size = 2)













