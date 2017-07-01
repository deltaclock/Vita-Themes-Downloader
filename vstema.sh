#!/bin/bash
echo "Your last theme was :"
cat logt.txt
truncate -s 0 logt.txt
echo "The NEW themes must greater than 9 or u will dl duplicates!!"
echo "NOTE: the script will remove the tema folder with the previous themes,BACKUP THEM!"
echo "Procced ? (Type y for yes)"
read a
if [ $a == y ]; then
echo "What the last page u wish to dl?"
read x
for (( i=1; i<=$x; i++ )); do
  wget http://vstema.com/livearea?page=$i
  grep -Po '(?<=href=")[^"]*' livearea\?page\=$i | grep '/themes/' | awk '{print "http://vstema.com"$0}' >> theme.txt
   if [ $i == 1 ]; then
     log=$(grep -Po '(?<=href=")[^"]*' livearea\?page\=$i | grep 'theme/' | awk '{print "http://vstema.com/"$0}' | head -n 1 )
   fi
  rm livearea\?page\=$i
done
rm -f -r tema/
mkdir tema
cd tema/
wget -i ../theme.txt
for f in *.zip; do
mv "$f" "${f#??????????}"
done
cd ..
wget -O thm $log
sed -n 137p thm >> logt.txt
rm theme.txt thm
else
  echo "EXITING..."
  exit
fi
