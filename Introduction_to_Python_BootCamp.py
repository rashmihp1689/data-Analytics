
# coding: utf-8

# In[ ]:


#Guido Von Rossum 


# In[6]:


#Basic Data structures in python

#integer
i=27
print(type(i))
print(i)


# In[3]:


#float
j=27.4
type(j)


# In[9]:


#Python as calculator
#Arithmetic operations
sum=i+j
print(sum)
print("sum="+str(sum))


# In[8]:


sub=27-20
print(sub)


# In[10]:


product=5*20
print(product)


# In[13]:


division=20/5 #returns float
division=20//5 #the result will be an integer not float
print(division)
type(division)


# In[14]:


#Strings and Boolean
text='Introduction to Python'
type(text)


# In[15]:


logical=True
type(logical)


# In[16]:


#Arithmetic Operations on text
#+ concatinates two string
text1=" and data Manipulation with Python"
topic=text+text1 #same type
topic


# In[17]:


#* creates copies of string
text*3


# In[20]:


#Convert integer to string
k=str(i)
type(k)


# In[21]:


#Question: Can a variable name start with a number in Python?
5_x=3


# In[22]:


_x=3


# In[ ]:


#Question: How will you assign more than one value to a variable?


# In[24]:


#Lists:which can contain multiple data type
myfirstlist=[5,"Age",True,5.5]
type(myfirstlist)
print(myfirstlist)


# In[25]:


#A list can contain list within the list
list1=[1,"Gender",False,2.3,[2,3]]
type(list1)


# In[27]:


#Question: create a list with values 8 9.5 "Python" True and store as new_list
New_list=[8,9.5,"Python",True]
print(New_list)


# In[29]:


#index/slicing
#Python has zero based index
l=[11,12,13,'a','b','c']


# In[30]:


l[:] #Return all the elements by using colon
l[:]


# In[31]:


l[0] #index starts with 0
l[0]


# In[35]:


#[start:end], start is inclusive in the list, end is exclusive
l[2:4]


# In[ ]:


l[2:4] #Return second and third index elements use 2:4


# In[37]:


l1=[] #Creates an empty list


# In[39]:


#Question: Extract first two index elements from "new_list"
New_list[0:2]


# In[40]:


#Negative indexing
l[-1] #Return last element


# In[41]:


l[::-1]#print all element in reverse order [start:end:step]
#start & end values are blank, only step is given as -1


# In[43]:


print(l[-1])
print(l[-2]) #To print second last element


# In[44]:


l[::2]#print all alternate elements
#no start, no end, only skip is given as 2


# In[45]:


l[2:-1]#start from second index element and skip last one #same as l[2:5]
l[2:5] #also gives same result


# In[49]:


#[start:end:step]
l[-1:-3:-1] #print last two elements (start is last element c, end is second element (so 3))
l[-1:-2:-1] #prints only the last element


# In[47]:


#Question: print the list new_list in reverse order
New_list[::-1]


# In[48]:


l


# In[50]:


#List Manipulation
#Change a value
l[0]=10 #Element at index 0 is replaced with 10
l


# In[51]:


#Add a value or list
l1=l+[14]
l1


# In[52]:


l2=l+[15,'d']
l2


# In[53]:


#Remove a value
del(l[0])


# In[54]:


l


# In[55]:


#Copying the values  Using a method.copy enables 2 lists to be created, both similar to each other, change in one will not affect another
l3=l2.copy() #or l2[:]


# In[56]:


print(l2)
print(l3)


# In[57]:


l2[0]=0


# In[58]:


print(l2)
print(l3)


# In[59]:


#Copy  If = is used as assignment operator, only the index is copied & the change in one list will reflect in another list also
l4=l2


# In[60]:


print(l2)
print(l4)


# In[63]:


l2[0]=0
print(l2)
print(l4)


# In[ ]:


#Functions vs Methods


# In[ ]:


#Functions are called by its name.
##Functions are independent of object


# In[125]:


#Functions in python
#A reusable function aimed to perform particular task.
l5=[13,9,0,11,15,2]


