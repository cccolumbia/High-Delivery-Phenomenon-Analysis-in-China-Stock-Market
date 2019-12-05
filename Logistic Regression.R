#Regression Data 1
RegData1 = data2[data2$Date %in% as.character(seq(2012,2017)),]
drop = c("stkname","Send_ratio", "PB","S")
RegData1 = RegData1[,!(names(RegData1) %in% drop)]
RegData1 = merge(RegData1, P_CME)
RegData1 = merge(RegData1, Ind_Price)
RegData1 = merge(RegData1, Return)
RegData1$Date = as.character(as.numeric(RegData1$Date)+1)
S = data2[,c("S","Date","stkcode")]
RegData1 = merge(RegData1, S)
#RegData1$S = ifelse(data2$)

#Regression 1 logit
drop = c("stkcode","Date", "Indcode")
RegData1_XY = RegData1[,!(names(RegData1) %in% drop)]
mylogit = glm(S ~ . , family = "binomial", data = RegData1_XY)
summary(mylogit)

#Regression 1 probit
myprobit = glm(S ~ . , family = binomial(link = "probit"), data = RegData1_XY)
summary(myprobit)




