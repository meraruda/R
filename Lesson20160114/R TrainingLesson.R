options(java.parameters = "-Xmx4g", stringsAsFactors=F)
library(XLConnect);library(data.table);library(plyr); library(dplyr);library(devtools)
library(ggplot2)

## =========== 1. R and RStudio install ===========
## web link: 
## R(version R-3.2.3) : http://ftp.yzu.edu.tw/CRAN/  
## Rstudio : https://www.rstudio.com/products/rstudio/download/\
## Notice : 
## 要先安裝R 再安裝Rstudio，Rstudio將連結該版本的R
## 若需變更R的版本連結，可由上方的 "Tools => Global Options => R General (R version)"變更
## 一般安裝位置會在 C:\Program Files 底下
## =========== 1.1 參數設定 ===========
## options(java.parameters = "-Xmx16g", stringsAsFactors=F)
## 每次執行 R 都需要先執行上述參數，java.parameters 請依據本身電腦的MEM 填入上限，一般default 為 2g MEM
## stringAsFactors = F 因為預設將文字向量轉換成 factor 變數，這指令將停止此預設

## =========== 1.2 套件安裝及呼叫 ===========
## 安裝 :
## 如需要安裝新的套件，請點選Rstusio 右下方的 packages並點選 install 接著輸入欲安裝的套件
## example : data.table，接著點選 install，即完成安裝，R 將自動連結到 R 的library 進行安裝
## Notice : 
## 如欲安裝的套件無法安裝，也可直接在網路上抓取該套件的壓縮檔，解壓縮後放置到 "C:\Program Files\R\R-3.2.2\library"
## 抑或，可以直接下指令使用網址安裝，如下:
## install.packages("dplyr", repos = "http://mran.revolutionanalytics.com")
## 呼叫 :
## 安裝完成後，仍需下 'library(dplyr)' 或是 'library("dplyr")'指令才能使用
##

## =========== 1.3 常用環境指令 ===========
## getwd()             : 查詢目前工作目錄
## setwd(欲變更的目錄) : 改變工作目錄
## rm(物件名稱)        : 刪除該物件，一般會與gc()使用，如rm(Raw.Data);gc()即刪除該物件並釋放MEM
## memory.size()       : 查詢R 目前所使用的MEM大小(單位 : MB)
## memory.limit()      : R 所可使用的最大MEM上限 (單位 : MB)，也可用於設定MEM上限，但只能增加不能減少
## options(digits = 3) : 用來設定數字的顯示位數，一般設定為五位數字，如此例為變更R 可允許的位數 5+3 
## options(scipen=999) : 直接阻止任何科學計數
## help(函數), ??函數  : 查詢函數的定義或範例
## demo(套件名稱)      : 展示某套件的示範功能
## example(函數名稱))  : 執行函數中的範例程式
## class               : 物件類別
## str                 : 物件結構
## attr                : 查詢物件特定屬性值

## =========== 2. R 常用變數 ===========
## 變數 : vector, matrix, data.frame, factor, list
## =========== 2.1 vector ===========
## 元素屬性皆相同 : 皆為數字或文字或邏輯值
## 向量聯集       : 可用c()結合兩個向量變數
## 刪除元素       : 使用負號刪除該向量中的任意變數
## 向量沒有維度   : 可以轉換為matrix 後即可使用維度，抑或用length計算向量內的數量

