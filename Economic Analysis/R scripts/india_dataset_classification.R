install.packages("devtools")
install.packages("Boruta")
install.packages("dplyr")
install.packages("ggplot2")
library(Boruta)
library(dplyr)
library(ggplot2)
library(devtools)
devtools::install_github("jcizel/FredR")
library(FredR)
api.key = '279ee2107d6af68091c9a242441732d3'
fred <- FredR(api.key)
str(fred,1)
gdp.series <- fred$series.search("GDP")
#gdp in billions of rupees
gdp_data <- fred$series.observations(series_id = 'INDGDPNQDSMEI')
gdp_data[,1:2]<-NULL
colnames(gdp_data)[2] <- "GDP"
#newRow <- data.frame(date="2016-10-01",value="29628.34")
#gdp_data <- rbind(gdp_data,newRow)
View(gdp_data)
population <- fred$series.observations(series_id = 'POPTOTINA647NWDB') #number of persons
population[,1:2]<-NULL
colnames(population)[2] <- "Population"
View(population)

cpi <- fred$series.observations(series_id = 'INDCPIALLQINMEI')
cpi[,1:2]<-NULL
colnames(cpi)[2] <- "CPI"
View(cpi)
wpi <- fred$series.observations(series_id = 'WPOTFD01INQ661N') #ppi
wpi[,1:2]<-NULL
colnames(wpi)[2] <- "WPI"
View(wpi)
import <- fred$series.observations(series_id = 'INDIMPORTQDSMEI')
import[,1:2]<-NULL
colnames(import)[2] <- "Import"
View(import)
export <- fred$series.observations(series_id = 'INDEXPORTQDSMEI')
export[,1:2]<-NULL
colnames(export)[2] <- "Export"
View(export)
M3 <- fred$series.observations(series_id = 'MABMM301INQ189S')
M3[,1:2]<-NULL
colnames(M3)[2] <- "M3"
View(M3) #money supply  
unemployment<-fred$series.observations(series_id = 'SLUEM1524ZSIND')
unemployment[,1:2]<-NULL
colnames(unemployment)[2] <- "Unemployment"
View(unemployment)
ppp<-fred$series.observations(series_id = 'RGDPCHINA625NUPN')
ppp[,1:2]<-NULL
colnames(ppp)[2] <- "PPP"
View(ppp)
inflation_rate<-fred$series.observations(series_id = 'FPCPITOTLZGIND')
inflation_rate[,1:2]<-NULL
colnames(inflation_rate)[2] <- "Inflation_Rate"
View(inflation_rate)
industrial_production<-fred$series.observations(series_id = 'INDPROINDQISMEI')
industrial_production[,1:2]<-NULL
colnames(industrial_production)[2] <- "Industrial_Production"
View(industrial_production)
market_capitalization<-fred$series.observations(series_id = 'DDDM01INA156NWDB')
market_capitalization[,1:2]<-NULL
colnames(market_capitalization)[2] <- "Market_Capitalization"
View(market_capitalization)
exchange_rate<-fred$series.observations(series_id = 'CCUSSP02INQ650N') #US Dollar per National Currency Units
exchange_rate[,1:2]<-NULL
colnames(exchange_rate)[2] <- "Exchange_Rate"
View(exchange_rate)  
internation_debt<-fred$series.observations(series_id = 'IDSGAMNIAOIN') #usd millions
internation_debt[,1:2]<-NULL
colnames(internation_debt)[2] <- "International_Debt"
View(internation_debt)
interest_rate<-fred$series.observations(series_id = 'IRSTCI01INQ156N')
interest_rate[,1:2]<-NULL
colnames(interest_rate)[2] <- "Interest_Rate"
View(interest_rate)

