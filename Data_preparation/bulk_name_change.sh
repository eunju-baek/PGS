for f in *.txt.snp
do mv -- "$f" "${f%.txt.snp}.snp"
done

#or rename 's/.txt//g' *.snp
