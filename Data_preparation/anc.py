## crawling the PGS catalog's ancestry tables.

import pandas as pd
from bs4 import BeautifulSoup
import requests
from html_table_parser import parser_functions as parser

a = pd.read_csv("name_All_PGS.txt")

ll =[]

for i in a.index:
    ll.append(a.iloc[i,0])

pd.set_option('display.max_seq_items',None)
pd.set_option('display.max_rows',None)
pd.set_option('display.max_columns',None)


u ="https://www.pgscatalog.org/score/"


url2 =""
name = ""

for v in ll:
    url2 = u + str(v)+"/"
    print(url2)
    r = requests.get(url = url2)
    html2 = r.text
    bs = BeautifulSoup(html2, 'html.parser')
    temp = bs.find_all('table')
    p = parser.make2d(temp[4])
    df = pd.DataFrame(p)
    name = "anc_"+str(v)+".txt"
    df.to_csv(name,sep='\t',index=False)
