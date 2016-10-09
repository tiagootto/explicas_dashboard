library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "Explicas-me Metrics"),
    dashboardSidebar(
        sidebarMenu(
           # menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
            menuItem("Metrics Overview", tabName = "overview", icon = icon("bar-chart")),
            menuItem("BackOffice", tabName = "backoffice", icon = icon("code")),
            menuItem("Payments", tabName = "carregamentos", icon = icon("credit-card")),
            menuItem("Follow-up", tabName = "followup", icon = icon("comment")),
            menuItem("Stats", tabName = "stats", icon = icon("cube"), menuSubItem("Users", tabName = "stats_users" ) ),
            
            menuItem("Search", tabName = "search", icon = icon("search"))
        )
        
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "overview",
                    fluidRow(
                        infoBox("New Payments", 10, icon = icon("euro"), fill = TRUE, color = "blue"),
                        infoBox("New Propostas", 30, icon = icon("arrow-up"), fill = TRUE, color = "green"),
                        infoBox("New Students", 10 * 2, icon = icon("arrow-down"), fill = TRUE, color = "orange"),
                        infoBox("New Carregamentos", 2, icon = icon("euro"), fill = F, color = "yellow"),
                        infoBox("New Profs", 10 * 2, icon = icon("check"), fill = F, color = "navy"),
                        infoBox("New Respostas", 10 * 2, icon = icon("remove"), fill = F, color = "orange")
    
                    )
            ),
            
            
            tabItem(tabName = "dashboard",
                    fluidRow(
                        box(plotOutput("plot1", height = 250)),
                        
                        box(
                            title = "Controls",
                            sliderInput("slider", "Number of observations:", 1, 100, 50)
                        )
                    )
            ),
            
            # Second tab content
            tabItem(tabName = "search",
                    h2("Search"),
                    selectizeInput(inputId = "search_time_view", label =  "Select View", choices = c("weekly", "monthly", "yearly")),
                    dateRangeInput('search_dateRange',
                                   label = 'Filter by Date',
                                   start = search_min_date,
                                   end = search_max_date
                    ),
                    plotOutput("search"),
                    dataTableOutput("search_datatable")
            ),
            tabItem(tabName = "backoffice",
                    h2("Back Office"),
                    dateRangeInput('backoffice_dateRange',
                                   label = 'Filter by Date',
                                   start = search_min_date,
                                   end = search_max_date
                    ),
                    dataTableOutput("backofficetable")
            )
            
            
            
        )
    )
)