dataset0 <- left_join(gdp_data,population,by=c("date"="date"))
dataset1 <- left_join(dataset0,cpi,by=c("date"="date"))
dataset2 <- left_join(dataset1,wpi,by=c("date"="date"))
dataset3 <- left_join(dataset2,import, by=c("date"="date"))
dataset4 <- left_join(dataset3,export, by=c("date"="date"))
dataset5 <- left_join(dataset4,M3, by=c("date"="date"))
dataset6 <- left_join(dataset5,unemployment, by=c("date"="date"))
dataset61<- left_join(dataset6,ppp, by=c("date"="date"))
dataset7 <- left_join(dataset61,inflation_rate, by=c("date"="date"))
dataset8 <- left_join(dataset7,industrial_production, by=c("date"="date"))
dataset9 <- left_join(dataset8,market_capitalization, by=c("date"="date"))
dataset10 <- left_join(dataset9,exchange_rate, by=c("date"="date"))
dataset11 <- left_join(dataset10,internation_debt, by=c("date"="date"))
dataset_India<-left_join(dataset11,interest_rate, by=c("date"="date"))
View(dataset_India)

dataset_India$Population[1]<-979290432
dataset_India$PPP[1]<-1638.486596
dataset_India$Unemployment[1]<-8.89999961853027
dataset_India$Inflation_Rate[1]<-8.9771490750816
dataset_India$Market_Capitalization[1]<-30.41661
colnames(dataset_India)[1]<-"Date"
dataset_India$Date <- as.Date(dataset_India$Date)

dataset_India$Population<-as.numeric(dataset_India$Population)
dataset_India$GDP<-as.numeric(dataset_India$GDP)
dataset_India$CPI<-as.numeric(dataset_India$CPI)
dataset_India$WPI<-as.numeric(dataset_India$WPI)
dataset_India$Import<-as.numeric(dataset_India$Import)
dataset_India$Export<-as.numeric(dataset_India$Export)
dataset_India$M3<-as.numeric(dataset_India$M3)
dataset_India$Unemployment<-as.numeric(dataset_India$Unemployment)
dataset_India$PPP<-as.numeric(dataset_India$PPP)
dataset_India$Inflation_Rate<-as.numeric(dataset_India$Inflation_Rate)
dataset_India$Industrial_Production<-as.numeric(dataset_India$Industrial_Production)
dataset_India$Market_Capitalization<-as.numeric(dataset_India$Market_Capitalization)
dataset_India$Exchange_Rate<-as.numeric(dataset_India$Exchange_Rate)
dataset_India$International_Debt<-as.numeric(dataset_India$International_Debt)
dataset_India$Interest_Rate<-as.numeric(dataset_India$Interest_Rate)


#z<-0
j<-0
b <-1
h <- NULL
hi <- NULL
k <- 1
y <- 0
dataset_India$Population<-as.numeric(dataset_India$Population)
#uniqueYear<-unique(format(dataset_India$Date,'%Y'))
for(i in 1:nrow(dataset_India)){
  if(!is.na(dataset_India$Population[i])){
    h<-c(dataset_India$Population[k])
    hi<- c(dataset_India$Population[i])
    if(y != 0)
    {
      b <- 1
      for(j in y:1)
      {
        
        dataset_India$Population[i-j] <- (((hi-h)/(y+1))*b) + h 
        b <- b+1
      }
    }
    y<-0
    #z<- z+1
    k <- i
  }else{
    y<-y+1
  }
}
for(i in 73:75)
{
  dataset_India$Population[i] <- dataset_India$Population[i-1] + ((hi-h)/(y+1))
}
#View(dataset_India)

j<-0
b <-1
h <- NULL
hi <- NULL
k <- 1
y <- 0
#uniqueYear<-unique(format(dataset_India$Date,'%Y'))
for(i in 1:nrow(dataset_India)){
  if(!is.na(dataset_India$Unemployment[i])){
    h<-c(dataset_India$Unemployment[k])
    hi<- c(dataset_India$Unemployment[i])
    if(y != 0)
    {
      b <- 1
      for(j in y:1)
      {
        
        dataset_India$Unemployment[i-j] <- (((hi-h)/(y+1))*b) + h 
        b <- b+1
      }
    }
    y<-0
    #z<- z+1
    k <- i
  }else{
    y<-y+1
  }
}
for(i in 73:75)
{
  dataset_India$Unemployment[i] <- dataset_India$Unemployment[i-1] + ((hi-h)/(y+1))
}
#View(dataset_India)

