
library(shinydashboard)

function(input, output, session) {
    set.seed(122)
    histdata <- rnorm(500)
    
    
    output$plot1 <- renderPlot({
        data <- histdata[seq_len(input$slider)]
        hist(data)
    })
    
    output$search <- renderPlot({
        print(input$search_time_view)
        
        searches_aggr <- switch(input$search_time_view,
               weekly = aggregate(formula = IP ~ date_week, data = searches, FUN = function(x){length(unique(x))} ),
               monthly = aggregate(formula = IP ~ date_month, data = searches, FUN = function(x){length(unique(x))} ),
               yearly = aggregate(formula = IP ~ date_year, data = searches, FUN = function(x){length(unique(x))} )
               
               )
        print(searches_aggr)
        plot(searches_aggr,
             type = "l",
             main = "Evolution of Number of Sessions with Search",
             xlab = "Date",
             ylab = "Number of sessions with Search")
    })
    
    output$search_datatable <- renderDataTable({searches[, c( "date", "local", "disciplina", "IP", "nr_resultados")]})
    output$backofficetable <- renderDataTable({backoffice})

    
    
    
}