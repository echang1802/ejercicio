
library(shiny)
library(plotly)
library(shinythemes)
library(markdown)
datos<- load("Datos.RData")

ui <- fluidPage(theme = "simplex",
                uiOutput("Principal")
  
)

server <- function(input, output, session) {
  
    output$Principal<- renderUI({
        return(NULL)
    })
    
    output$Logo<- renderImage({
        list(src = "logo_etermax.png",width = 501,height = 207)
    },deleteFile = FALSE)
    
    showModal(modalDialog(
        title="",
        imageOutput("Logo",width = 501,height = 207),
        fluidRow(
            column(width = 5),
            column(width = 7,actionButton(inputId = "StartApp",label = "INICIAR"))
        ),
        footer = tags$h5("Autor: Eloy Chang")
    ))
    
    observeEvent(input$StartApp,{
        removeModal()
        
        output$Logosmall<- renderImage({
            list(src = "image.jpg",width = 221,height = 50)
        },deleteFile = FALSE)
        
        output$Logosmall2<- renderImage({
            list(src = "image.jpg",width = 221,height = 50)
        },deleteFile = FALSE)
        
        output$Logosmall3<- renderImage({
            list(src = "image.jpg",width = 221,height = 50)
        },deleteFile = FALSE)
        
        output$Principal<- renderUI({
            
            # ----| Tab: Exploracion |----
            
            output$Resumen<- renderUI({
                if(input$VarExp == "platform"){
                    android<- Datos$Training_clean$platform=="Android"
                    ios<- Datos$Training_clean$platform=="iOS"
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 4,
                            tags$h3(paste("Android: ",sum(android)," | ",
                                          round(100*sum(Datos$Training_clean$target_churn_indicator[android]) /
                                              sum(android),2),"%", sep = ""))
                        ),
                        column(width = 5,
                            tags$h3(paste("iOS: ",sum(ios)," | ",
                                        round(100*sum(Datos$Training_clean$target_churn_indicator[ios]) /
                                                   sum(ios),2),"%", sep = ""))
                        )
                    )
                }
                else if(input$VarExp == "country_region"){
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 9,
                            tags$h3(paste("REGIONES:",length(unique(Datos$Training_clean$country_region))))
                        )
                    )
                }
                else if(input$VarExp == "city"){
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 9,
                               tags$h3(paste("CIUDADES:",length(unique(Datos$Training_clean$city))))
                        )
                    )
                }
                else if(input$VarExp == "gender"){
                    android<- Datos$Training_clean$gender=="male"
                    ios<- Datos$Training_clean$gender=="female"
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 4,
                               tags$h3(paste("HOMBRE: ",sum(android)," | ",
                                             round(100*sum(Datos$Training_clean$target_churn_indicator[android]) /
                                                       sum(android),2),"%", sep = ""))
                        ),
                        column(width = 5,
                               tags$h3(paste("MUJER: ",sum(ios)," | ",
                                             round(100*sum(Datos$Training_clean$target_churn_indicator[ios]) /
                                                       sum(ios),2),"%", sep = ""))
                        )
                    )
                }
                else if(input$VarExp == "min_age_range"){
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 3,
                            tags$h3(paste("MÍN:",min(Datos$Training_clean$min_age_range)))
                        ),
                        column(width = 3,
                               tags$h3(paste("AVG:",round(mean(Datos$Training_clean$min_age_range))))
                        ),
                        column(width = 3,
                               tags$h3(paste("MÁX:",max(Datos$Training_clean$min_age_range)))
                        )
                    )
                }
                else if(input$VarExp == "max_age_range"){
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 3,
                               tags$h3(paste("MÍN:",min(Datos$Training_clean$max_age_range)))
                        ),
                        column(width = 3,
                               tags$h3(paste("AVG:",round(mean(Datos$Training_clean$max_age_range))))
                        ),
                        column(width = 3,
                               tags$h3(paste("MÁX:",max(Datos$Training_clean$max_age_range)))
                        )
                    )
                }
                else if(input$VarExp == "event_1"){
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 3,
                               tags$h3(paste("MÍN:",min(Datos$Training_clean$event_1)))
                        ),
                        column(width = 3,
                               tags$h3(paste("AVG:",round(mean(Datos$Training_clean$event_1))))
                        ),
                        column(width = 3,
                               tags$h3(paste("MÁX:",max(Datos$Training_clean$event_1)))
                        )
                    )
                }
                else if(input$VarExp == "event_2"){
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 3,
                               tags$h3(paste("MÍN:",min(Datos$Training_clean$event_2)))
                        ),
                        column(width = 3,
                               tags$h3(paste("AVG:",round(mean(Datos$Training_clean$event_2))))
                        ),
                        column(width = 3,
                               tags$h3(paste("MÁX:",max(Datos$Training_clean$event_2)))
                        )
                    )
                }
                else if(input$VarExp == "event_3"){
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 3,
                               tags$h3(paste("MÍN:",min(Datos$Training_clean$event_3)))
                        ),
                        column(width = 3,
                               tags$h3(paste("AVG:",round(mean(Datos$Training_clean$event_3))))
                        ),
                        column(width = 3,
                               tags$h3(paste("MÁX:",max(Datos$Training_clean$event_3)))
                        )
                    )
                }
                else if(input$VarExp == "event_4"){
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 3,
                               tags$h3(paste("MÍN:",min(Datos$Training_clean$event_4)))
                        ),
                        column(width = 3,
                               tags$h3(paste("AVG:",round(mean(Datos$Training_clean$event_4))))
                        ),
                        column(width = 3,
                               tags$h3(paste("MÁX:",max(Datos$Training_clean$event_4)))
                        )
                    )
                }
                else if(input$VarExp == "event_5"){
                    salida<- fluidRow(
                        column(width = 3),
                        column(width = 3,
                               tags$h3(paste("MÍN:",min(Datos$Training_clean$event_5)))
                        ),
                        column(width = 3,
                               tags$h3(paste("AVG:",round(mean(Datos$Training_clean$event_5))))
                        ),
                        column(width = 3,
                               tags$h3(paste("MÁX:",max(Datos$Training_clean$event_5)))
                        )
                    )
                }
                return(salida)
            })
            
            output$Correlacion<- renderUI({
                if(class(Datos$Training_clean[,input$VarExp]) == "numeric"){
                    salida<- tags$h2(paste("CORRELACIÓN:",
                                           round(cor(Datos$Training_clean[,input$VarExp],
                                               Datos$Training_clean$target_churn_indicator,
                                               use = "complete.obs"),4)))
                }
                else{
                    aux<- as.numeric(as.factor(Datos$Training_clean[,input$VarExp]))
                    salida<- tags$h2(paste("CORRELACIÓN:",
                                           round(cor(aux,Datos$Training_clean$target_churn_indicator,
                                               use = "complete.obs"),4)))
                }
                return(salida)
            })
            
            output$FilaGrafico<- renderUI({
                
                output$GraficoExp<- renderPlotly({
                    aux<- data.frame(
                        var=unique(Datos$Training_clean[,input$VarExp]),
                        pr=0
                    )    
                    if(class(aux$var)=="factor") aux$var<- as.character(aux$var)
                    for(i in 1:nrow(aux)){
                        p<- which(Datos$Training_clean[,input$VarExp] == aux$var[i])
                        aux$pr[i]<- round(100*sum(Datos$Training_clean$target_churn_indicator[p] /
                                                      length(p)))
                    }
                    plot_ly(data = aux, x = ~var, y = ~pr, type = "bar",
                            hovertext = ~paste(var,": ",pr,"%", sep = "")) %>%
                        layout(title = paste("Probabilidad de Éxito dado",input$VarExp),
                               xaxis = list(title = input$VarExp),
                               yaxis = list(title = "Probabilidad de Éxito"))
                })
                
                salida<- fluidRow(
                    column(width = 3),
                    column(width = 9,
                        plotlyOutput("GraficoExp")
                    )
                )
                
            })
            
            # ----| Tab: Evaluacion |-----
            
            output$StatsModel<- renderTable({
                aux<- data.frame(
                    Estadistico=c("Aciertos","Tiempo de entrenamiento","Promedio tiempo de estimación"),
                    Resultado=c("67.1%","1.03033 s","0.00016 s")
                )
                names(aux)<- c("Estadístico","Resultado")
                return(aux)
            })
            
            output$BarResult<- renderPlotly({
                aux<- data.frame(
                    x=c("Aciertos","Desaciertos"),
                    y=c(4026,1974)
                )
                plot_ly(data = aux, x = ~x, y = ~y, type = "bar") %>%
                    layout(title = "Número de aciertos y desaciertos",
                           xaxis = list(title = "", zeroline = FALSE),
                           yaxis = list(title = "", zeroline = FALSE))
            })
            
            output$TestHistory<- renderPlotly({
                aux<- data.frame(
                    x=1:nrow(Datos$Test),
                    y=cumsum(Datos$Test$target_churn_indicator==prueba$Estimado)
                )
                aux$y<- aux$y / aux$x
                plot_ly(data = aux, x = ~x, y = ~y, type = "scatter", mode = "lines",
                        hovertext = ~paste("Prueba #",x,"\nPorcentaje de aciertos: ",
                                           round(100*y,2),"%",sep = "")) %>%
                    layout(title = "Histórico de pruebas",
                           xaxis = list(title = "Pruebas", zeroline = FALSE, 
                                        showticklabels = FALSE),
                           yaxis = list(title = "Porcentaje de aciertos", zeroline = FALSE,
                                        showticklabels = FALSE))
            })
            
            salida<- navbarPage(title = "ETERMAX",
                # ----| Tab: Exploracion |----
                tabPanel(title = "EXPLORACIÓN",
                    mainPanel(width = 12,
                        imageOutput("Logosmall",width = 221,height = 50),
                        fluidRow(
                            column(width = 3,
                                   selectInput(inputId = "VarExp",label = "VARIABLE A EXPLORAR",
                                               choices = names(Datos$Training_clean)[-c(1,2,14)])
                            ),
                            column(width = 9,
                                uiOutput("Correlacion")
                            )
                        ),
                        uiOutput("Resumen"),
                        uiOutput("FilaGrafico")
                        
                    )
                ),
                # ----| Tab: Evaluacion |----
                tabPanel(title = "EVALUACIÓN",
                    mainPanel(width = 12,
                        imageOutput("Logosmall2",width = 221,height = 50),
                        fluidRow(
                            column(width = 4,
                                tableOutput("StatsModel"),
                                plotlyOutput("BarResult")
                            ),
                            column(width = 8,
                                plotlyOutput("TestHistory")
                            )
                        )
                    )
                ),
                # ----| Tab: Informe |----
                tabPanel(title = "INFORME",
                    mainPanel(width = 12,
                        imageOutput("Logosmall3",width = 221,height = 50),
                        includeMarkdown("informe.md")
                    )
                )
            )
        })
        
    })
    
}

shinyApp(ui, server)