# Web-crawling code using R Selenium for automated downloading of meeting minutes
# The authors thank Jisung Kim (Kyungnam University) for useful comments and provision of this code. 

# =========================================== [ setting ] ==========================================================
# 필터 조건에 대한 설정이 되지않는 페이지 임의로 수정이필요 (반자동화라고 말씀드렸던 이유)
library(tidyverse); library(RSelenium)
setwd("C:/Users/inhwa/OneDrive - UW/Research/KorCongress/disruptminute") # 다운로드 위치 

#CMD-> cd C:\r_selenium
# java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.141.59.jar -port 4445

remDR <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

# pdfprof <- makeFirefoxProfile(list(
#   "pdfjs.disabled"=TRUE,
#   "plugin.scan.plid.all"=FALSE,
#   "plugin.scan.Acrobat" = "99.0",
#   "browser.helperApps.neverAsk.saveToDisk"='application/pdf'))

# remDR <- rsDriver(browser=c("firefox"),port=4445L, extraCapabilities=pdfprof)

remDR$open()

# =========================================== [ Data gathering ] =======================================================
remDR$navigate("http://likms.assembly.go.kr/record/mhs-60-010.do")
#dir.create("wel20") # n대 국회의회에 따라 파일명 바꾸어 폴더 만들어야함.
n = 10 # 1, 10, 20, 30에 따라서 적절히 n값 변경 (1, 10, 20, 30 등으로)

while(TRUE) {
  ifelse(n == 1, 
         for(number in 1:11) {
           page <- remDR$findElement(using = 'xpath', value = paste0('//*[@id="srchResult"]/div[5]/a[',number,']'))
           page$clickElement()
           Sys.sleep(1)
           
           for(i in 1:10) {
             tryCatch(
               {
                 download_pdf <- remDR$findElement(using = 'xpath', value = paste0('//*[@id="srchResultUl"]/li[', i, ']/div[2]/div/a[2]/img'))
                 download_pdf$clickElement()
                 Sys.sleep(1)
               },
               error = function(e) {
                 download_pdf <- remDR$findElement(using = 'xpath', value = paste0('//*[@id="srchResultUl"]/li[', i, ']/div[2]/div/a[1]/img'))
                 download_pdf$clickElement()
                 Sys.sleep(1)
               }
             ) 
             list.files() %>%
               .[str_detect(., "국회회의록")] %>%
               file.copy(., "./20대") 
           }
           n = n + 1
         },
         
         for(number in 4:13) {
           page <- remDR$findElement(using = 'xpath', value = paste0('//*[@id="srchResult"]/div[5]/a[',number,']'))
           page$clickElement()
           Sys.sleep(1)
           
           for(i in 1:10) {
             tryCatch(
               {
                 download_pdf <- remDR$findElement(using = 'xpath', value = paste0('//*[@id="srchResultUl"]/li[', i, ']/div[2]/div/a[2]/img'))
                 download_pdf$clickElement()
                 Sys.sleep(1)
               },
               error = function(e) {
                 download_pdf <- remDR$findElement(using = 'xpath', value = paste0('//*[@id="srchResultUl"]/li[', i, ']/div[2]/div/a[1]/img'))
                 download_pdf$clickElement()
                 Sys.sleep(1)
               }
             ) 
             list.files() %>%
               .[str_detect(., "국회회의록")] %>%
               file.copy(., "./20대") 
           }
           n = n + 1
         })
} 