j<-0
b <-1
h <- NULL
hi <- NULL
k <- 1
y <- 0
#uniqueYear<-unique(format(dataset_India$Date,'%Y'))
for(i in 1:nrow(dataset_India)){
  if(!is.na(dataset_India$PPP[i])){
    h<-c(dataset_India$PPP[k])
    hi<- c(dataset_India$PPP[i])
    if(y != 0)
    {
      b <- 1
      for(j in y:1)
      {
        
        dataset_India$PPP[i-j] <- (((hi-h)/(y+1))*b) + h 
        b <- b+1
      }
    }
    y<-0
    #z<- z+1
    k <- i
  }else{
    y<-y+1
  }
}
for(i in 57:75)
{
  dataset_India$PPP[i] <- dataset_India$PPP[i-1] + ((hi-h)/(y+1))
}
#View(dataset_India)

j<-0
b <-1
h <- NULL
hi <- NULL
k <- 1
y <- 0
#uniqueYear<-unique(format(dataset_India$Date,'%Y'))
for(i in 1:nrow(dataset_India)){
  if(!is.na(dataset_India$Inflation_Rate[i])){
    h<-c(dataset_India$Inflation_Rate[k])
    hi<- c(dataset_India$Inflation_Rate[i])
    if(y != 0)
    {
      b <- 1
      for(j in y:1)
      {
        
        dataset_India$Inflation_Rate[i-j] <- (((hi-h)/(y+1))*b) + h 
        b <- b+1
      }
    }
    y<-0
    #z<- z+1
    k <- i
  }else{
    y<-y+1
  }
}
for(i in 73:75)
{
  dataset_India$Inflation_Rate[i] <- dataset_India$Inflation_Rate[i-1] + ((hi-h)/(y+1))
}
#View(dataset_India)


j<-0
b <-1
h <- NULL
hi <- NULL
k <- 1
y <- 0
#uniqueYear<-unique(format(dataset_India$Date,'%Y'))
for(i in 1:nrow(dataset_India)){
  if(!is.na(dataset_India$Market_Capitalization[i])){
    h<-c(dataset_India$Market_Capitalization[k])
    hi<- c(dataset_India$Market_Capitalization[i])
    if(y != 0)
    {
      b <- 1
      for(j in y:1)
      {
        
        dataset_India$Market_Capitalization[i-j] <- (((hi-h)/(y+1))*b) + h 
        b <- b+1
      }
    }
    y<-0
    #z<- z+1
    k <- i
  }else{
    y<-y+1
  }
}
for(i in 73:75)
{
  dataset_India$Market_Capitalization[i] <- dataset_India$Market_Capitalization[i-1] + ((hi-h)/(y+1))
}
View(dataset_India)

year<-as.numeric(format(dataset_India$Date, "%Y"))
month<-as.numeric(format(dataset_India$Date, "%m"))
for(i in 1:nrow(dataset_India))
{
  month<-as.numeric(format(dataset_India$Date[i], "%m"))
  if(month == 1)
  {
    dataset_India$quarter[i] <- "Q1"
  }else if(month == 4)
  {
    dataset_India$quarter[i] <- "Q2"
  }else if(month == 7)
  {
    dataset_India$quarter[i] <- "Q3"
  }else
  {
    dataset_India$quarter[i] <- "Q4"
  }
}

dataset_India$Percent_Change_GDP[1] <- 0
for(i in 2:nrow(dataset_India)) {
  dataset_India$Percent_Change_GDP[i] <- ((dataset_India$GDP[i] - dataset_India$GDP[i-1])/dataset_India$GDP[i-1])*100
}
dataset_India$Recession <- ifelse(dataset_India$Percent_Change_GDP < -1.1,"YES","NO")
dataset_India$Year<-year
write.csv(dataset_India,"dataset_India.csv")
View(dataset_India)

dataset_India$Recession<-as.factor(dataset_India$Recession)
India <- subset(dataset_India, select=c(2:16,18:19))
#View(Boston)


set.seed(123)
boruta.train <- Boruta(Recession~., data = India, doTrace = 2)
print(boruta.train)


plot(boruta.train, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(boruta.train$ImpHistory),function(i)
  boruta.train$ImpHistory[is.finite(boruta.train$ImpHistory[,i]),i])
names(lz) <- colnames(boruta.train$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels),
     at = 1:ncol(boruta.train$ImpHistory), cex.axis = 0.7)

