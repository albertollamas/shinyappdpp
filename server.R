library(shiny)
library(ggplot2)
data("mpg")
library(plotly)


function(input, output, session) {

    filtered_rows_hwy <- reactive({
        mpg2 <- mpg
        if (input$year_hwy != "All") {
            mpg2 <- mpg2[mpg2$year == as.numeric(input$year_hwy),]
        }
        mpg2
    })
    
    model_hwy <- reactive({
        lm(hwy ~ displ, data = filtered_rows_hwy())
    })
    
    model_hwypred <- reactive({
        displInput_hwy <- input$sliderdispl_hwy
        predict(model_hwy(), newdata = data.frame(displ = displInput_hwy))
    })
    
    output$plot_hwy <- renderPlotly({
        ggplotly(ggplot(filtered_rows_hwy(), aes(x = displ, y = hwy, 
                     text = paste(manufacturer, model), group = 1)) +
                     theme_bw()+
                     theme(panel.grid.major = element_blank(), 
                           panel.grid.minor = element_blank(),
                           panel.border = element_blank(), 
                           axis.line = element_line())+
                     geom_point() + 
                     geom_smooth(method = "lm", se = FALSE) +
                     ggtitle("Highway mileage vs Engine volume") +
                     xlab("Engine volume (l)") +
                     ylab("Highway mileage (mpg)"), 
                     tooltip = c("x", "y", "text"))
    })
    
    output$pred_hwy <- renderText({
        paste0("Predicted highway mileage: ", round(model_hwypred(), 2))
    })
    
    output$summary_model_hwy <- renderTable({
        summary(model_hwy())$coefficients
    })
    
    url <- a("Google Homepage", href="https://www.google.com/")
    output$repo <- renderUI({
        tagList("URL link:", url)
    }) 
    
    filtered_rows_cty <- reactive({
        mpg3 <- mpg
        if (input$year_cty != "All") {
            mpg3 <- mpg3[mpg3$year == as.numeric(input$year_cty),]
        }
        mpg3
    })
    
    model_cty <- reactive({
        lm(cty ~ displ, data = filtered_rows_cty())
    })
    
    model_ctypred <- reactive({
        displInput_cty <- input$sliderdispl_cty
        predict(model_cty(), newdata = data.frame(displ = displInput_cty))
    })
    
    output$plot_cty <- renderPlotly({
        ggplotly(ggplot(filtered_rows_cty(), aes(x = displ, y = cty, 
                     text = paste(manufacturer, model), group = 1)) +
                     theme_bw()+
                     theme(panel.grid.major = element_blank(), 
                           panel.grid.minor = element_blank(),
                           panel.border = element_blank(), 
                           axis.line = element_line())+
                     geom_point() + 
                     geom_smooth(method = "lm", se = FALSE) +
                     ggtitle("City mileage vs Engine volume") +
                     xlab("Engine volume (l)") +
                     ylab("City mileage (mpg)"), 
                     tooltip = c("x", "y", "text"))
        
    })
    
    output$pred_cty <- renderText({
        paste0("Predicted city mileage: ", round(model_ctypred(), 2))
    })
    
    output$summary_model_cty <- renderTable({
        summary(model_cty())$coefficients
    })
}
