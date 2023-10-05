#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


# In[4]:


df = pd.read_csv(r"C:\Users\Owner\OneDrive\Documents\Python Web Scrapping\world_population.csv")
df


# In[7]:


pd.set_option('display.float_format',lambda x:'%.2f' %x)
df


# In[8]:


df.info()


# In[9]:


df.describe()


# In[10]:


df.isnull().sum()


# In[11]:


df.nunique()


# In[13]:


df.sort_values(by="2022 Population").head()


# In[15]:


df.sort_values(by="2022 Population",ascending=False).head(10)


# In[16]:


df.corr()


# In[22]:


sns.heatmap(df.corr(),annot=True)

plt.rcParams['figure.figsize'] = (20,7)

plt.show()


# In[23]:


df


# In[24]:


df[df['Continent'].str.contains('Oceania')] #GROUPING DATA


# In[47]:


df2 = df.groupby('Continent')[['1970 Population',
       '1980 Population', '1990 Population', '2000 Population',
       '2010 Population', '2015 Population', '2020 Population',
       '2022 Population']].mean().sort_values(by="2022 Population",ascending=False)
df2


# In[48]:


df.columns


# In[49]:


df3 = df2.transpose()
df3


# In[50]:


df2.plot()


# In[51]:


df3.plot()


# In[57]:


df.boxplot(figsize=(20,10))


# In[58]:


df.dtypes


# In[63]:


df.select_dtypes(include='number')


# In[64]:


df.select_dtypes(include='float')


# In[65]:


df.select_dtypes(include='object')


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




