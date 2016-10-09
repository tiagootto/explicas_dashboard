
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
    
    search_data <- reactive({
        if("All" %in% input$search_input_local)
            searches_locals <- unique(searches$local)
        else
            searches_locals <- input$search_input_local
        if("All" %in% input$search_input_disciplina)
            searches_disciplinas <- unique(searches$disciplina)
        else
            searches_disciplinas <- input$search_input_disciplina
        if("All" %in% input$search_input_ip)
            searches_ips <- unique(searches$IP)
        else
            searches_ips <- input$search_input_ip
        
        
        searches[  searches$local %in% searches_locals  &   searches$disciplina %in% searches_disciplinas  & searches$IP %in% searches_ips   , c( "date", "local", "disciplina", "IP", "nr_resultados")]
        
    })
    
    output$search_datatable <- renderDataTable({search_data()})
    
    # output$search_local <- renderTable({unique(searches$local)})
    # output$search_disciplina <- renderTable({unique(searches$disciplina)})
    # output$search_ip <- renderTable({unique(searches$IP)})
    
    
    
    output$backofficetable <- renderDataTable({backoffice})
    
    
    

    
    
    
}