import pandas as pd
import sys


Input = sys.argv[1]
name = Input.split('.')[0]


a = pd.read_csv(Input,sep='\t',skiprows=14)


b = a[['rsID','effect_allele','effect_weight']]


name2 = name+'.score'

b.to_csv(name2,sep='\t',index=False)
