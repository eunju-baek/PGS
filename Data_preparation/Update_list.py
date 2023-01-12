import requests
from bs4 import BeautifulSoup
import pandas as pd
import re




pd.set_option('display.max_seq_items',None)
pd.set_option('display.max_rows',None)
pd.set_option('display.max_columns',None)


url = "https://www.pgscatalog.org/browse/scores/"

r = requests.get(url = url)

bs = BeautifulSoup(r.content, "lxml")

tbls = bs.select("table")

for i in tbls:
    a = i.select("a")
    

link = []
for i in tbls:
    link = i.select("span.only_export")




vs =[]

for v in link:
    vs.append(v.text.replace("|",""))
    vs = list(filter(None,vs))

while ' - Check ' in vs:
    vs.remove(' - Check ')

names =[]




for v in vs:
    st = re.sub("^0*","",v[55:61])
    st2 = int(st)
    names.append(st2)
    print(names)




dic = dict(zip(names,vs))
key = dic.keys()
val = dic.values()
print(key)
print(val)
df = pd.DataFrame({'link':val},index=key)
print(df)
df.to_csv('tr.txt',sep='\t')
    
