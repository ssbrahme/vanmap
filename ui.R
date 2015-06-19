library(shiny)
library(rCharts)
library(rjson)
###########
shinyUI(navbarPage("Navigation",
                          tabPanel("Spaces",
                                   headerPanel("Vancouver BC Cultural Spaces"),
                                   chartOutput('baseMap','leaflet'),
                                   tags$style('.leaflet {width: 960px;}'),
                                   tags$head(tags$script(src="leaflet-heat.js")),
                                   uiOutput('datamap')
                          )
))

# deployApp("C:/Users/sabra/Desktop/vanmap")
# https://leaflet.github.io/Leaflet.heat/dist/
# library(shinyapps)
# # shinyApp