## example :
Names = c('John', 'Tim', 'Teddy', 'Howard')
Names[1]
# [1] "John"
length(Names)
# [1] 4
Number = c(12,23,52,39,1)
Number
# [1] 12 23 52 39  1
Number[1]
# [1] 12
Number[-2] # 刪除第二項
# [1] 12 52 39  1
Number[6] = 100 # 新增第六項 
Number
# [1]  12  23  52  39   1 100
length(Number)
# [1] 6
dim(Number) # 沒有維度資訊
# NULL
dim(matrix(Number)) # 轉換成矩陣變數
# [1] 6 1
y1 = c(1,2,3);y2 = c(2,4,6);y3 = c(3,5,9)
y = c(y1,y2,y3)
y
# [1] 1 2 3 2 4 6 3 5 9
z = c(1:5)
z
# [1] 1 2 3 4 5
seq(1, 5) # 內建函數 seq
# [1] 1 2 3 4 5
seq(1, 5, by=2) # 運用 by 參數，設定各項差距
# [1] 1 3 5
rep(1, 3) # 內建函數 rep
# [1] 1 1 1
rep(1:3, times = 2) # 重複兩次
# [1] 1 2 3 1 2 3 
rep(1:3, each = 2) # 重複兩次
# [1] 1 1 2 2 3 3

## =========== 2.2 matrix ===========
## 元素屬性皆相同 : 皆為數字或文字或邏輯值
## 矩陣聯集       : 可用cbind() or rbind() 結合兩個矩陣變數 或是向量變數

## example : 
x.m <- matrix(1:9)
x.m
#       [,1]
# [1,]    1
# [2,]    2
# [3,]    3
# [4,]    4
# [5,]    5
# [6,]    6
# [7,]    7
# [8,]    8
# [9,]    9

t(x.m) # 轉置
#       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
# [1,]    1    2    3    4    5    6    7    8    9
x.m = matrix(1:9, ncol = 3) # 設定col 數為3
x.m
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9
x.m = matrix(1:6, nrow = 3) # 設定row 數為3
x.m
#       [,1] [,2]
# [1,]    1    4
# [2,]    2    5
# [3,]    3    6
dim(x.m) # 查詢dimension
# [1] 3 2 第一數字為row 數，第二為 col數
nrow(x.m);ncol(x.m) # 查詢row 數及 col數
# [1] 3 ;[1] 2
A = matrix(1:6, ncol=3);B = matrix(11:13, nrow =3)
A%*%B #矩陣相乘
#     [,1]
# [1,]  112
# [2,]  148
diag(matrix(1:9, ncol=3)) # 對角線函數
# [1] 1 5 9

det(matrix(1:4, ncol=2)) # 計算determinant
# [1] -2

solve(matrix(1:4, ncol=2)) # 回傳反矩陣，用於解聯立線性方程式
#      [,1] [,2]
# [1,]   -2  1.5
# [2,]    1 -0.5

eigen(matrix(1:4, ncol=2)) # 計算特徵值及特徵向量
# $values
# [1]  5.372 -0.372
# 
# $vectors
#       [,1]   [,2]
# [1,] -0.566 -0.909
# [2,] -0.825  0.416

A = matrix(1:6, ncol=3);B = matrix(11:13, nrow =1)
rbind(A, B)
#      [,1] [,2] [,3]
# [1,]    1    3    5
# [2,]    2    4    6
# [3,]   11   12   13

cbind(t(A), t(B))
#      [,1] [,2] [,3]
# [1,]    1    2   11
# [2,]    3    4   12
# [3,]    5    6   13

colnames(A) = c(paste('col', 1:3,sep = '')) # 設定col名稱
rownames(A) = c(LETTERS[1:2]) # 設定row名稱;letters and LETTERS
A
#    col1 col2 col3
# A    1    3    5
# B    2    4    6

A[1, ] # 選擇第一個row
# col1 col2 col3 
# 1    3    5 
A[, 1] # 選擇第一個col
# A B 
# 1 2 

A[2,3] = 2;A # 變更矩陣中的 (2,3) 為 2
#   col1 col2 col3
# A    1    3    5
# B    2    4    2

## =========== 2.3 data.frame ===========
## 元素屬性可不相同 : 可為數字或文字或邏輯值，介於Matrix 與List 間的變數
## 矩陣聯集         : 可用cbind() or rbind() 結合
## '$' 符號         : 可運用'$'符號指定某直行，與matrix的X[, 1]類似

