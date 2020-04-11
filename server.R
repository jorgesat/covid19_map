#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    data <- reactive({
        x <- casos
    }) 
    
    output$mapa_cov <- renderLeaflet({
        casos <- datacov2
        
        m <- leaflet(data = casos, options = leafletOptions(minZoom = 4, maxZoom = 4)) %>%
            addTiles() %>%
            # addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
            addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
            addCircleMarkers(
                lng = ~Long, 
                lat = ~Lat,
                weight = 3, 
                # radius=40,
                radius = ~log(confirmed),
                color = "#ff7761",
                stroke = FALSE, fillOpacity = 0.8,
                popup = paste(casos$country, "<br>",
                              "<b>Casos confirmados: </b>", casos$confirmed, "<br>",
                              "<b>Fallecidos: </b>", casos$death)
            ) %>%
            # addCircleMarkers(
            #     lng = ~Long, 
            #     lat = ~Lat,
            #     weight = 3, 
            #     # radius=40,
            #     radius = ~log(death),
            #     color = "#ff7473",
            #     stroke = FALSE, fillOpacity = 0.5,
            #     popup = paste(casos$country, "<br>",
            #                   "<b>Casos confirmados: </b>", casos$confirmed, "<br>",
            #                   "<b>Fallecidos: </b>", casos$death)
            # ) %>%
            setView(lng=-75, lat=-12 , zoom=4)
        m
    }) 

 

})
