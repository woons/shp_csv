library(rgdal)
library(rgeos)
library(tidyverse)

#----------------------------------
# FT Interactive github 참고
#----------------------------------

#shp파일
fileNameShapefile <- 'seoul_shp/seoul_haengjung_dong_424.shp'

#csv파일
fileNameCsv <- 'mydata.csv'

#shp와 csv를 결합할 기준되는 열을 지정
joinCols=c('adm_nm', 'dong_nm_csv') 

#csv imported
csv <- read.csv(fileNameCsv,stringsAsFactors = F, encoding = "utf-8") 

#shp & csv 합치기 (지정한 열을 기준으로)
mapData <- readOGR(dsn = fileNameShapefile,
                   layer = fileNameShapefile %>%
                     gsub('.+\\/|\\..+','',.)
) %>% 
  merge(csv,by.x=joinCols[1],by.y=joinCols[2])  

#새로운 shp파일 생성 (csv값 반영), 아직 QGIS에서 인코딩 문제 해결 못함
writeOGR(obj=mapData, dsn="newMap", layer="newMap", driver="ESRI Shapefile", encoding = "UTF-8") 