## example : 
## 一般使用 'read.table'指令讀入資料皆為 data.frame 變數
data <- read.table('D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/www_asus_115061.esw3ccust_U.201511081800-2400-15.gz'
                   , sep = '\t')
head(data) #
# V1       V2             V3   V4
# 1 2015-11-07 14:53:47 95.165.136.170  GET
# 2 2015-11-07 14:53:49 95.165.136.170  GET
# 3 2015-11-07 14:53:49  46.133.177.64  GET
# 4 2015-11-07 14:53:51   84.21.34.167  GET
# 5 2015-11-07 14:53:52 95.165.136.170 POST
# 6 2015-11-07 14:53:53 95.165.136.170  GET
# V5  V6    V7   V8
# 1 /www.asus.com/ru/GetData.asmx/getProduct_Information_xml?ProductHashedId=V9YR0jtmbN4rzyj4 200  1243    0
# 2                                 /www.asus.com/websites/rich_overview/css/rich_oveview.css 200  1258    1
# 3                                  /www.asus.com/ru/Motherboard-Accessories/ROG_Front_Base/ 200 43169 1978
# 4                                   /www.asus.com/websites/global/images/icons/Gbit_lan.gif 304   199    0
# 5                                                  /www.asus.com/ru/member.asmx/checkMember 200   413    0
# 6         /www.asus.com/ru/GetData.asmx/getProductSpecByHashedid?param=V9YR0jtmbN4rzyj4,1,0 200   314    0
# V9
# 1 http://www.asus.com/RU/Motherboards/B85ME/?SearchKey=b85m-e/
#   2 http://www.asus.com/RU/Motherboards/B85ME/?SearchKey=b85m-e/
#   3                                   https://www.google.com.ua/
#   4                                                            -
#   5 http://www.asus.com/RU/Motherboards/B85ME/?SearchKey=b85m-e/
#   6 http://www.asus.com/RU/Motherboards/B85ME/?SearchKey=b85m-e/
#   V10
# 1                                     Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36
# 2                                     Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36
# 3 Mozilla/5.0 (Linux; Android 5.0.1; GT-I9500 Build/LRX22C) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.133 Mobile Safari/537.36
# 4                                                                                                                  Mozilla/4.0 (compatible;)
# 5                                     Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36
# 6                                     Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36
# V11 V12
# 1   -  RU
# 2   -  RU
# 3   -  UA
# 4   -  DE
# 5   -  RU
# 6   -  RU
## 建立變數 col.names 為欄位名稱
col.names <- c('date','time','cs-ip','cs-method','cs-uri','sc-status','sc-bytes','time-taken','cs(Referer)','cs(User-Agent)','cs(Cookie)','x-custom')
colnames(data) <- col.names
head(data)
# date     time          cs-ip cs-method
# 1 2015-11-07 14:53:47 95.165.136.170       GET
# 2 2015-11-07 14:53:49 95.165.136.170       GET
# 3 2015-11-07 14:53:49  46.133.177.64       GET
# 4 2015-11-07 14:53:51   84.21.34.167       GET
# 5 2015-11-07 14:53:52 95.165.136.170      POST
# 6 2015-11-07 14:53:53 95.165.136.170       GET
# cs-uri sc-status sc-bytes
# 1 /www.asus.com/ru/GetData.asmx/getProduct_Information_xml?ProductHashedId=V9YR0jtmbN4rzyj4       200     1243
# 2                                 /www.asus.com/websites/rich_overview/css/rich_oveview.css       200     1258
# 3                                  /www.asus.com/ru/Motherboard-Accessories/ROG_Front_Base/       200    43169
# 4                                   /www.asus.com/websites/global/images/icons/Gbit_lan.gif       304      199
# 5                                                  /www.asus.com/ru/member.asmx/checkMember       200      413
# 6         /www.asus.com/ru/GetData.asmx/getProductSpecByHashedid?param=V9YR0jtmbN4rzyj4,1,0       200      314
# time-taken                                                  cs(Referer)
# 1          0 http://www.asus.com/RU/Motherboards/B85ME/?SearchKey=b85m-e/
#   2          1 http://www.asus.com/RU/Motherboards/B85ME/?SearchKey=b85m-e/
#   3       1978                                   https://www.google.com.ua/
#   4          0                                                            -
#   5          0 http://www.asus.com/RU/Motherboards/B85ME/?SearchKey=b85m-e/
#   6          0 http://www.asus.com/RU/Motherboards/B85ME/?SearchKey=b85m-e/
#   cs(User-Agent)
# 1                                     Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36
# 2                                     Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36
# 3 Mozilla/5.0 (Linux; Android 5.0.1; GT-I9500 Build/LRX22C) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.133 Mobile Safari/537.36
# 4                                                                                                                  Mozilla/4.0 (compatible;)
# 5                                     Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36
# 6                                     Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36
# cs(Cookie) x-custom
# 1          -       RU
# 2          -       RU
# 3          -       UA
# 4          -       DE
# 5          -       RU
# 6          -       RU

