beers <- read_csv(file.choose())
breweries <- read_csv(file.choose())
head(beers)
head(breweries)
breweries %>% select(State) %>% arrange(State) %>% summary(count(State))
numbystate <- data.frame(breweries %>% count(State))
ggplot(data = numbystate, mapping = aes(x = State, fill = State), stat = "count") + geom_bar()
head(numbystate)
numbystate %>% ggplot(aes(x = State, y = n, color = State)) + geom_point()
numbystate %>% ggplot(aes(x = State), fill = State, stat= 'count') + geom_histogram()
numbystate %>% ggplot(aes(x = as.factor(State))) + geom_bar()
breweries %>% ggplot(aes(x = reorder(State), fill = State)) + geom_bar(stat = 'identity') + coord_polar() + cowplot::theme_cowplot()
head(numbystate)
numbystate$State <- as.factor(numbystate$State)
numbystate %>% ggplot(aes(x = reorder(State, n), alpha = n, y = n, fill = State)) + 
  geom_bar(stat = 'identity', fill = "steelblue3") + 
  coord_flip() + 
  theme_classic() + 
  theme(legend.position = "none") +
  labs(x = "Count", y = "State") +
  ggtitle("Number of Breweries per State")
 
?geom_segment()

numbystate %>% ggplot(aes(x = State, y = n, fill = State)) + geom_bar(stat = 'identity', fill = "steelblue3") + coord_polar() + theme_bw()+
  theme(legend.position = "none") + labs(x = "", y = "") + ggtitle("Number of Breweries per State")

p1 + scale_color_gradient(low = "steelblue", high = "red")
?scale_color_colorblind()

head(breweries)
breweries %>% filter(!is.na(Name) | !is.na(Brew_ID) | !is.na(City) | !is.na(State))

sum(is.na(breweries))
colnames(beers)
filter(!is.na(beers$Name) | !is.na(beers$Beer_ID) | !is.na(beers$ABV) | !is.na(beers$IBU) | !is.na(beers$Brewery_id) | !is.na(beers$Style) | !is.na(beers$Ounces))
beers_clean <- beers %>% filter(!is.na(Name)) %>% filter(!is.na(Beer_ID)) %>% 
  filter(!is.na(ABV)) %>% filter(!is.na(IBU)) %>% 
  filter(!is.na(Brewery_id)) %>% filter(!is.na(Style)) %>% 
  filter(!is.na(Ounces))
2410-1403
sum(is.na(beers$ABV))
library(here)
here()
colnames(breweries)
colnames(beers_clean)
breweries$Brewery = breweries$Name
breweries$Brewery_id = breweries$Brew_ID
head(breweries)
breweries_clean <- breweries %>% select(Brewery, City, State, Brewery_id)
join <- inner_join(breweries_clean, beers_clean, by = "Brewery_id")
write.csv(join)
write_csv(join, "/Users/joaquindominguez/Dropbox/SMU/Doing Data Science/git/Case-Study-1/jointable.csv")
head(join)


maxABVIBU <- join %>% select(Brewery, Name, State, ABV, IBU)
View(maxABVIBU %>% filter(State == "CO"))
numofbreweries <- join %>% select(Brewery, City, State)
summary(maxABVIBU$ABV)

maxABVIBU %>% ggplot(aes(x = ABV)) + 
  geom_histogram(fill = "steelblue3") + 
  theme_classic() +
  labs(x = "ABV", y = "") +
  ggtitle("Distribution of ABV")

maxABVIBU %>% ggplot(aes(x = ABV)) +
  geom_boxplot(fill = "steelblue3") +
  theme_classic() +
  labs(x = "ABV") +
  ggtitle("Boxplot of ABV")
  

maxABVIBU %>% ggplot(aes(x = log(IBU), y = log(ABV))) +
  geom_point(color = "steelblue3") +
  geom_smooth(method = "lm", color = "grey49") +
  stat_regline_equation() +
  theme_classic() +
  labs(x = "IBU", y = "ABV") +
  ggtitle("Relationship between IBU and ABV")

