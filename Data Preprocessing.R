# Data loading
data = read.csv("data.csv", as.is = TRUE)
colnames(data) = c("stkcode","stkname",
                   paste("RPS",seq(2011,2018,1),sep=""),
                   paste("PPS",seq(2011,2018,1),sep=""),
                   paste("Size",seq(2011,2018,1),sep=""),
                   paste("ROE",seq(2011,2018,1),sep=""),
                   paste("Send_ratio",seq(2011,2018,1),sep=""),
                   paste("RegDate",seq(2011,2018,1),sep=""),
                   paste("ExDate",seq(2011,2018,1),sep=""),
                   paste("Close",seq(2011,2018,1),sep=""),
                   "Indcode",
                   paste("Sigma",seq(2011,2018,1),sep=""),
                   paste("PB",seq(2011,2018,1),sep="")
)
options(scipen=200)

#Remove Dates
drop = c(paste("RegDate",seq(2011,2018,1),sep=""),
         paste("ExDate",seq(2011,2018,1),sep=""))
data = data[,!(names(data) %in% drop)]

#Industry code 2-digit 
#remove Financials
data$Indcode = as.character(data$Indcode)
data$Indcode = substr(data$Indcode,3,4)
data = data[data$Indcode != "40",] 

# Size to integar
Size = data[,paste("Size",seq(2011,2018,1),sep="")]
for (i in names(Size)) {
  Size[,i] = as.character(Size[,i])
  Size[,i] = substr(Size[,i],1,nchar(Size[,i])-5)
  Size[,i] = as.numeric(gsub(pattern = ",", replacement = "", x = Size[,i]))
}
data[,paste("Size",seq(2011,2018,1),sep="")] = Size

# Send_ratio Fill NA
Send_ratio = data[,paste("Send_ratio",seq(2011,2018,1),sep="")]
Send_ratio[is.na(Send_ratio)] = 0
data[,paste("Send_ratio",seq(2011,2018,1),sep="")] = Send_ratio

# Drop NA
data[data == " "] = NA
data = data[complete.cases(data),]

#Drop ST
STname = data$stkname[grep(pattern = "ST",x= data$stkname)]
data = data[!data$stkname %in% STname, ]

#Restructure data
AnuCols = c("RPS","PPS","Size","ROE","Send_ratio","Close","Sigma","PB")
data2 = data.frame()
for ( i in as.character(seq(2011,2018))){
  res = data[,c("stkcode","stkname","Indcode")]
  res$Date = i
  for ( j in AnuCols ){
    res[ , j] = data[ ,paste(j, i, sep = "")]
  }
  data2 = rbind(data2, res)
}

# Calculate variables 
library(plyr)
library(dplyr)
# S
data2$S = ifelse(data2$Send_ratio < 0.5, 0, 1)

# P_CME 
data2$PB = as.numeric(data2$PB)
data2$Close = as.numeric(data2$Close)
data2 = data2[complete.cases(data2),]
P_CME = c()
for (i in as.character(seq(2011,2018))){
  Close_L = as.numeric(quantile(data2[data2$Date == i, "Close"], probs = 0.3))
  Close_H = as.numeric(quantile(data2[data2$Date == i, "Close"], probs = 0.7))
  log_AvgPB_L = log(mean(unlist(subset(data2[data2$Date == i, ], Close <= Close_L, select = PB))))
  log_AvgPB_H = log(mean(unlist(subset(data2[data2$Date == i, ], Close >= Close_H, select = PB))))
  P_CME = c(P_CME, log_AvgPB_L - log_AvgPB_H)
}
P_CME = data.frame(P_CME)
P_CME$Date = as.character(seq(2011,2018))

# Ind_Price
#library(dplyr)
Ind_Price = data2 %>%
  group_by(Date, Indcode) %>% 
  summarise( mean_t = mean(Close))
colnames(Ind_Price) = c("Date", "Indcode", "Ind_Price")

# Return
Return = function(stkdata){
  # stkdata = data2[data2$stkcode == "000002.SZ",]
  stkdata = stkdata[order(stkdata$Date, decreasing = FALSE),]
  Close = stkdata[-1,]$Close
  Close_1 = stkdata[-nrow(stkdata),]$Close
  logReturn = log(Close/Close_1)
  ret = data.frame(Date =as.character(seq(stkdata$Date[2],
                                          stkdata$Date[nrow(stkdata)])), 
                   Return = logReturn)
  return(ret)
}


Return = ddply(data2, .(stkcode), Return)
#Return

data2$ROE = as.numeric(data2$ROE)
data2$Sigma = as.numeric(data2$Sigma)
data2 = data2[complete.cases(data2),]