# In[65]:


sorted(l5) #ascending order    #explicitly passed the object


# In[66]:


sorted(l5,reverse=True) #descending order 


# In[67]:


len(l5)


# In[68]:


max(l5)


# In[ ]:


#Methods are called by its name.
#Methods are dependent on object


# In[69]:


topic


# In[70]:


#Methods: Python objects have associated methods
#index() method will work both on numeric and string

topic.index('and') #implicitly passed the object


# In[71]:


topic


# In[72]:


l5.index(0)


# In[76]:


l5.insert(2,100)  #.insert is a method used to insert an object into the list.
l5


# In[77]:


a='1376254'
sorted(a)


# In[ ]:


a


# In[79]:


mylist=[3,2,1]
sorted(mylist)


# In[80]:


mylist


# In[81]:


mylist = [3, 1, 2]
mylist.sort()


# In[82]:


mylist


# In[ ]:


#Functions can't change the object
#Methods may change the object


# In[85]:


topic


# In[84]:


lower_topic=topic.lower() #lower case


# In[86]:


topic.replace("and","AND")


# In[87]:


l5.replace(0,1) #replace is not a method for numeric type data


# In[95]:


set(range(30,100,10))  #set is a function used to get the output; range is a function


# In[92]:


#Iterables and Iterator
#Convert a range of values as string
for w in range(30,100,10):
    print("Value "+str(w))


# In[93]:


#Question: Print the values between 5 to 10 in steps of 1
for w in range(5,11,1):
    print(w)


# In[ ]:


topic


# In[96]:


d=0 #Start the count with 0
e=0
for i in topic:
    if i.isupper(): #Looking for upper case in text
        d=d+1
    elif i.islower(): #Looking for lower case in text
        e=e+1
print("Number of Upper case characters are") 
print(d)
print("Number of lower case characters are")
print(e)


# In[97]:


r=range(0,10,1)
set(r)


# In[98]:


r=range(0,10,1)
for x in r:
    y=x+1
    print(y)


# In[99]:


#List Comprehension # Best alternative for for loops while doing numeric/string manipulations
y=[x+1 for x in r]  #output is a list


# In[100]:


y


# In[101]:


model=['Buick','Cadillac','Chevrolet','Pontiac','Saturn','SAAB']
price=[20815,40936,16428,18412,13979,29495]


# In[102]:


#Pair Wise list elements
pairs=[[m,p] for m in model for p in price]


# In[103]:


pairs #What am I missing?


# In[104]:


pairs_index=[[m,p] for m in model for p in price if model.index(m)==price.index(p)]  #To get only one on one mapping same length


# In[105]:


pairs_index


# In[106]:


#Conditional
x=[23,21,4,53,1]
y=[2,21,23]


# In[107]:


pairs_index=[[a,b] for a in x for b in y if x.index(a)==y.index(b)]


# In[108]:


pairs_index  #as the last 2 indices have no corresponding value in y, they are ignored


# In[109]:


z=[a for a in x if a not in y] #elements in x which are not in y


# In[110]:


z


# In[111]:


# Check whether a value exist in the given list
3 in z


# In[112]:


1 in z


# In[113]:


l


# In[114]:


#Print only string values
[x for x in l if type(x)==str]


# In[115]:


[x*10 for x in l if type(x)==int]


# In[116]:


[x/10 for x in l if type(x)==int]


# In[ ]:


#Question: Extract integer values from the list l and divide by 10


# In[117]:


#Lambda to create small or one time use function and map requires a function to be applied on multiple or one list.
#map is used to pass the function defined by lambda (can also use predefined functions) on a list/lists
a=[1,2,3,4]
b=[2,2,2,2]
product=map(lambda x,y:x*y,a,b)


# In[118]:


product


# In[119]:


#Extract values
set(product)


# In[123]:


#Extract strings of length>5 from a list
strings=filter(lambda x:len(x)>5,['Buick','Cadillac','Chevrolet','Pontiac','Saturn','SAAB'])
strings=filter(lambda x:len(x)==4,model)