head(data['time']);head(data[2]) # 兩者皆為data.frame 變數
# time
# 1 14:53:47
# 2 14:53:49
# 3 14:53:49
# 4 14:53:51
# 5 14:53:52
# 6 14:53:53
# time
# 1 14:53:47
# 2 14:53:49
# 3 14:53:49
# 4 14:53:51
# 5 14:53:52
# 6 14:53:53
head(data[, 'time']); head(data$time);head(data[, 2]) # 三者皆為 vector 變數
# [1] "14:53:47" "14:53:49" "14:53:49" "14:53:51" "14:53:52" "14:53:53"
# [1] "14:53:47" "14:53:49" "14:53:49" "14:53:51" "14:53:52" "14:53:53"
# [1] "14:53:47" "14:53:49" "14:53:49" "14:53:51" "14:53:52" "14:53:53"

x = data.frame()
x = edit(x)
x
#   身高 體重 性別
# 1  164   47    F
# 2  145   56    F
# 3  187   60    M
# 4  175   74    F
fix(x)
x
#   身高 體重 性別
# 1  164   47    F
# 2  145   56    F
# 3  187   74    M
# 4  175   74    F

## 直接剪貼使用 excel or csv 的資料
# readClipboard 無法區分不同欄位且無法定義欄位名稱
x <- readClipboard()
x
# [1] "date"            "time"            "s-ip"            "cs-method"       "cs-uri-stem"     "cs-uri-query"   
# [7] "s-port"          "cs-username"     "c-ip"            "cs(User-Agent)"  "cs(Referer)"     "cs-host"        
# [13] "sc-status"       "sc-substatus"    "sc-win32-status" "sc-bytes"        "cs-bytes"        "time-taken" 

y <- readClipboard()
y
# [1] "win32_status\tfreq\t%" "0\t83062951\t73.39%"   "1\t13632063\t12.04%"   "2\t10377075\t9.17%"   
# [5] "3\t6113561\t5.40%" 

# read.table(file = "clipboard", sep = "\t", header = T) 可以區分不同欄位並定義欄位名稱
x <- read.table(file = "clipboard", sep = "\t", header = T)
x
#   win32_status     freq     X.
# 1            0 83062951 73.39%
# 2            1 13632063 12.04%
# 3            2 10377075  9.17%
# 4            3  6113561  5.40%

## =========== 2.4 factor ===========
## 元素屬性相同 : 可為數字或文字或邏輯值
## 有序因子     : 可使用 'ordered' 指令給予變數順序
## 分類變數     : 可提供資料的類別

x = c('Yes', 'No', 'Yes', 'Yes', 'No')
x
# [1] "Yes" "No"  "Yes" "Yes" "No"
as.factor(x)
# [1] Yes No  Yes Yes No 
# Levels: No Yes # 定義類別，依據字母順序排列，也可重新定義類別
factor(x, levels = c('Yes', 'No'))
# [1] Yes No  Yes Yes No 
# Levels: Yes No # 重新定義類別

