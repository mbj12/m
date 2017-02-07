## 字符串处理包stringr 是由Hadley Wickham 开发

library(stringr)

# str_c
name <- str_c('zhang','jackie','china')
name

str_c(head(letters),sep = '-',collapse = '')

# 去除字符串左右空格
name1 <- str_trim(' zhang jackie',side = 'both')
name1


# 字符串填充函数
name2 <- str_pad('zhangjackie',width = 20,side='both',pad = 'X')  
# width 补充字符后使得字符串长度为设置值  填充后的长度
name2

# 复制字符串函数
name3 <- str_dup('zhangjackie',5)
name3


# 截取字符串
name4 <- str_sub('zhangjakcie',start=5,end=10)
name4

# 字符串长度
namelength <- str_length(name)
namelength
# 字符个数
namecount <- str_count(name,'a')  # str_count(string,pattern)
namecount


namerep <- str_replace(name,'jackie','jiaqi')
namerep

#提取匹配字符串
telephonenumber <- '17823451111 or 13378901234'
phone <- str_extract_all(telephonenumber,'[0-9]{11}',simplify = TRUE) 


string <- c('139-1234-5678','133,1267,4589','134 6543 7890','178 2345 1111 or 133 7890 1234')

str_extract(string,'[1][3-9]{2}[- ,][0-9]{4}[- ,][0-9]{4}')
str_match(telephonenumber,'[0-9]{11}')









