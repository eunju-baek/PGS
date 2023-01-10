import os
import pandas as pd

dir_path = "/BiO/enju07/0_md/3_PGS/class_test"

ll = []

for (root, directories, files) in os.walk(dir_path):
    for file in files:
        if '.gz' in file:
            file_path = os.path.join(root,file)
            ll.append(file_path)



for i in ll:
    Input = pd.read_csv(i,comment = "#", sep ="\t")
    if 'rsID' in Input.columns:
        command1 = "cp"+" "+i+" "+"rsid/"
        os.system(command1)
    else:
        command2 = "cp"+" "+i+" "+"position/"
        os.system(command2)