# In[124]:


set(strings)


# In[126]:


#Tuples  #objects specificed in a tuple are fixed & cannot be changed
empty=()
t=(1,2,3,4,5)
tuple='t1','t2'


# In[127]:


print(tuple)
print(t)


# In[128]:


t[0]=0 


# In[ ]:


#Question: #Extract strings of length=4 from the list model


# In[129]:


print(model)
print(price)


# In[130]:


#Dictionary: key value pairs
dict={'Make':model,'Price':price}  #access the dictionary using the key - Model list has been assigned the key Make


# In[131]:


type(dict)


# In[132]:


dict.keys()


# In[133]:


dict


# In[134]:


#index/slicing
dict['Make'][0]


# In[135]:


#Change a value
dict['Price'][4]=20000


# In[136]:


dict


# In[138]:


#Dictionary inside a dictionary  like sub-lists inside a list
info1={'Gender':'Male','Income':20000}
info2={'Gender':'Male','Income':25000}
income={'John':info1,
       'Mathew':info2}  #For key value John, Gender is Male & Income is 20000 etc.


# In[139]:


income


# In[140]:


income["Mathew"]["Income"]  To access the values (Mathew s income) from a dictionary using keys


# In[141]:


#How to install a library?
#Question: install the package numpy
#pandas is a package in Python
get_ipython().system('pip install pandas')
import pandas as pd


# In[142]:


#Pandas
#Series: one-dimensional
import pandas as pd # as pd means will refer to this library as pd henceforth
import numpy as np  #numpy is another library that is imported & referred to further as np
s=pd.Series([4,3,2,1]) #default index  .Series is a method used to create a series in pandas


# In[148]:


print(s)
type(s)


# In[149]:


s1=pd.Series({'a':1,'b':2,'c':3,'d':4})  A Series object is created using dictionary &  keys


# In[150]:


print(s1)
type(s1)


# In[151]:


s1['a']


# In[152]:


s2=pd.Series(np.array([1,2,3,4]),index=['a','b','c','d'])


# In[153]:


s2  #dtype : int32 is where the output is stored, storage location 


# In[155]:


#Question: Understand the output of pd.Series(4,index=[0,1,2,3])
#the value of 4 is stored in multiple indices
s3=pd.Series(4,index=[0,1,2,3])
s3


# In[156]:


#Data Frames: two-dimensional data structure ie: [rows,columns]
dict


# In[157]:


df=pd.DataFrame(dict)


# In[158]:


df  #The keys of the dictionary become the column names in the data frame


# In[162]:


#Rename columns
df=df.rename(columns={'Make':'Model','Price':'Amount'})
df


# In[160]:


print(dir(df))  #lists all the attributes, fucntions or methods that can be used on this dataframe object


# In[163]:


#Extract column names
df.columns


# In[165]:


#Question: Debug the code
df1=pd.DataFrame({'c1':s1},{'c2':s2})


# In[ ]:


#its possible to extract rows based on label & positions


# In[166]:


#loc: label based
df.loc[0:3]  #extracts based on the labels


# In[167]:


#iloc:position based
df.iloc[0:3]  #extracts based on index, hence end point is exclusive


# In[171]:


#Merging Data Frames
#Need to have atleast one common variable
import pandas as pd
A=pd.DataFrame({'X1':['a','b','c'],'X2':[1,2,3]})
B=pd.DataFrame({'X1':['a','b','d'],'X3':[True,False,True]})
print(A)
print(B)


# In[172]:


pd.merge(A,B,how='left',on='X1') #Based on A(left)  Dataset A is unchanged, only adds columns from B to it.


# In[173]:


pd.merge(A,B,how='right',on='X1') #Based on B(right) Dataset B is unchanged, only adds columns from A to it.


# In[174]:


pd.merge(A,B,how='inner',on='X1') #Matching ids


# In[175]:


pd.merge(A,B,how='outer',on='X1') #combine all


# In[177]:


