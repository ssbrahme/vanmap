library(shiny)
library(rCharts)
library(rjson)
library(plyr)
library(sqldf)
##################
shinyServer(function(input,output){
####  c1 <- read.csv("https://dl.dropboxusercontent.com/u/3709256/CulturalSpaces.csv")
c1 <- read.csv("ftp://webftp.vancouver.ca/opendata/CulturalSpace/CulturalSpaces.csv")  
c2 <- c1[is.na(c1$NUMBER_OF_SEATS)==F,]
  maindata    <- sqldf('select LATITIUDE as Lat, LONGITUDE as Lon, sum(NUMBER_OF_SEATS) as Capacity from c2  group by LATITIUDE,LONGITUDE')
  output$baseMap<-renderMap({
    baseMap<-Leaflet$new()
    baseMap$setView(c(49.271, -123.125), 12)
    baseMap$tileLayer( 'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}.png')
#     https://stamen-tiles.a.ssl.fastly.net
# http://{s}.tile.stamen.com/toner-lite/{z}/{x}/{y}.png
    #     basemap$fullScreen(TRUE)
    baseMap
  })
  output$datamap<-renderUI({
    nowmax<-max(maindata$Capacity)
    dataJSON<-toJSONArray2(maindata,json=F,names=F)
    dataJSON2<-rjson::toJSON(dataJSON)
    tags$body(tags$script(HTML(sprintf("
                                       var addressPoints = %s
                                       var maxval = %f
                                       var heat = L.heatLayer(addressPoints, {blur:12, radius:7, max: 1, gradient:{0.4:'#2952CC'  , 0.5: '#7ACC29' , 0.1: '#EEEE5C' },minOpacity:1 }).addTo(map)
                                       </script>",dataJSON2,nowmax
    ))))
  })
})
