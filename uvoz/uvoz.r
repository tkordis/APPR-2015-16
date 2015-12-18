base.page <- "http://www.whoscored.com/Regions/252/Tournaments/2/Seasons/4311/Stages/9155/PlayerStatistics/England-Premier-League-2014-2015"

agent <- "Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0"

model <- html_session(base.page, add_headers("User-Agent" = agent)) %>%
  read_html() %>% html_nodes(xpath="//script") %>% html_text() %>%
  strapplyc("'Model-Last-Mode': '([^']+)'") %>% unlist()

#Summary tabela
data.page <- "http://www.whoscored.com/StatisticsFeed/1/GetPlayerStatistics?category=summary&subcategory=all&statsAccumulationType=0&isCurrent=true&playerId=&teamIds=&matchId=&stageId=9155&tournamentOptions=2&sortBy=Rating&sortAscending=&age=&ageComparisonType=&appearances=&appearancesComparisonType=&field=Overall&nationality=&positionOptions=&timeOfTheGameEnd=&timeOfTheGameStart=&isMinApp=true&page=&includeZeroValues=&numberOfPlayersToPick=100"

stran <- GET(data.page, add_headers("User-Agent" = agent,
                                    "Model-Last-Mode" = model,
                                    "X-Requested-With" = "XMLHttpRequest",
                                    "Referer" = base.page))
text <- content(stran, "text")
data <- fromJSON(text)
tabela <- data$playerTableStats
tabela<-tabela[,c("firstName","lastName","teamName","age","height","weight","positionText","apps","minsPlayed","yellowCard","redCard","rating","subOn","manOfTheMatch","goal","assistTotal","aerialWonPerGame")]


#Defensive tabela
data.page2 <- "http://www.whoscored.com/StatisticsFeed/1/GetPlayerStatistics?category=summary&subcategory=defensive&statsAccumulationType=0&isCurrent=true&playerId=&teamIds=&matchId=&stageId=9155&tournamentOptions=2&sortBy=Rating&sortAscending=&age=&ageComparisonType=&appearances=&appearancesComparisonType=&field=Overall&nationality=&positionOptions=&timeOfTheGameEnd=&timeOfTheGameStart=&isMinApp=true&page=&includeZeroValues=&numberOfPlayersToPick=100"

stran2 <- GET(data.page2, add_headers("User-Agent" = agent,
                                      "Model-Last-Mode" = model,
                                      "X-Requested-With" = "XMLHttpRequest",
                                      "Referer" = base.page))
text2 <- content(stran2, "text")
data2 <- fromJSON(text2)
tabela2 <- data2$playerTableStats
tabela2 <- tabela2[,c("tacklePerGame","interceptionPerGame","foulsPerGame","offsideWonPerGame","clearancePerGame","wasDribbledPerGame","outfielderBlockPerGame","goalOwn")]


#Offensive tabela
data.page3 <- "http://www.whoscored.com/StatisticsFeed/1/GetPlayerStatistics?category=summary&subcategory=offensive&statsAccumulationType=0&isCurrent=true&playerId=&teamIds=&matchId=&stageId=9155&tournamentOptions=2&sortBy=Rating&sortAscending=&age=&ageComparisonType=&appearances=&appearancesComparisonType=&field=Overall&nationality=&positionOptions=&timeOfTheGameEnd=&timeOfTheGameStart=&isMinApp=true&page=&includeZeroValues=&numberOfPlayersToPick=100"

stran3 <- GET(data.page3, add_headers("User-Agent" = agent,
                                      "Model-Last-Mode" = model,
                                      "X-Requested-With" = "XMLHttpRequest",
                                      "Referer" = base.page))
text3 <- content(stran3, "text")
data3 <- fromJSON(text3)
tabela3 <- data3$playerTableStats
tabela3 <- tabela3[,c("shotsPerGame","keyPassPerGame","dribbleWonPerGame","foulGivenPerGame","offsideGivenPerGame","dispossessedPerGame","turnoverPerGame")]


#Passing tabela
data.page4 <- "http://www.whoscored.com/StatisticsFeed/1/GetPlayerStatistics?category=summary&subcategory=passing&statsAccumulationType=0&isCurrent=true&playerId=&teamIds=&matchId=&stageId=9155&tournamentOptions=2&sortBy=Rating&sortAscending=&age=&ageComparisonType=&appearances=&appearancesComparisonType=&field=Overall&nationality=&positionOptions=&timeOfTheGameEnd=&timeOfTheGameStart=&isMinApp=true&page=&includeZeroValues=&numberOfPlayersToPick=100"

stran4 <- GET(data.page4, add_headers("User-Agent" = agent,
                                      "Model-Last-Mode" = model,
                                      "X-Requested-With" = "XMLHttpRequest",
                                      "Referer" = base.page))
text4 <- content(stran4, "text")
data4 <- fromJSON(text4)
tabela4 <- data4$playerTableStats
tabela4 <- tabela4[,c("totalPassesPerGame","accurateCrossesPerGame","accurateLongPassPerGame","accurateThroughBallPerGame","passSuccess")]


skupna.tabela <- cbind(tabela, tabela2, tabela3, tabela4)