## 有序因子變數
x = c('D','E','G','A','C','F','B')
x
# [1] "D" "E" "G" "A" "C" "F" "B"
as.factor(x)
# [1] D E G A C F B
# Levels: A B C D E F G

x1 = ordered(x, levels=c('G','F','E','D','C','B','A'));x1 # 給予分類順序，由小到大
# [1] D E G A C F B
# Levels: G < F < E < D < C < B < A
x1 >='C'
# [1] FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE
x1[x1 >='C']
# [1] A C B
# Levels: G < F < E < D < C < B < A
x1[which(x1 >= 'C')]
# [1] A C B
# Levels: G < F < E < D < C < B < A

## =========== 2.5 list ===========
## 元素屬性可不相同 : 可為數字或文字或邏輯值
## 可不同長度       : 可接受不同長度的數字、文字、向量、矩陣
## 變數中彈性最大   : 可接受不同變數以及不同長度，也可給予名稱

x1 = 11:15;x2 = 23:31;x3 = 1:10
x = list(x1, x2, x3) 
# [[1]]
# [1] 11 12 13 14 15
# 
# [[2]]
# [1] 23 24 25 26 27 28 29 30 31
# 
# [[3]]
# [1]  1  2  3  4  5  6  7  8  9 10

# 因為尚未給予名稱，所以僅能使用雙括號做選取 
x[[1]]
# [1] 11 12 13 14 15
x[[1]][2]
# [1] 12

x = list(X1 = x1, ages = x2, '數字' = x3) 
# $X1
# [1] 11 12 13 14 15
# 
# $ages
# [1] 23 24 25 26 27 28 29 30 31
# 
# $數字
# [1]  1  2  3  4  5  6  7  8  9 10

x[1];x[[1]];x$X1;x[['X1']] # x[1] 回傳一個list 變數，其他皆回傳 vector
# $X1
# [1] 11 12 13 14 15
# 
# [1] 11 12 13 14 15
# [1] 11 12 13 14 15
# [1] 11 12 13 14 15

x$X1[1] # 可以使用向量的方式選取
# [1] 11

## 可以使用rbind 指令合併
L1 = list(nickname = 'Teddy', age = 25)
L2 = list(name = 'Ted', age = 30)
L = rbind(L1, L2);L
#   nickname age
# L1 "Teddy"  25 
# L2 "Ted"    30 
# 合併後，可選擇row
L[1, ]
# $nickname
# [1] "Teddy"
# 
# $age
# [1] 25

## =========== 3. 判斷式、迴圈及自建函數 ===========
## 判斷式   : if else, ifelse, elseif, switch
## 邏輯判斷寫法 : >, <, <=, >=, ==, !=, A%in%B, &, |,!
## 迴圈     : for, while, repeat, break, next
## 自建函數 : function
## =========== 3.1 判斷式 ===========
##邏輯判斷示範例
1 > 3;1 < 3; 1 <= 3;1 >= 3; 1 == 3;1 != 3;c(1:3) %in% c(1:5); 1 > 0 & 3 > 1;1 > 0 | 1 > 1;!(1 > 3) 
# [1] FALSE
# [1] TRUE
# [1] TRUE
# [1] FALSE
# [1] FALSE
# [1] TRUE
# [1] TRUE TRUE TRUE
# [1] TRUE
# [1] TRUE
# [1] TRUE

## if else
x = 3
if (x > 1) y = 2 else y = 5
y
# [1] 2
## ifelse
x = 3
y = ifelse(x > 1, 2, 5);y
# [1] 2

## if elseif else
x = 20
if (x < 5) {
  y = 1
  z = 10
  } else if (x > 100) {
  y = 3
  z = 30
  } else {
  y = 2
  z = 20
  }
c(y, z)
# [1]  2 20

