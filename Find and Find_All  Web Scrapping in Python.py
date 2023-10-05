#!/usr/bin/env python
# coding: utf-8

# In[4]:


from bs4 import BeautifulSoup
import requests


# In[8]:


url = 'https://scrapethissite.com/pages/forms/'


# In[9]:


page = requests.get(url)


# In[10]:


soup = BeautifulSoup(page.text,'html')


# In[11]:


print(soup)


# In[12]:


soup.find('div')


# In[14]:


soup.find_all('div')


# In[18]:


soup.find_all('div',class_ ='col-md-12')


# In[19]:


soup.find_all('p')


# In[22]:


soup.find('p', class_ = 'lead').text.strip()


# In[25]:


soup.find_all('th')


# In[26]:


soup.find('th').text.strip()


# In[ ]:




