library(shiny)
library(ggplot2)
library(olsrr)
data(mtcars)

mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)
mtcars$am <- factor(mtcars$am,labels=c("Automatic","Manual"))

shinyServer(function(input, output) {
    
    full_model<-lm(mpg ~ am+cyl+hp+wt+disp+hp+drat+qsec+gear+carb,data=mtcars)
    
    formula<-reactive({
        paste("mpg ~", input$variable)
        
    })
    fit_simple<-reactive({
        lm(as.formula(formula()),data=mtcars)
    })
    
    output$model<-renderText({
        if(input$simple_model)
        {formula()}
    })
    
    
    output$simpleboxplot <- renderPlot({
        # check for the input variable
        if (input$variable == "am") {
            # am
            mpgData <- data.frame(mpg = mtcars$mpg, var = factor(mtcars[[input$variable]], labels = c("Automatic", "Manual")))
            p <- ggplot(mpgData, aes(var, mpg,fill=var)) + 
                geom_boxplot(alpha=0.3) + 
                xlab(input$variable)+scale_fill_brewer(palette="BuPu")
            print(p)
            
        }
        else if(input$variable == "cyl"|input$variable == "vs"|input$variable == "gear"|input$variable == "carb"){
            # cyl and gear
            mpgData <- data.frame(mpg = mtcars$mpg, var = factor(mtcars[[input$variable]]))
            p <- ggplot(mpgData, aes(var, mpg,fill=var)) + 
                geom_boxplot(alpha=0.3) + 
                xlab(input$variable)+scale_fill_brewer(palette="BuPu")
            print(p)
            
        }
        else{
            output$simpletext<-renderText({
                
                
                if (input$variable!= "am"|input$variable != "cyl"|input$variable!= "vs"|input$variable!= "gear"|input$variable!= "carb"){
                    
                    print("Don't have a categorical variable!")
                }
                
            })
            
        }
        
    })
    
    
    output$simplesummary<-renderPrint({
        summary(fit_simple())
    })
    
    
    output$simpleresidual<-renderPlot({
        
        par(mfrow = c(2, 2))
        plot(fit_simple())
    })
    
    
    output$multisummary<-renderPrint({
        summary(full_model)
        
        
    })
    
    output$multiresidual<-renderPlot({
        
        par(mfrow = c(2, 2))
        plot(full_model)
    })
    
    
    output$fullmodel<-renderText({
        
        if(input$multimodel)
        {print("mpg ~ am+cyl+hp+wt+disp+hp+drat+qsec+gear+carb")}
    })
    
    
})