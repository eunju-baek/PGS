import pandas as pd
import sys


Input = sys.argv[1]
name = Input.split('.')[0]


a = pd.read_csv(Input,sep='\t',comment ='#')


b = a[['V2','effect_allele','effect_weight']]

col_list = list(b.columns)

col_list[0] = 'rsID'

b.columns = col_list

name2 = name+'.score'


b.to_csv(name2,sep='\t',index=False)