hist(maxABVIBU$IBU)
summary(lm(log(ABV) ~ log(IBU), data = maxABVIBU))

max(maxABVIBU$ABV)
maxABVIBU %>% filter(ABV == "0.125")
max(maxABVIBU$IBU)
maxABVIBU %>% filter(IBU == "138")
medABVIBU <- join %>% select(State, ABV, IBU)
head(medABVIBU)
medABV <- medABVIBU %>% group_by(State) %>% mutate(medianABV = median(ABV)*100) %>% select(State, medianABV) %>% arrange(State)
head(medABV)
medABVfinal <- medABV[!duplicated(medABV), ]

medIBU <- medABVIBU %>% 
  group_by(State) %>% 
  mutate(medianIBU = median(IBU)) %>% 
  select(State, medianIBU) %>% 
  arrange(State)
medIBUfinal <- medIBU[!duplicated(medIBU), ]
head(medIBUfinal)

medIBUfinal %>% ggplot(aes(x = reorder(State, medianIBU), y = medianIBU, fill = State, alpha = medianIBU)) + 
  geom_bar(stat = 'identity', fill = "steelblue3") + 
  coord_flip() +
  theme(legend.position = "none") +
  theme_classic() +
  labs(x = "State", y = "Median IBU") +
  ggtitle("Median IBU by State")

medABVfinal %>% ggplot(aes(x = reorder(State, medianABV), y = medianABV, fill = State, alpha = medianABV)) + 
  geom_bar(stat = 'identity', fill = "steelblue3") + 
  coord_flip() +
  theme(legend.position = "none") +
  theme_classic() +
  labs(x = "State", y = "Median ABV") +
  ggtitle("Median ABV by State")



medABV %>% 
  ggplot(aes(x = State, y = medianABV)) + 
  geom_bar(stat = 'identity') + 
  coord_flip()

colnames(join)
join %>% filter(Style %in% c("IPA", "India Pale Ale"))

join %>% filter(Style == "IPA")
?grep()
str_view_all("Ale", join$Style)
sum(str_detect(join$Style, "Ale"))
sum(str_count(join$Style, "Ale"))
sum(grepl("Ale", join$Style))
sum(grep("Ale", join$Style))
sum(grepl("IPA", join$Style))
IPAs <- join %>% filter(grepl("(India | IPA)", Style))
Ales <- join %>% filter(grepl("Ale", Style)) %>% filter(!grepl("(India | IPA)", Style))
Ales
join %>% filter(!grepl("(India | IPA)", Style))
Ales <- join %>% filter(grepl("Ale", Style))
glimpse(Ales %>% filter(grepl("India", Style)))
write_csv(IPAs, "/Users/joaquindominguez/Dropbox/SMU/Doing Data Science/git/Case-Study-1/IPAs.csv")
write_csv(Ales, "/Users/joaquindominguez/Dropbox/SMU/Doing Data Science/git/Case-Study-1/Ales.csv")
here()

Ales %>% ggplot(aes(x = IBU)) + geom_histogram()
IPAs %>% ggplot(aes(x = IBU)) + geom_histogram()
head(Ales)
ggplot(aes(x = ABU))

x <- data.frame(Group = "Ale", c(1:552)) %>% select(Group) 
glimpse(x)
final_Ales <- cbind(x, Ales)
ggplot(aes(x = ))
final_IPAs %>% filter(!grepl("Lager", Style))
head(final_Ales)

y <- data.frame(Group = "IPA", c(1:395)) %>% select(Group)
final_IPAs <- cbind(y, IPAs)
head(final_IPAs)
inner_join(final_IPAs, final_Ales, by = "Beer_ID")
head(firstattempt)
inner_join(final_IPAs, final_Ales, by = "Group")
IPA_Ales <- full_join(final_IPAs, final_Ales) %>% filter(!grepl("Lager", Style))
here()
library(tidyverse)
library(here)
here()
write_csv(IPA_Ales, "/Users/joaquindominguez/Dropbox/SMU/Doing Data Science/git/Case-Study-1/IPA_Ales.csv")