## switch 
x = 3
switch(x, 2+2, mean(1:10), rnorm(5,0,1)) # x = 3, 所以使用第三個函數
# [1]  1.5878 -1.1304 -0.0803  0.1324  0.7080
y = 't'
switch(y, t = mean(1:3), x = median(1:5), y = c(1:2)) # 也可以使用中文或文字選取函數
# [1] 2

## =========== 3.2 迴圈 ===========
## for 較適用一般的迴圈，給予一定範圍後執行 
for (x in 1:10){
  x = x +1
  print(x)
}
# [1] 2
# [1] 3
# [1] 4
# [1] 5
# [1] 6
# [1] 7
# [1] 8
# [1] 9
# [1] 10
# [1] 11

# for 迴圈結合 break 指令，跳出迴圈
for (x in 1:10){
  if (x > 5){
    break
  }
  print(x)
}
# [1] 1
# [1] 2
# [1] 3
# [1] 4
# [1] 5

# for 迴圈結合 next 指令，忽略該次迴圈並繼續執行其他的迴圈
for (x in 1:10){
  if (x == 5){
    next
  }
  print(x)
}
# [1] 1
# [1] 2
# [1] 3
# [1] 4
# [1] 6
# [1] 7
# [1] 8
# [1] 9
# [1] 10

## while 需要設計停止點，一般較適用於數值逼近，例如 : 1/3 這種無窮數值使用泰勒展開式逼近，可以設定誤差值作為停止點
## 與for 迴圈相似
x = 0
while (x <= 10){
  x = x + 1
  print(x)
}
# [1] 2
# [1] 3
# [1] 4
# [1] 5
# [1] 6
# [1] 7
# [1] 8
# [1] 9
# [1] 10
# [1] 11

## repeat 與 while 相似，同樣需要設計停止點，使用break or switch 跳出迴圈，一般適用於逼近
i = 0
repeat
{
  if (i > 5) break
  print(i)
  i = i + 1
}
# [1] 0
# [1] 1
# [1] 2
# [1] 3
# [1] 4
# [1] 5

## =========== 3.3 自建函數 ===========
## function 結合判斷式、迴圈、計算、資料整合、繪圖...etc 
## 可使用 return() 指令設定最後回傳值，若是未設定則 default 設定為最後一個運算式

# 未設定參數的 default 值
x.f <- function(x, y){
  x + y
}
x.f(2,3)
# [1] 5

# function 結合 return()指令用法
x.f <- function(x, y){
  x + y
  return(x)
}
x.f(2,3)
# [1] 2

# 設定參數的 default 值，可以修改任一參數值
x.f <- function(x = 2, y = 3){
  x + y
}
x.f()
# [1] 5
x.f(x = 3);x.f(y = 5)
# [1] 6   ;[1] 7

# 不給予參數
hello.f <- function(){
  cat('Hello World!! \n')
}
hello.f()
# Hello World!! 

# function call function
cube.f <- function(x){
  sq = function() x*x
  #browser()
  x*sq()
}
cube.f(3)
# [1] 27

# 運用'...'指令，將內建函數的所有參數作為function的參數
plot.f <- function(x, y, ...){
  plot(x, y, ...)
}
plot.f(1:5, seq(2, 10, by = 2), main = 'PLOT', xlab = 'x', ylab = 'y')

# 遞迴函數
f1.f <- function(x){
  if (x > 0){
    y = x - 1
    return(x*f1.f(y))
  } else {
    return(1)
  }
}
f1.f(3)
# [1] 6 # 3*2*1*1
f1.f(4)
# [1] 24 # 4*3*2*1*1

## =========== 4. 基本計算 ===========
## =========== 4.1 簡單數字運算 ===========
## '+', '-', '*', '/'
## '%/%', '%%', '** or ^', 'sqrt'
## 'sign()', 'abs()'
## sin(), cos(), tan(), asin(), acos(), atan(), sinh(), cosh(), tanh(), asinh(), acosh(), atanh()

