#!/bin/bash
echo "Your last theme was :"
cat log.txt
truncate -s 0 log.txt
echo "The NEW themes must greater than 20 or u will dl duplicates!!"
echo "NOTE: the script will remove the themes folder with the previous themes,BACKUP THEM!"
echo "Procced ? (Type y for yes)"
read a
if [ $a == y ]; then
echo "What the last page u wish to dl?"
read x
for (( i=1; i<=$x; i++ )); do

  wget http://psv.altervista.org/index.php?p=$i
  grep -Po '(?<=href=")[^"]*' index.php\?p\=$i | grep 'theme.php?id=' | cut -d "=" -f 2 >> id.txt
  rm index.php\?p\=$i
done
awk '{print "http://psv.altervista.org/download.php?id="$0}' id.txt >> theme.txt
rm -f -r themes/
mkdir themes && cd themes
wget --content-disposition -i ../theme.txt
cd ..
id=$(head -n 1 id.txt)
wget http://psv.altervista.org/theme.php?id=$id
sed -n 's/.*<h2 style="margin:5px 0 0 0;">\(.*\)<\/h2>.*/\1/p' theme.php\?id\=$id >> log.txt
rm id.txt theme.txt theme.php\?id\=$id
else
  echo "EXITING..."
  exit
fi
