network_train<- function(datos){
    weigths<- c(
        cor(datos$event_1,datos$target_churn_indicator),
        cor(datos$event_2,datos$target_churn_indicator),
        cor(datos$event_3,datos$target_churn_indicator),
        cor(datos$event_4,datos$target_churn_indicator),
        cor(datos$event_5,datos$target_churn_indicator)
    )
    weigths<- (weigths + 1) / 2
    weigths<- weigths / sum(weigths)
    prob<- function(X){
        salida<- sum(X)/length(X)
        return(salida)
    }
    event1<- tapply(datos$target_churn_indicator, datos$event_1, prob)
    event2<- tapply(datos$target_churn_indicator, datos$event_2, prob)
    event3<- tapply(datos$target_churn_indicator, datos$event_3, prob)
    event4<- tapply(datos$target_churn_indicator, datos$event_4, prob)
    event5<- tapply(datos$target_churn_indicator, datos$event_5, prob)
    # Calculo de umbral
    datos$event_1<- as.character(datos$event_1)
    datos$event_2<- as.character(datos$event_2)
    datos$event_3<- as.character(datos$event_3)
    datos$event_4<- as.character(datos$event_4)
    datos$event_5<- as.character(datos$event_5)
    prueba<- numeric(length = nrow(datos))
    for(i in 1:nrow(datos)){
        prueba[i]<- event1[names(event1) == datos$event_1[i]]*weigths[1] +
            event2[names(event2) == datos$event_2[i]]*weigths[2] +
            event3[names(event3) == datos$event_3[i]]*weigths[3] +
            event4[names(event4) == datos$event_4[i]]*weigths[4] +
            event5[names(event5) == datos$event_5[i]]*weigths[5]
    }
    model<- list(
        Pesos=weigths,
        probabilidades=list(
            event1=event1,
            event2=event2,
            event3=event3,
            event4=event4,
            event5=event5
        ),
        Umbral=0.5,
        Error=mean(abs(round(prueba) - datos$target_churn_indicator))
    )
    return(model)
}

modelo<- network_train(Datos$Training_clean)

network_test<- function(modelo,datos){
    salida<- numeric(length = nrow(datos))
    for(i in 1:nrow(datos)){
        if(datos$event_1[i] %in% names(modelo$probabilidades$event1)){
            aux1<- modelo$probabilidades$event1[names(modelo$probabilidades$event1) == datos$event_1[i]]
        }
        else{
            aux1<- 0
        }
        if(datos$event_2[i] %in% names(modelo$probabilidades$event2)){
            aux2<- modelo$probabilidades$event2[names(modelo$probabilidades$event2) == datos$event_2[i]]
        }
        else{
            aux2<- 0
        }
        if(datos$event_3[i] %in% names(modelo$probabilidades$event3)){
            aux3<- modelo$probabilidades$event3[names(modelo$probabilidades$event3) == datos$event_3[i]]
        }
        else{
            aux3<- 0
        }
        if(datos$event_4[i] %in% names(modelo$probabilidades$event4)){
            aux4<- modelo$probabilidades$event4[names(modelo$probabilidades$event4) == datos$event_4[i]]
        }
        else{
            aux4<- 0
        }
        if(datos$event_5[i] %in% names(modelo$probabilidades$event5)){
            aux5<- modelo$probabilidades$event5[names(modelo$probabilidades$event5) == datos$event_5[i]]
        }
        else{
            aux5<- 0
        }
        salida[i]<- aux1*modelo$Pesos[1] + aux2*modelo$Pesos[2] + 
            aux3*modelo$Pesos[3] + aux4*modelo$Pesos[4] + aux5*modelo$Pesos[5]
        salida[i]<- ifelse(salida[i] < modelo$Umbral,0,1)
    }
    salida<- list(
        Estimado=salida,
        Error=mean(abs(salida - datos$target_churn_indicator))
    )
    return(salida)
}