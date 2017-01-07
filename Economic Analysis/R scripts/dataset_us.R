devtools::install_github("sboysel/fredr")
library(fredr)
api.key = '279ee2107d6af68091c9a242441732d3'
fred <- fredr_key(api.key)
str(fred,1)
gdp<-NULL
drops <- c("realtime_start","realtime_end")
gdp <- fredr("series/observations",series_id = 'GDPC1')
gdp <- gdp[ , !(names(gdp) %in% drops)]
colnames(gdp) <- c("Date","GDP")
population <- fredr("series/observations",series_id = 'B230RC0Q173SBEA',
                           observation_start = "1947-01-01",
                           observation_end = "2016-07-01",
                           frequency="q") #population in thousands
population <- population[ , !(names(population) %in% drops)]
colnames(population) <- c("Date","Population")
cpi <- fredr("series/observations",series_id = "CPIAUCSL",
                            observation_start = "1947-01-01",
                            observation_end = "2016-07-01",
                            frequency="q")
cpi <- cpi[ , !(names(cpi) %in% drops)]
colnames(cpi) <- c("Date","CPI")
ppi <- fredr("series/observations",series_id = 'PPIACO',
                    observation_start = "1947-01-01",
                    observation_end = "2016-07-01",
                    frequency="q")
ppi <- ppi[ , !(names(ppi) %in% drops)]
colnames(ppi) <- c("Date","PPI")
import <- fredr("series/observations",series_id = 'IMPGS',
                       observation_start = "1947-01-01",
                       observation_end = "2016-07-01",
                       frequency="q")
import <- import[ , !(names(import) %in% drops)]
colnames(import) <- c("Date","Import")
export <- fredr("series/observations",series_id = 'EXPGS',
                       observation_start = "1947-01-01",
                       observation_end = "2016-07-01",
                       frequency="q")
export <- export[ , !(names(export) %in% drops)]
colnames(export) <- c("Date","Export")
M2 <- fredr("series/observations",series_id = 'M2SL',
                   observation_start = "1947-01-01",
                   observation_end = "2016-07-01",
                   frequency="q")
M2 <- M2[ , !(names(M2) %in% drops)]
colnames(M2) <- c("Date","M2")
unemployment <- fredr("series/observations",series_id = 'UNRATE',
                             observation_start = "1947-01-01",
                             observation_end = "2016-07-01",
                             frequency="q")
unemployment <- unemployment[ , !(names(unemployment) %in% drops)]
colnames(unemployment) <- c("Date","Unemployment Rate")
ppp <- fredr("series/observations",series_id = 'PPPTTLUSA618NUPN',
                    observation_start = "1947-01-01",
                    observation_end = "2016-07-01"
                    )
ppp <- ppp[ , !(names(ppp) %in% drops)]
colnames(ppp) <- c("Date","Purchase Power Parity")
inflation_rate <- fredr("series/observations",
                        series_id = 'FPCPITOTLZGUSA',
                        observation_start = "1947-01-01",
                        observation_end = "2016-07-01"
                        )
inflation_rate <- inflation_rate[ , !(names(inflation_rate) %in% drops)]
colnames(inflation_rate) <- c("Date","Inflation Rate")
industrial_production <- fredr("series/observations",
                               series_id = 'INDPRO',
                               observation_start = "1947-01-01",
                               observation_end = "2016-07-01",
                               frequency="q")
industrial_production <- industrial_production[ , !(names(industrial_production) %in% drops)]
colnames(industrial_production) <- c("Date","Industrial Production")
TotalNonfarmPayrolls<-fredr("series/observations",series_id = "PAYEMS",frequency = "q",
                            observation_start = "1947-01-01",
                            observation_end = "2016-07-01")
TotalNonfarmPayrolls <- TotalNonfarmPayrolls[ , !(names(TotalNonfarmPayrolls) %in% drops)]
colnames(TotalNonfarmPayrolls) <- c("Date","Total Non Farm Payrolls")
RealPersonalIncome<-fredr("series/observations",series_id = "W875RX1",frequency = "q",
                          observation_start = "1947-01-01",
                          observation_end = "2016-07-01")
RealPersonalIncome <- RealPersonalIncome[ , !(names(RealPersonalIncome) %in% drops)]
colnames(RealPersonalIncome) <- c("Date","Real Personal Income")
RealManufacturingTradeIndustriesSales<-fredr("series/observations",series_id = "CMRMTSPL",frequency = "q",
                                             observation_start = "1947-01-01",
                                             observation_end = "2016-07-01")