1 + 4;1 - 4;1 * 4;1 / 4
# [1] 5 ; -3, 4, 0.25
1 %/% 2;1 %% 2
# [1] 0, 1
2**3;2^3;sqrt(2)
# [1] 8 8 1.41
abs(-3)
# [1] 3
sin(1)
# [1] 0.841
1.2e-5
# [1] 0.000012

## =========== 4.2 基本向量運算 ===========
## length, sum, prod, cumsum, cumprod, sort, rank, rev
x = c(1,3,2,7,4)
length(x) # 元素個數
# [1] 5
sum(x) # 向量所有元素加總
# [1] 17
prod(x) # 向量所有元素相乘，等同於階層函數
# [1] 168
cumsum(x) # 累加
# [1]  1  4  6 13 17
cumprod(x) #累乘
# [1]   1   3   6  42 168
sort(x) # 排序
# [1] 1 2 3 4 7
rank(x) # 排序後的排序位置，等同於 order
# [1] 1 3 2 5 4
order(x)
# [1] 1 3 2 5 4
rev(x)
# [1] 4 7 2 3 1

## =========== 4.3 基本統計運算 ===========
## mean, var, sd, max, min, median
x = c(1,3,2,7,4)
mean(x) # 平均值
# [1] 3.4 
var(x) # 變異數
# [1] 5.3
sd(x) # 標準差
# [1] 2.3
max(x) # 最大值 
# [1] 7
min(x) # 最小值
# [1] 1
median(x) # 中位數
# [1] 3

## =========== 5. 資料輸入與輸出 ===========
## scan & write
## read.table & write.table
## read.csv & write.csv
## Excel 輸入輸出將在套件 'XLConnect' 介紹說明
## 特殊指令 : file.choose, list.files
## =========== 5.1 scan & write ===========
## 針對向量數值輸入
data <- scan(file = 'D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/Read.sample.txt'
             , nlines = 10, skip = 10, na.strings = NA, encoding = 'UTF-8', sep = ',')

# file      : 讀入的檔案路徑，注意 R 對於檔案路徑的斜線並非一般反斜線
# nline     : 讀入的 row 數量
# skip      : 跳過檔案最前端的 row 數
# na.string : 對於遺失值的處理，一般預設為 'NA'
# encoding  : 指定文字編碼
# sep : 數值間的分隔符號

write(t(matrix(data, ncol = 3, byrow = T)), 'D:/write.out.txt',ncolumns = 3, sep = ',')

# 因為scan 讀入會成向量，先轉換成矩陣，並轉置(因為scan 預設是用 column by column 方式輸出)
# ncolumn : 輸出的 col 數
# sep     : 分隔符號

## =========== 5.2 read.table & write.table ===========
## 針對矩陣或是 data.frame 常用的輸入函數
data <- read.table(file = 'D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/Read.sample.txt'
                   , nrows = 10, skip = 10, na.strings = NA, sep = ',', header = F)

# file      : 讀入的檔案路徑，注意 R 對於檔案路徑的斜線並非一般反斜線
# nrows     : 讀入的 row 數量
# skip      : 跳過檔案最前端的 row 數
# na.string : 對於遺失值的處理，一般預設為 'NA'
# sep       : 數值間的分隔符號
# header    : 檔案的第一列是變數名稱則設定為 T or TRUE，default 為 F(false)

write.table(x = data, file = 'D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/write.out2.txt', na = 'NA', sep = ',')

# x    : 輸出資料
# file : 輸出檔案位置
# na   : 表達遺失值
# sep  : 數值間的分隔符號

## =========== 5.3 read.csv & write.csv ===========
## read.csv 與 read.table 相似，差異在 read.csv 預設以 ',' 分隔讀取
data <- read.csv(file = 'D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/Read.sample.txt'
                   , nrows = 10, skip = 10, na.strings = NA, sep = ',', header = F)
write.csv(x = data, file = 'D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/write.out3.csv', na = 'NA')

