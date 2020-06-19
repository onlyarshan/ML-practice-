###===================================================================================================###
###                                      Apriori Algorithm                                           ###
###                                Using R(Market Basket Analysis)                               
###===================================================================================================###
# 1. Basic Terminologies of Association Rules mining
#=======================================================================================================
#load association rules mining libraries and dataset
library(arules)
library(arulesViz)
data('Groceries')#in built dataset in arules in R
summary(Groceries) #now look at the console
##density tells us about empty cells(total items brought/total no of possible items)
##i.e (total items are purchase/9835*165)
##element refers how many items for each separated row(2159 for row 1
inspect(Groceries[1:3])# returns a set of all items purchases in 1st 3 transactions
#=======================================================================================================
#Support 
#=======================================================================================================
#tells - how frequently or in what proportion does an item occur
##Formula = support(A->B)=Transaction containing Items A and B/Total Number of transactions
itemFrequencyPlot(Groceries,support=0.20) # shows only whole milk (very high support)
itemFrequencyPlot(Groceries,support=0.10)# shows a plot of transaction of all items with 10
##what this means is that 10 percent of transaction have these items clubbed together
itemFrequencyPlot(Groceries,topN-5)# shows top 5 frequent occurring items
#=======================================================================================================
#Confidence 
#=======================================================================================================
##its like conditional probability how likely to buy item c(given a and b are already brought)
## formula confidence(a and b -> c)= support(a,b,c)/support(a,b)percent support
##what this means is that 10 percent of transaction have these items clubbed together
#=======================================================================================================
#Lift 
#=======================================================================================================
#This says how likely item A is purchased when item B is purchased 
#lift greater than 1 shows that item A is likely to be brought by item B
#lift equal to 1 implies no association between item A and B
#lift Less than 1 shows that item A is  unlikely to be brought by item B
###===================================================================================================###
# 2. Apriori Algorithm
#=======================================================================================================
#Apriori Algorithm is one of the most important algorithm which is used to extract frequent itemsets 
#from large database and get the association rule for discovering the knowledge
#lets create and compare rules using apriori algorithm
rule1<- apriori(Groceries,parameter =  list(support=0.002, confidence=0.5, minlen=2))
##this means 0.2% of all the orders have the consequent and the antecedent and atleast 25% of all them antecedent should have a consequent
inspect(head(rule1,5)) #shows top 5 rules
##the no 1 rules says 0.3%orders contain both cereals and whole milk and 65% of orders which have cereal have whole milk 
##here the lift tells us how significant is the consequent(rhs) wrt to the antecedent(lhs)
#sorting on basis of lift
inspect(head(sort(rule1,by='lift'),5))
plot(rule1)#a visual of support vs confidence with lift
#rule 2
rule2<- apriori(Groceries,parameter =  list(support=0.002, confidence=0.5, minlen=5))
inspect(head(rule2,5))
plot(rule2,method = 'rule')
#rule 3
rule3<- apriori(Groceries,parameter =  list(support=0.002, confidence=0.5))
inspect(head(rule3,10))
plot(rule3,method = 'grouped')
###===================================================================================================###
# 3. Conclusion
#=======================================================================================================
#This apriori algorithms is very useful for identifying products of interest relative to 1 product
#it can be used in promtional stratgizing, trend analysis, pricing, marketing Analytics etc.
#From the groceries dataset we can conclude that most whole milk is the most frequent itemset in the transaction
#Also from the groceries dataset it is very likely that hardcheese is brought with butter since both show a very high lift(in reality it may not be the case)