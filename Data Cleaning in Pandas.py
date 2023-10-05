#!/usr/bin/env python
# coding: utf-8

# In[109]:


import pandas as pd


# In[110]:


df = pd.read_excel(r"C:\Users\Owner\OneDrive\Documents\Python Web Scrapping\Customer Call List.xlsx")
df


# In[111]:


df.drop_duplicates()


# In[112]:


df = df.drop(columns= "Not_Useful_Column")
df


# In[113]:


#df['Last_Name'] = df['Last_Name'].str.lstrip("...")
#df['Last_Name'] = df['Last_Name'].str.lstrip("/")
#df['Last_Name'] = df['Last_Name'].str.rstrip("_")
#df


# In[114]:


df["Last_Name"] = df["Last_Name"].str.strip("123._/")
df


# In[115]:


df 


# In[116]:


df["Phone_Number"].str.replace('[^a-zA-Z0-9]','')


# In[117]:


df["Phone_Number"] = df["Phone_Number"].str.replace('[^a-zA-Z0-9]','')
df


# In[118]:


#df["Phone_Number"].apply(lambda x: x[0:3]+'-'+x[3:6]+'-'+x[6:10])
str(df['Phone_Number'])


# In[119]:


df["Phone_Number"].apply(lambda x: str(x))


# In[120]:


df["Phone_Number"] = df["Phone_Number"].apply(lambda x: str(x))
df


# In[121]:


df["Phone_Number"].apply(lambda x: x[0:3]+'-'+x[3:6]+'-'+x[6:10])


# In[122]:


df["Phone_Number"] = df["Phone_Number"].apply(lambda x: x[0:3]+'-'+x[3:6]+'-'+x[6:10])
df


# In[123]:


df["Phone_Number"] =df["Phone_Number"].str.replace('nan--',' ')
df["Phone_Number"] = df["Phone_Number"].str.replace('Nan-',' ')
df["Phone_Number"] = df["Phone_Number"].str.replace('Na--',' ')
df


# In[127]:


df[["Street_Address","States","Zip_Code"]] = df["Address"].str.split(',',2,expand=True)
df


# In[130]:


df["Paying Customer"] = df["Paying Customer"].str.replace('Yes','Y')
df["Paying Customer"] = df["Paying Customer"].str.replace('No','N')
df


# In[133]:


df["Paying Customer"] = df["Paying Customer"].str.replace('N/a','')
df


# In[134]:


df["Do_Not_Contact"] = df["Do_Not_Contact"].str.replace('Yes','Y')
df["Do_Not_Contact"] = df["Do_Not_Contact"].str.replace('No','N')
df


# In[144]:


#df.replace('N/a',' ')
#df.replace('Nan',' ')
df = df.fillna('')
df


# In[148]:


for x in df.index:
    if df.loc[x,'Do_Not_Contact'] == 'Y':
        df.drop(x,inplace=True)    
        
df


# In[150]:


for x in df.index:
    if df.loc[x,"Phone_Number"] == ' ':
        df.drop(x,inplace=True)    
        
df

#Another way to drop null values
#df = df.dropna(subset="Phone_Number"),inplace=True


# In[152]:


df.reset_index(drop=True)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




