import pandas as pd
import sys


Input = sys.argv[1]
name = Input.split('.')[0]

a = pd.read_csv(Input,sep='\t',comment ='#')

if 'rsID' in a.columns:
    b = a[['rsID','effect_allele','effect_weight']]

    name2 = name+'.score'

    b.to_csv(name2,sep='\t',index=False)

else:
    pass