#Pandas
#Using all the dummy variables will cause linear dependency among them.  hence we need to create only n-1 dummy variables
#Find the proportion of factors to total, then group them into categories...will reduce from say 10 levels to 3 levels.
#do the dummy variables for these 2 only.
#Will convert all the strings into dummies, delete original 
dummies= pd.get_dummies(df)


# In[178]:


dummies


# In[143]:


#importing data into Python
import pandas as pd
import os
os.chdir("C:\\Users\\Jyothi\\Desktop\\Jigsaw\Python\\")  #to set working directory


# In[182]:


os.getcwd()  #to view working directory


# In[144]:


store=pd.read_csv("Store.csv")
#All text files are encoded using utf-8..if it is not, you have to decode using latin1 


# In[6]:


store=pd.read_csv("Store.csv",encoding='latin1')


# In[7]:


#Look at first few observations of the data
store.head()  #shows only 5
store.shape  #dim function in R


# In[4]:


#Import excel files into python using Pandas
#install xlrd first
get_ipython().system('pip install xlrd')
import pandas as pd
from pandas import ExcelWriter
from pandas import ExcelFile
wine=pd.read_excel("C:\\Users\\Jyothi\\Desktop\\Jigsaw\\Python\LCDataDictionary.xlsx",sheet_name='LoanStats')
wine.head()
wine.shape
wine


# In[231]:


store[0:3:]  #selects first 3 rows 0 is start, 3 is end for row range & : blank refers all columns
store["Ship Date"] #to select a particular column
store[0:3]["Ship Date"] #selecting only 3 rows of Shipto Date column 
store.iloc[[0,1],0:3]  #Selecting 2 rows & first 3 columns of data
store.iloc[:,0:3] # select all the rows of the first 3 columns
store.loc[:,'Order Date'] #Select all rows of column order date
p = ["Order Date", "Ship Date"]
print (p)
store.loc[:,p]


# In[145]:


#read jason file
#import pandas as pd
#data=pd.read_json("C:\\Users\\......amsterdam.json")


# In[146]:


#Data Manipulation with Python
import pandas as pd
import os
os.chdir("C:\\Users\\Jyothi\\Desktop\\Jigsaw\Python\\")  #to set working directory
lc=pd.read_csv("LC.csv",error_bad_lines=False,na_values=[""," ","  "]) #Avoid out message error


# In[229]:


lc.head()


# In[230]:


lc.shape


# In[10]:


#Question: what is the shape of the data frame "store"
store.shape
store.isnull().sum()


# In[9]:


#Check for missing values in each column of data frame "lc".
lc.isnull().sum()


# In[11]:


#Dropping variables
#axis=1 looks at the column vertically & axis=0 looks at the specified names like zipcode rowwise.
lc.drop(['zip_code','emp_length'],axis=1).shape


# In[12]:


#Understand the distribution of interest rate variable 'int_rate'
lc['int_rate'].head()
#As the numeric manipulations can be done only on numeric & float, we need to remove the %


# In[19]:


lc['int_rate']=lc['int_rate'].str.replace("%","").astype("float64")
#converting to float format as it has decimals in it.
#lc['int_rate']=lc['int_rate'].str.replace("$,","").astype("float64") to remove both $ & ,
#If 2 items $ & , cannot be given in the same step, do 2 steps one after the other.
#If there are rows with blank spaces, first convert the single/double/blank spaces into NA while importing.
#Without this step, if we try to convert string to float will not work.


# In[20]:


lc['int_rate'].head()


# In[21]:


#Missing data
lc['int_rate'].isnull().sum()


# In[22]:


# fill missing values with mean column values
#Using .fillna method
#The position of the missing values will be found using inplace=True
lc['int_rate'].fillna(lc['int_rate'].mean(), inplace=True)


# In[23]:


lc['int_rate'].isnull().sum()


# In[25]:


#Question: How many missing values are there in the column "Region"
store['Region'].isnull().sum()


# In[26]:


lc['int_rate'].describe()
#Understanding the distribution of interest rate, its positively skewed as mean more than median


# In[31]:


np.arange(0,1.01,0.01)


# In[32]:


