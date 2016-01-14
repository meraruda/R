# R, RStudio簡介: 安裝、操作介面、特色

# R語言簡介         網址: https://zh.wikipedia.org/wiki/R%E8%AF%AD%E8%A8%80
# R語言相關資料     網址：https://www.r-project.org/
# 第一步安裝R       網址：https://cran.r-project.org/mirrors.html
# 第二步安裝RStudio 網址：https://www.rstudio.com/

# 安裝完以後就可以開始寫R程式


# 條件: if, ifelse, for, while

# ← 註解就是井字號，基本上用起來習慣跟Linux相似

# 基本變數宣告======================================================================|
# R語言可以用指派(Assignment)運算式「<-」
# 也可以運用「=」來給予一個變數值

x = 3.0             # Double
x = 3.0 ^ 2
x = sqrt(16)

# 變數的變化與替換可以從右上角的變數狀態欄觀察
# 另外物件中的元素包含四種基本資料型態
# 數值(Numeric)
# 文字(Character)
# 複數(Complex)
# 邏輯(Logical)

some.name = "Taipei Beitou"  # 宣告為字元
some.name

decision = TRUE     # 也可寫成 decision = T 
if (decision) x = 3 # decision 變數可跟 if 搭配

comp = 15 + 22.3i   # 複數

ls.str()            # 觀看目前所有物件之資料型態
mode(x)             # 查看物件的型態
mode(decision)
mode(comp)

# ==================================================================================|
# ===================================變數種類=======================================|
# ==================================================================================|
# ==========變數: vector、matrix、data-frame、list、factor (array)==================|
# ==================================================================================|

# 向量(vector)  <- 儲存單一變數的觀察值=============================================|
# 使用c()函數來建立
V = c(10, 5, 3.1, 6.4, 9.2, 21.7)
V

# 也可以使用assign()函數達到同樣的效果
assign("V", c(10, 5, 3.1, 6.4, 9.2, 21.7))
length(V)
mode(V) # 查看物件的型態

# 中括弧用於存取向量中的特定元素
v[2]

# 要建立連續型的向量可以使用
V2 = 1:10
V2

# 陣列(array)   <- 多為矩陣計算或儲存表格內容=======================================|
X = 1:24 # 這是陣列
dim(X) = c(3, 4, 2) # 指定陣列維度
X

dim(X) = c(4, 6) # 指定陣列維度
X

# 另外也可以透過array直接建立
X = array(1:24, dim = c(3, 4, 2))
X

X = array(0, dim = c(4, 6)) #可以建立都是0的矩陣
mode(X)

# 矩陣(matrix)  <- 用於矩陣計算，例如設計矩陣=======================================|
# 資料框架與矩陣皆為二維
Y = matrix(
  data = 1:24, nrow = 4, ncol = 6, byrow = F, dimnames = NULL
) # 按列
Y = matrix(
  data = 1:24, nrow = 4, ncol = 6, byrow = T, dimnames = NULL
) # 按行
nrow(Y)
ncol(Y)
Y[1,] # 第一列元素觀看
Y[,2] # 第二行元素觀看

# data-frame    <- 儲存整個資料檔的內容=============================================|
id  = c(1,2,3,4)
age = c(25,30,35,40)
sex = c("Male", "Male", "Female", "Female")
pay = c(30000, 40000, 45000, 50000)
x_table = data.frame(id, age, sex, pay)
x_table
x_table[3,3]
x_table[2]
edit(x_table)

weight = c(150, 135, 210, 140)
height = c(65, 61, 70, 65)
gender = c("Fe","Fe","M","Fe")
study = data.frame(weight,height,gender) # make the data frame
study
study = data.frame(w=weight,h=height,g=gender)
row.names(study)<-c("Mary","Alice","Bob","Judy")
study

# 因子(factor)  ← 儲存"類別變數"的內容=============================================|

# 列表組成的元素可以是異質(heterogeneous)物件
xxx = factor(c("蔡","馬","宋"))

id = c(1,2,3)
sex = c("Female", "Male", "Male")
ballot = c(6093578, 6891139, 369588)
xxx.dataframe = data.frame(id, sex, ballot)

# 串列(list)    ← 資料庫或用於函數的傳回值=========================================|
factor_table = list(name = "Taiwan", vote_rate = "74.38%", xxx.dataframe, xxx)

factor_table[1]
factor_table[2]
factor_table[3]
factor_table[[3]][1]
factor_table[[3]][2]
factor_table[[3]][3]
factor_table[4]
factor_table[[4]][1]

# ==================================================================================|
# ===================================== 條件 =======================================|
# ==================================================================================|
# =========== 條件及函數：if , ifelse, for, while, function, switch ================|

# R的條件語法 if (condition) expr#1 else expr#2
# 或是        if (condition) expr#1
# 上述 condition 表示為判斷式，必須傳回一個布林值(TRUE或FALSE)
# 可用 &&(AND) 與 ||(OR) 等常用於判斷式的條件控制

# example - one
x = 6
if (x > 5) y = 2 else y = 4
y

# example - two
X = 3
if (X < 5) Y = 10
Y

# example - three
x = 3
y = 1
if (x < 5 && y < 5) {
  y = 10
  z = 5
}
y
z

# 另外可使用ifelse()函數來做為一個二分類的判斷
# 若condition判斷為TRUE時傳回a，否則傳回b
# ifelse(condition, a, b)
x = 20
y = ifelse(x > 5,2,3)
y

# switch()函數功能==================================================================|
# switch(condition, expr#1, ..., expr#m)
Y=1
switch(Y, one="朱立倫", two="蔡英文", three="宋楚瑜")
Y="two"
switch(Y, one="朱立倫", two="蔡英文", three="宋楚瑜")
Y="宋楚瑜"       
switch(Y, one="朱立倫", two="蔡英文", three="宋楚瑜")
# 沒有結果

# for()函數功能=====================================================================|
x=0
y=0
for(i in 1:5){ x=x+i; y=i^2 }
x
y

# while()函數功能===================================================================|
sum =0
i=1
while(i<=10){sum=sum+i ; i=i+1}
sum

# function 自訂函數=================================================================|
Area_of_a_disk = function(x){
 y = pi*(x^2)
 return(y)
}

Area_of_a_disk(8)

for(i in 1:100){
  cat("半徑為", i, "時的圓面積 =", Area_of_a_disk(i), "\n")
  }








