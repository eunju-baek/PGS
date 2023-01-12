mport pandas as pd
import os


pd.set_option('display.max_seq_items',None)
pd.set_option('display.max_rows',None)
pd.set_option('display.max_columns',None)


a =  pd.read_csv("tr.txt",sep='\t',index_col='0')



index = a.index.to_list()

end = index[-1]+1

for i in range(3123,end):
    try:
        ftp = a.loc[[i]].strip()
        com = "wget "+ftp
        print(com)
        os.system(com)
    except:
        pass
~                                                                                                                                      