RealManufacturingTradeIndustriesSales <- RealManufacturingTradeIndustriesSales[ , !(names(RealManufacturingTradeIndustriesSales) %in% drops)]
colnames(RealManufacturingTradeIndustriesSales) <- c("Date","Real Manufacturing Trade Industries")
dataset_us <- NULL
library(dplyr)
dataset0 <- left_join(gdp,population,by=c("Date"="Date"))
dataset1 <- left_join(dataset0,cpi,by=c("Date"="Date"))
dataset2 <- left_join(dataset1,ppi,by=c("Date"="Date"))
dataset3 <- left_join(dataset2,import, by=c("Date"="Date"))
dataset4 <- left_join(dataset3,export, by=c("Date"="Date"))
dataset5 <- left_join(dataset4,M2, by=c("Date"="Date"))
dataset6 <- left_join(dataset5,unemployment, by=c("Date"="Date"))
dataset61<- left_join(dataset6,ppp, by=c("Date"="Date"))
dataset7 <- left_join(dataset61,inflation_rate, by=c("Date"="Date"))
dataset8 <- left_join(dataset7,industrial_production, by=c("Date"="Date"))
dataset9 <- left_join(dataset8,TotalNonfarmPayrolls, by=c("Date"="Date"))
dataset10 <- left_join(dataset9,RealPersonalIncome, by=c("Date"="Date"))
dataset_US <- left_join(dataset10,RealManufacturingTradeIndustriesSales, by=c("Date"="Date"))
View(dataset_US)
setwd('/Users/hinagandhi/desktop')
write.csv(dataset_US, "dataset_US.csv")
dataset_new  <- read.csv("dataset_US.csv")
dataset_new$Date <- as.Date((dataset_new$Date), "%Y-%m-%d")
dataset_new$Year<-as.numeric(format(dataset_new$Date, "%Y"))
# extract month
dataset_new$Month<-as.numeric(format(dataset_new$Date, "%m"))
#extract day
dataset_new$Day<-as.numeric(format(dataset_new$Date, "%d"))
for(i in 1:nrow(dataset_new)) {
  if(is.na(dataset_new$Purchase.Power.Parity[i]) )
  {
    dataset_new$Purchase.Power.Parity[i] <- 1
  }
}
if(is.na(dataset_new$M2[1]))
{
  dataset_new$M2[1] <- runif(1, 196.69, 199.44)
}
for(i in 2:nrow(dataset_new)) {
  if(is.na(dataset_new$M2[i]) )
  {
    dataset_new$M2[i] <- dataset_new$M2[i-1]+2.245
  }
}
dataset_new$Unemployment.Rate[is.na(dataset_new$Unemployment.Rate)] <-0
for(i in 1:nrow(dataset_new)) {
  if(dataset_new$Unemployment.Rate[i]==0 )
  {
    dataset_new$Unemployment.Rate[i] <- mean(dataset_new$Unemployment.Rate)
  }
}

if(is.na(dataset_new$Inflation.Rate[1]))
{
  dataset_new$Inflation.Rate[1] <- ((dataset_new$CPI[1] - 21.20)/21.20)*100
}

for(i in 2:nrow(dataset_new)) {
  if(is.na(dataset_new$Inflation.Rate[i]))
  {
    dataset_new$Inflation.Rate[i] <- ((dataset_new$CPI[i] - dataset_new$CPI[i-1])/dataset_new$CPI[i-1])*100
  }
}
dataset_new$Date <- as.Date(dataset_new$Date)
month<-as.numeric(format(dataset_new$Date, "%m"))
for(i in 1:nrow(dataset_new))
{
  month<-as.numeric(format(dataset_new$Date[i], "%m"))
  if(month == 1)
  {
    dataset_new$quarter[i] <- "Q1"
  }else if(month == 4)
  {
    dataset_new$quarter[i] <- "Q2"
  }else if(month == 7)
  {
    dataset_new$quarter[i] <- "Q3"
  }else
  {
    dataset_new$quarter[i] <- "Q4"
  }
}
if(is.na(dataset_new$Real.Personal.Income[1]))
{
  dataset_new$Real.Personal.Income[1] <- runif(1, 1700, 1800)
}
for(i in 2:nrow(dataset_new)) {
  if(is.na(dataset_new$Real.Personal.Income[i]) )
  {
    dataset_new$Real.Personal.Income[i] <- dataset_new$Real.Personal.Income[i-1]+7.567
  }
}
if(is.na(dataset_new$Real.Manufacturing.Trade.Industries[1]))
{
  dataset_new$Real.Manufacturing.Trade.Industries[1] <- runif(1, 30000.8,35000.56 )
}
for(i in 2:nrow(dataset_new)) {
  if(is.na(dataset_new$Real.Manufacturing.Trade.Industries[i]) )
  {
    dataset_new$Real.Manufacturing.Trade.Industries[i] <- dataset_new$Real.Manufacturing.Trade.Industries[i-1]+3525.678
  }
}
dataset_new$percent_change_gdp[1] <- 0
for(i in 2:nrow(dataset_new)) {
  dataset_new$percent_change_gdp[i] <- ((dataset_new$GDP[i] - dataset_new$GDP[i-1])/dataset_new$GDP[i-1])*100
}
dataset_new$recession <- ifelse(dataset_new$percent_change_gdp < -1.1,"YES","NO")
dataset_new <- dataset_new[c(2,19,18,17,20,3:16,21,22)]
View(dataset_new)
write.csv(dataset_new,"dataset_new.csv")