## =========== 5.4 特殊指令 : file.choose, list.files ===========
## file.choose : 僅能使用在一般 windows 系統，可以直接點選本機端的檔案物件，R 會辨識檔案位置並回傳
## list.files  : 列出該資料夾下的檔案，並可限定關鍵字

inFile <- file.choose()
inFile
# [1] "D:\\MIS 2015 Working Process\\R TrainingLesson\\ReferenceData\\love_actually.txt"

inFile <- list.files(path = 'D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/',
                     pattern = 'txt|csv',
                     full.names = T)
# path : 資料夾路徑
# pattern : 關鍵字 (可使用'|'增加關鍵字)
# full.names : 回傳完整檔案路徑，default 為 F 

inFile
# [1] "D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/love_actually.txt"
# [2] "D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/Read.sample.txt"  
# [3] "D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/write.out.txt"    
# [4] "D:/MIS 2015 Working Process/R TrainingLesson/ReferenceData/write.out2.txt" 

## =========== 6. 資料轉換、合併、切割 ===========
## 資料轉換 : cut, recode 函數
## 資料合併 : c, union, cbind, rbind
## 資料切割 : split, subset (文字切割 : strsplit)
## =========== 6.1 資料轉換 ===========
# cut 指令
x = sample(1:100, 20)
x
# [1] 83 33 12  2 67 50 21 56 88 28  3 45 63 32 46 75 55 65 91 99
cut(x, breaks = c(0, 50, max(x)))
# [1] (50,99] (0,50]  (0,50]  (0,50]  (50,99] (0,50]  (0,50]  (50,99] (50,99] (0,50]  (0,50]  (0,50]  (50,99] (0,50] 
# [15] (0,50]  (50,99] (50,99] (50,99] (50,99] (50,99]
# Levels: (0,50] (50,99]

cut(x, breaks = c(0, 50, max(x)), labels = c(1, 2))
# [1] 2 1 1 1 2 1 1 2 2 1 1 1 2 1 1 2 2 2 2 2
# Levels: 1 2

cut(x, breaks = c(0, 50, max(x)), labels = c('A', 'B'))
# [1] B A A A B A A B B A A A B A A B B B B B
# Levels: A B

cut(x, breaks = 2)
# [1] (50.5,99.1] (1.9,50.5]  (1.9,50.5]  (1.9,50.5]  (50.5,99.1] (1.9,50.5]  (1.9,50.5]  (50.5,99.1] (50.5,99.1]
# [10] (1.9,50.5]  (1.9,50.5]  (1.9,50.5]  (50.5,99.1] (1.9,50.5]  (1.9,50.5]  (50.5,99.1] (50.5,99.1] (50.5,99.1]
# [19] (50.5,99.1] (50.5,99.1]
# Levels: (1.9,50.5] (50.5,99.1]

cut(x, breaks = 2, labels = c('A', 'B'))
# [1] B A A A B A A B B A A A B A A B B B B B
# Levels: A B

cut(x, breaks = 2, labels = F)
# [1] 2 1 1 1 2 1 1 2 2 1 1 1 2 1 1 2 2 2 2 2

cut(c(0,50,100), breaks= c(0, 50))
# [1] <NA>   (0,50] <NA>  
# Levels: (0,50]

# recode 指令
library(car)
recode(x, "0:50 = 'A';else = 'B'")
# [1] "B" "A" "A" "A" "B" "A" "A" "B" "B" "A" "A" "A" "B" "A" "A" "B" "B" "B" "B" "B"

recode(x, "0:50 = 1;else = 2")
# [1] 2 1 1 1 2 1 1 2 2 1 1 1 2 1 1 2 2 2 2 2

recode(x, "0:20 = 1;20:40 = 2;40:60 = 3;60:80 = 4;else = 5")
# [1] 5 2 1 1 4 3 2 3 5 2 1 3 4 2 3 4 3 4 5 5

## =========== 6.2 資料合併 ===========
## =========== 6.3 資料切割 ===========
