
# coding: utf-8

# In[64]:


import pandas as pd
import os
os.chdir("C:\\Users\\Rashmi HP\\Downloads")  #to set working directory


# In[65]:


os.getcwd()


# In[66]:


stack=pd.read_csv("stackoverflow-1.csv")


# In[67]:


stack.shape


# In[68]:


stack.head()


# In[69]:


stack.isnull().sum()


# In[70]:


type(stack)


# In[71]:


stack['Country'].unique()
#len(stack['Country'].unique())


# In[73]:


stack.describe()


# In[158]:


stack[(stack['Country'] == 'India') & (stack['Datascientist'] == 1)].shape


# In[155]:


stack.groupby('Country')['Datascientist'].count()


# In[76]:


stack["Remote"].shape


# In[77]:


stack[stack.Remote=='Remote'].shape


# In[78]:


filtered_df = stack[(stack['Country'] == 'Germany') & (stack['YearsCodedJob'] > 10)]


# In[79]:


filtered_df.shape


# In[47]:


filtered_df


# In[80]:


stack.groupby('Country')['Salary'].mean().sort_values(ascending=False)


# In[81]:


dummies= pd.get_dummies(stack['Remote'])


# In[83]:


dummies.head()


# In[86]:


df_merged = stack.merge(dummies, how='outer', left_index=True, right_index=True)


# In[94]:


df_merged.head()


# In[161]:


df_merged.groupby('Country')['Remote_y'].sum().sort_values(ascending=False)


# In[109]:


stack["Mobile developer"].shape


# In[163]:


stack.loc[stack['Mobile developer'] == 1].shape


# In[165]:


stack.loc[stack['Web developer'] == 1].shape


# In[132]:


d


# In[133]:


d1


# In[167]:


stack[(stack.Mobile developer==1) & (stack.Web developer == 1)]


# In[168]:


stack[(stack['Mobile developer'] == 1 & stack['Web developer'] == 1)]


# In[135]:


stack.groupby('Country')['Salary'].max()


# In[136]:


stack.groupby('Country')['YearsCodedJob'].mean()


# In[137]:


def get_label(x):
    if x<20:
        return 'Low'
    elif x>=20 and x<=1000:
        return 'medium'
    
    else:
        return 'High'


# In[139]:


stack['Company_label']=stack['CompanySizeNumber'].map(get_label)


# In[ ]:


lc['grant_rate']=lc['funded_amnt']/lc['loan_amnt']


# In[146]:


stack.loc[stack['Company_label'] == 'Low'].shape

