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
    best_model<-lm(mpg ~ am+hp+wt+disp+qsec,data=mtcars)
    
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
        
        if (input$variable == "am") {
            
            mpgData <- data.frame(mpg = mtcars$mpg, var = factor(mtcars[[input$variable]], labels = c("Automatic", "Manual")))
            p <- ggplot(mpgData, aes(var, mpg,fill=var)) + 
                geom_boxplot(alpha=0.3) + 
                xlab(input$variable)+scale_fill_brewer(palette="BuPu")
            print(p)
            
        }
        else if(input$variable == "cyl"|input$variable == "vs"|input$variable == "gear"|input$variable == "carb"){
            
            mpgData <- data.frame(mpg = mtcars$mpg, var = factor(mtcars[[input$variable]]))
            p <- ggplot(mpgData, aes(var, mpg,fill=var)) + 
                geom_boxplot(alpha=0.3) + 
                xlab(input$variable)+scale_fill_brewer(palette="BuPu")
            print(p)
            
        }
        else{
            output$simpletext<-renderText({
                
                
                if (input$variable!= "am"|input$variable != "cyl"|input$variable!= "vs"|input$variable!= "gear"|input$variable!= "carb"){
                    
                    print("We don't have a categorical grouping variable!")
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
    
    output$bestvariablesubsets<-renderPrint({
        
        if(input$show)
        {ols_step_best_subset(full_model,details=TRUE)}
        else{"Check Show Hide Best Variable Subsets and Press Submit Button"}
        
    })
    
    output$fullmodel<-renderText({
        
        if(input$multimodel)
        {print("mpg ~ am+cyl+hp+wt+disp+hp+drat+qsec+gear+carb")}
    })
    
    output$variablenumber<-renderPrint({
        
        if(input$variablenum)
        {adjr<-ols_step_best_subset(fit_multivariable_full,details = TRUE)$adjr
        which(adjr==max(adjr))}
        else{"Check Show Hide Best Variable Number and Press Submit Button"}
        
    })
    
    output$bestvariables<-renderPrint({
        
        if(input$variables)
        {
            adjr<-ols_step_best_subset(fit_multivariable_full,details = TRUE)$adjr
            var<-ols_step_best_subset(fit_multivariable_full,details = TRUE)$predictors[which(adjr==max(adjr))]
            print(var)
        }
        else{"Check Show Hide Best Variables and Press Submit Button"}
        
    })
    
    
    output$multisummary2<-renderPrint({
        summary(best_model)
        
        
    })
    output$multiresidual2<-renderPlot({
        
        par(mfrow = c(2, 2))
        plot(best_model)
    })
})