IPA_Ales %>% ggplot(aes(x = IBU, y = ABV, color = Group)) + geom_point() + theme_bw() + ggtitle("Measuring ABV and IBU in IPAs and Ales")
head(IPA_Ales)
library(class)
library(caret)
classifications = knn.cv(IPA_Ales[,8:9], IPA_Ales$Group, k = 3)
CM <- data.frame(classifications = classifications, true = IPA_Ales$Group)
confusionMatrix(table(knn.cv(IPA_Ales[,8:9], IPA_Ales$Group, k = 3), IPA_Ales$Group))

set.seed(1)
iterations = 500
numks = 50

masterAcc = matrix(nrow = iterations, ncol = numks)

for(j in 1:iterations)
{
  
  for(i in 1:numks)
  {
    CM = confusionMatrix(table(IPA_Ales$Group, knn.cv(IPA_Ales[,8:9], IPA_Ales$Group, k = i)))
    masterAcc[j,i] = CM$overall[1]
    
  }
  
}

MeanAcc = colMeans(masterAcc)

plot(seq(1,numks,1),MeanAcc, type = "l")

which.max(MeanAcc)
max(MeanAcc)

confusionMatrix(table(IPA_Ales$Group, knn.cv(IPA_Ales[,8:9], IPA_Ales$Group, k = 8)))

nbIPA_Ales <- IPA_Ales %>% select(Group, ABV, IBU)
library(e1071)
naiveBayes(Group~., data = nbIPA_Ales )
head(nbIPA_Ales)

iterations = 100
masterAcc = matrix(nrow = iterations)
splitPerc = .8 #Training / Test split Percentage
for(j in 1:iterations)
{
  trainIndices = sample(1:dim(nbIPA_Ales)[1],round(splitPerc * dim(nbIPA_Ales)[1]))
  train = nbIPA_Ales[trainIndices,]
  test = nbIPA_Ales[-trainIndices,]
  model = naiveBayes(train[,2:3],train$Group)
  table(test$Group,predict(model,test[,2:3]))
  CM = confusionMatrix(table(test$Group,predict(model,test[,2:3])))
  masterAcc[j] = CM$overall[1]
}
MeanAcc = colMeans(masterAcc)
MeanAcc
Mean
masterAcc
plot(seq(1,numks,1),MeanAcc, type = "l")
max(masterAcc)

nbIPA_Ales %>% ggplot(aes(x = IBU, y = ABV, color = Group)) + 
  geom_point() + 
  facet_wrap(~Group) +
  geom_smooth(method = 'lm') +
  theme_bw() +
  ggtitle("Distribution of ABV and IBU")

head(final_Ales)

Ales_ABV <- final_Ales %>% select(ABV, Group)
IPAs_ABV <- final_IPAs %>% filter(!grepl("Lager", Style)) %>% select(ABV, Group)
head(Ales_ABV)
head(IPAs_ABV)

ABVjoin <- full_join(Ales_ABV, IPAs_ABV)



t.test(ABV ~ Group, data = IPA_Ales)

head(IPA_Ales)

t.test(IBU ~ Group, data = IPA_Ales)

IPA_Ales

confusionMatrix(table(knn.cv(IPA_Ales[,8:9], IPA_Ales$Group, k = 3), IPA_Ales$Group))
nb2 <- IPA_Ales %>% select(State, Group) %>% mutate(State = as.factor(State))
model <- naiveBayes(Group~., data = nb2)
model
predict(model, data.frame(State = "NH"), type = 'raw')
head(nb2)
Stylegeo <- join %>% select(Style, City, State)
here()
write_csv(Stylegeo, "/Users/joaquindominguez/Dropbox/SMU/Doing Data Science/git/Case-Study-1/Stylegeo.csv")

Stylecount %>% ggplot(aes(x = Style, y = n)) + geom_histogram(stat = 'identity') + coord_polar()


library(tidyverse)
df <- join %>% select(Style, City, State)
head(join)
model <- naiveBayes(Style~., data = df)
predict(model, data.frame(State = "CT", City = "Stamford"))
head(df)
model <- naiveBayes(City~Style, data = df)
predict(model, data.frame(Style = "American IPA"))