lc['int_rate'].quantile(np.arange(0,1.01,0.01))
#From the below table, we find that Upto 89% of the customers have interest rate less than 17%


# In[ ]:


#Any questions?


# In[35]:


import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline #Used to tell python to plot the graph right below the code.')


# plt.hist(lc['int_rate'])
# plt.title("Histogram of int_rate")
# plt.xlabel('int_rate')

# In[37]:


plt.hist(lc['int_rate'])
plt.title("Histogram of Int_rate")
plt.xlabel('int_rate')  # The output shows text(0.5,0,'int_rate') - this is the size of the label of x-axis


# In[38]:


##What is the average interest rate according to number of payments on the loan? (Number of payments on the loan=Term/Tenure)
#Groupby variable, then count by what variable in sqr brackets
lc.groupby('term')['term'].count()


# In[39]:


lc['term'].isnull().sum()


# In[41]:


lc['term'].fillna("36months",inplace=True)
lc.groupby('term')['term'].count()


# In[42]:


avg_int=lc.groupby('term')['int_rate'].mean()


# In[43]:


avg_int


# In[47]:


#Checks for all records with 36 months term & loan amount greater than 5,000, get the interest rate info.
lc.query("term=='36months' & loan_amnt>5000")[['int_rate']].head()
lc.query("term=='36months' & loan_amnt>5000")[['int_rate']].shape


# In[49]:


#Is there any relationship between "Purpose" and "int_rate"?
lc['purpose'].unique()
len(lc['purpose'].unique())


# In[50]:


df_count=lc.groupby('purpose')['int_rate'].mean().sort_values(ascending=False)


# In[51]:


#After grouping the data by purpose, doing the mean of interest rates & sorting them in descending order
#Highest avarege interest rates is for small business, leavest avg interest rate is for purpose car loan
df_count


# In[52]:


df_count.plot.bar()
plt.title("Bar chart")


# In[57]:


#Question: Find the average Profit by Segments
store.head()
ss=store.groupby('Segment')['Profit'].mean().sort_values(ascending=False)


# In[58]:


ss


# In[64]:


ss.plot.pie()
plt.title("Pie chart")
#can use subplots method to arrange 2 graphs next to each other


# In[62]:


#Based on term find average interest rate and sum of loan amount
#.agg method works in dictionary format, specify key then :the summary statistic to be used
#can add commas & give more items if needed
#we are also using the np library here
lc.groupby('term').agg({'int_rate':np.mean,'loan_amnt':np.sum})


# In[65]:


#How does the average grant rate differ by income levels?
#Ratio of funded amount vs. loan amount is referred to as grant rate
lc['annual_inc'].quantile(np.arange(0,1,0.01))


# In[66]:


#Create Bins for income levels
#Defining a function...passing only one parameter x
def get_label(x):
    if x<= 30000:
        return 'Group1'
    elif x>30000 and x<=60000:
        return 'Group2'
    elif x>60000 and x<=90000:
        return 'Group3'
    else:
        return 'Group4'


# In[67]:


#using .map method, we are applying the defined function on the column annual income in lc dataset
lc['label']=lc['annual_inc'].map(get_label)


# In[68]:


lc['grant_rate']=lc['funded_amnt']/lc['loan_amnt']


# In[69]:


lc.groupby('label')['grant_rate'].mean()


# In[70]:


#Relation between loan amount and funded amount (2 continuous variables)
#selecting only 100 records (0 to 99 rows) for ease of visibility
plt.scatter(lc['loan_amnt'][:100],lc['funded_amnt'][:100])


# In[71]:


##Impact of Ownership on loan status
lc.groupby('home_ownership')['loan_status'].count()/lc.shape[0]


# In[76]:


#Extract the records which are beyond 0.99 percentile in int_rate variable
lc[lc['int_rate']>lc['int_rate'].quantile(0.99)].shape[0]
lc['int_rate'].quantile(0.99)
#There are 408 people whose interest rate is higher than 20.99% (or 99th quartile)


# In[ ]:


