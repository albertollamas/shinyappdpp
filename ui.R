library(shiny)
library(ggplot2)
data("mpg")
library(plotly)


fluidPage(

    tabsetPanel(
        tabPanel("Highway mileage", fluid = TRUE,
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput("sliderdispl_hwy", 
                                     "What is the volume of the engine?", 
                                     0.1, 8, value = 4,step=0.1),
                         selectInput("year_hwy",
                                     "Year:",
                                     c("All",
                                       unique(as.character(mpg$year))))
                     ),
                     mainPanel(
                         "Highway mileage", br(), br(),
                         h2(uiOutput("repo")),
                         br(), 
                         p("On this tab The app fits a linear model (highway 
                         mileage vs displacement) using the mpg dataset,
                         you can choosee to use the whole dataset, or you can
                         filter by year (1999 or 2008).It also plots your
                         selection. If you hoover over the points it shows the 
                         displacement and mileage, as well as the maker and 
                         model. If you hoover over the line it shows the fitted
                         value for the mileage. The app also displays the 
                         predicted value for the imput on the slider. Finally
                         it shows a table with the lm coefficients. ",
                         span("On the next tab the app fits an analogue model 
                              for the city mileage", style = "color:blue")),
                         br(), 
                         plotlyOutput("plot_hwy"),
                         h3("Predicted Highway mileage from Model 1:"),
                         textOutput("pred_hwy"),
                         h3("Coefficients from Model 1:"),
                         tableOutput("summary_model_hwy")), 
                 )
        ),
        tabPanel("City mileage", fluid = TRUE,
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput("sliderdispl_cty", 
                                     "What is the volume of the engine?", 
                                     0.1, 8, value = 4,step=0.1),
                         selectInput("year_cty",
                                     "Year:",
                                     c("All",
                                       unique(as.character(mpg$year))))
                     ),
                     mainPanel("City mileage", br(), 
                               plotlyOutput("plot_cty"),
                               h3("Predicted Highway mileage from Model 1:"),
                               textOutput("pred_cty"),
                               h3("Coefficients from Model 1:"),
                               tableOutput("summary_model_cty"))
                 )
        )
    )
)
