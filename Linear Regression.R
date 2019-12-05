#Regression Data 2
Send_ratio = data2[,c("Send_ratio","Date","stkcode")]
RegData2 = RegData1[, (names(RegData1) != "S")]
RegData2 = merge(RegData2, Send_ratio)

#Regression 2
drop = c("stkcode","Date", "Indcode")
RegData2_XY = RegData2[,!(names(RegData1) %in% drop)]
mymodel = lm(Send_ratio ~. , data = RegData2_XY)
summary(mymodel)