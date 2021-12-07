library(shiny)
library(shinymanager)

inactivity <- "function idleTimer() {
var t = setTimeout(logout, 120000);
window.onmousemove = resetTimer; // catches mouse movements
window.onmousedown = resetTimer; // catches mouse movements
window.onclick = resetTimer;     // catches mouse clicks
window.onscroll = resetTimer;    // catches scrolling
window.onkeypress = resetTimer;  //catches keyboard actions

function logout() {
window.close();  //close the window
}

function resetTimer() {
clearTimeout(t);
t = setTimeout(logout, 120000);  // time is in milliseconds (1000 is 1 second)
}
}
idleTimer();"


# data.frame with credentials info
credentials <- data.frame(
    user = c("1", "fanny", "victor", "benoit"),
    password = c("1", "azerty", "12345", "azerty"),
    # comment = c("alsace", "auvergne", "bretagne"), %>% 
    stringsAsFactors = FALSE
)

ui <- secure_app(head_auth = tags$script(inactivity),
                 fluidPage(
                     # classic app
                     headerPanel('Iris k-means clustering'),
                     sidebarPanel(
                         selectInput('xcol', 'X Variable', names(iris)),
                         selectInput('ycol', 'Y Variable', names(iris),
                                     selected=names(iris)[[2]]),
                         numericInput('clusters', 'Cluster count', 3,
                                      min = 1, max = 9)
                     ),
                     mainPanel(
                         plotOutput('plot1'),
                         verbatimTextOutput("res_auth")
                     )
                     
                 ))

server <- function(input, output, session) {
    
    result_auth <- secure_server(check_credentials = check_credentials(credentials))
    
    output$res_auth <- renderPrint({
        reactiveValuesToList(result_auth)
    })
    
    # classic app
    selectedData <- reactive({
        iris[, c(input$xcol, input$ycol)]
    })
    
    clusters <- reactive({
        kmeans(selectedData(), input$clusters)
    })
    
    output$plot1 <- renderPlot({
        palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                  "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
        
        par(mar = c(5.1, 4.1, 0, 1))
        plot(selectedData(),
             col = clusters()$cluster,
             pch = 20, cex = 3)
        points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })
    
}


shinyApp(ui = ui, server = server)