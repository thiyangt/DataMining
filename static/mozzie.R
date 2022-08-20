library(mozzie)
data(mozzie)
head(mozzie)
dim(mozzie)
df2 <- mozzie[, c(1, 4:28)]
head(df2)
dim(df2)

df3 <- pivot_longer(df2, 2:26, "Name", "Value")
head(df3)
ggplot(df3, aes(x=ID, y=value, col=Name)) + 
  geom_line()
