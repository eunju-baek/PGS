from bs4 import BeautifulSoup
import requests
from html_table_parser import parser_functions as parser
import pandas as pd

url ="https://www.pgscatalog.org/trait/EFO_0001645/"

response = requests.get(url = url)

ll =[]

if response.status_code == 200:
    html = response.text
    soup = BeautifulSoup(html, 'html.parser')
    inp = []
    for i in range(1,30):
        s = str(i)
        inp.append('#scores_table > tbody >'+' tr:nth-child('+s+') > td:nth-child(1) > a')
        
for i in inp:
    ll.append(soup.select_one(i).get_text())       
    
    
u = "https://www.pgscatalog.org/score/"
url2 =""

for v in ll:
    url2 = u + str(v)+"/"
    print(url2)
    r = requests.get(url = url2)
    html2 = r.text
    bs = BeautifulSoup(html2, 'html.parser')
    temp = bs.find_all('table')
    p = parser.make2d(temp[4])
    df = pd.DataFrame(p)