#Define date format of a date variable
import pandas as pd
data=pd.DataFrame({'date':["01/08/2018","02/08/2018","03/08/2018","04/08/2018","05/08/2018","30/07/2018","31/07/2018"],
 'C':[9.3430,9.3039,9.2784,9.2858,9.2834,9.3178,9.3434]})


# In[ ]:


data


# In[ ]:


data.dtypes


# In[ ]:


data['date']=pd.to_datetime(data['date'],format="%d/%m/%Y")
data


# In[ ]:


data['date'].dt.strftime('%m/%d/%Y')


# In[147]:


#Convert data frame into json format
import pandas as pd
import json
df=pd.DataFrame({'Schools':[[77.621,12.99699],[-124.2548333, 40.6763333],[-116.02, 31.6225]]})
df['City']=['Bangalore','Chennai','Puduchery']
file= json.loads(df.T.to_json()).values()  #converts dataframe transform to json..junk file like txt file - all types of data can be stored in json


# In[148]:


df


# In[149]:


file


# In[79]:


type(file)  #looks like a dictionary


# In[150]:


#Appending elements after extraction
#A new list is created long where look for data in file whereever key is schools, look for first indext &
#store it in empty list long
long=[]
for data in file:
    long.append(data['Schools'][0])
long


# In[152]:


#Extract lattitude and city info
lat=[]
for data in file:
    lat.append(data['Schools'][1])
lat
type(lat)


# In[153]:


city=[]
for data in file:
    city.append(data['City'])
city


# In[160]:


new=pd.DataFrame({'lat':lat,'long':long})
new['city']=df['City']
new
type(new)


# In[ ]:


import pandas as pd
data=pd.DataFrame({'date':["01/08/2018","02/08/2018","03/08/2018","04/08/2018","05/08/2018","30/07/2018","31/07/2018"],
 'C':[9.3430,9.3039,9.2784,9.2858,9.2834,9.3178,9.3434]})


# In[ ]:


data['date']=pd.to_datetime(data['date'])


# In[ ]:


data.date.dt.weekday #weekday index starts with zero


# In[89]:


store.head()  #To look at top 5 rows of store dataset


# In[86]:


store.columns  #to get all the columns in store database


# In[84]:


store.Sales.describe() #to look at summary of sales column in store database


# In[90]:


#Manipulate dates
store['Order Date'].head()


# In[99]:


#specifies the date format
#telling python my column has date in month, date & year format.
#we are not worried how it stores it
store['Order Date']=pd.to_datetime(store['Order Date'],format="%m/%d/%Y")
store['Order Date'].head()  #How it stores in python is what is displayed below


# In[97]:


#Pulling out the month from the date & storing in new column
store['month']=store['Order Date'].dt.strftime('%B')


# In[98]:


store['month'].unique()


# In[102]:


store.dtypes #shows the structure of all the columns in the dataset; same as str() in R


# In[104]:


#How many records corresponds to month April with sales >209
store.query("month=='April' & Sales > 209").shape


# In[105]:


store['ref date']=pd.to_datetime('19-03-2019',format="%d-%m-%Y")


# In[106]:


store['ref date'].head()


# In[107]:


store['years']=(store['ref date']-store['Order Date'])/np.timedelta64(1,"Y")


# In[108]:


store['years'].head()


# In[118]:


store['months']=(store['ref date']-store['Order Date'])/np.timedelta64(12,"M")


# In[119]:


store['months'].head()


# In[115]:


#In python, monday index is zero & sunday is 6 - called as date index
#No date index in R
pd.to_datetime("19-03-2019",format="%d-%m-%Y").weekday()


# In[116]:


pd.to_datetime("today").weekday()


# In[117]:


pd.to_datetime("now")


# In[120]:


vars().keys()  #similar to ls()


# In[121]:


_i78  #Ref id for codes that we ran but did not store


# In[129]:


#Index of nth occurence
l5=[13,9,0,11,15,2,0]
[i for i,n in enumerate(l5) if n==0]


# In[130]:


set(enumerate(l5))  #first value is index & second is the value in the list

