#!/bin/bash
#Creation date: 28.01.2023

tmstmp=$(date +%F)
badfile="InternetSales_new.bad_$tmstmp.txt"

wget http://home.agh.edu.pl/~wsarlej/dyd/bdp2/materialy/cw10/InternetSales_new.zip
unzip -P "bdp2agh" InternetSales_new.zip -d InternetSales_new

cd InternetSales_new
head -n1 InternetSales_new.txt >> header

#lines with nonmatching number of rows
grep -v "|.*|.*|.*|.*|.*|" InternetSales_new.txt >> $badfile

#non-unique lines
uniq -D InternetSales_new.txt >> $badfile

#lines with OrderQuantity>100 (also header)
awk -F\| '{if($5>100) print$0}' InternetSales_new.txt >> $badfile

#lines with SecretCode
grep "[0-9]$" InternetSales_new.txt >> $badfile

#lines !("nazwisko,imie")
grep -v "[A-Za-z],[A-Za-z]" InternetSales_new.txt >> $badfile

#change firstname-lastname
sed -i 's/,/\|/' InternetSales_new.txt
sed -i 's/\"//g' InternetSales_new.txt


#replace , with . 
sed -i 's/,/\./g' InternetSales_new.txt

#remove all lines that ended up in badfile from input file
grep -Fvxf $badfile InternetSales_new.txt >> tmp
#restore header
cat header tmp > InternetSales_new.txt
rm header tmp


##############################################################
#                                                            #
#                       PART 2 - SQL                         #
#                                                            #
##############################################################

nrInd=304179

echo "
CREATE TABLE CUSTOMERS_$nrInd
(
ProductKey int,
CurrencyAlternateKey char(5),
First_Name char(60),
Last_Name char(60),
OrderDateKey int,
OrderQuantity int,
UnitPrice float,
SecretCode varchar(10)
)
;
" > create_table.sql

mysql -u mmaciejko -h mysql.agh.edu.pl -P 3306 -pWkV1V3k3iWxKT2U2 -D mmaciejko -e < create_table.sql
rm create_table.sql


echo "
LOAD DATA
    INFILE 'C:/Users/macie/Desktop/DokumentyMagdy/studia/sem2/BDP2/10/Internet_Sales_new.txt'
    REPLACE
    INTO TABLE CUSTOMERS_$nrInd
    FIELDS TERMINATED BY '|' ENCLOSED BY ''
    LINES TERMINATED BY '\n' STARTING BY ''    
	IGNORE 1 LINES;
GRANT ALL PRIVILEGES ON mmaciejko.customers_$nrInd TO 'Magda'@'mysql.edu.pl'
" > load_data.sql

mysql -u mmaciejko -h mysql.agh.edu.pl -P 3306 -pWkV1V3k3iWxKT2U2 -D mmaciejko < load_data.sql
rm load_data.sql

mkdir C:/Users/macie/Desktop/DokumentyMagdy/studia/sem2/BDP2/10/PROCESSED 
mv C:/Users/macie/Desktop/DokumentyMagdy/studia/sem2/BDP2/10/InternetSales_new.txt C:/Users/macie/Desktop/DokumentyMagdy/studia/sem2/BDP2/10/$(date +%F_%T)_InternetSales_new.txt


mysql -u mmaciejko -h mysql.agh.edu.pl -P 3306 -pWkV1V3k3iWxKT2U2 -D mmaciejko -e < echo "UPDATE CUSTOMERS_$nrInd set SecretCode = (SELECT uuid());"

mysql -u mmaciejko -h mysql.agh.edu.pl -P 3306 -pWkV1V3k3iWxKT2U2 -D mmaciejko -e < echo"
(SELECT 'ProductKey', 'CurrencyAlternateKey', 
'First_Name', 'Last_Name', 'OrderDateKey', 'OrderQuantity', 'UnitPrice', 'SecretCode')
UNION
SELECT * FROM customers_$nrInd 
INTO OUTFILE 'C:/Users/macie/Desktop/DokumentyMagdy/studia/sem2/BDP2/10/Internet_Sales_new2.csv' 
FIELDS TERMINATED BY '|' 
ENCLOSED BY '' 
LINES TERMINATED BY '\n' 
"
zip -r data.zip data/