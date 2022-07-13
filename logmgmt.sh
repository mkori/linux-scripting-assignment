#!/bin/bash


. $PWD/utils.sh

if [[ $EUID -eq 0 ]]
then
   fatal "This script must be run as a non-root user."
fi

[ -d $PWD/logs ] || fatal "The 'logs' directory is not present."

[ $# -eq 0 ] && fatal "Needs at least one argument, can be gen, rotate, or clean."


gen_logs ()
{
filename=$1
number=$2
counter=1
while [ $counter -le $number ]
do 
echo "The quick brown fox jumps over the lazy dog." >> $PWD/logs/$filename
(( counter += 1))
done
}


rotate_logs ()
{
filename=$1
threshold=$2
if [ $(wc -l $PWD/logs/$filename |cut -d ' ' -f 1) -gt $threshold ]
then
	mv $PWD/logs/$filename $PWD/logs/${filename}-$(date +"%T")
	info "The $filename has been renamed to ${filename}-$(date +\"%T\")."
fi
}


clean_logs () 
{
threshold=$1
cd $PWD/logs
find . -type f |sort |tail -n +$((threshold+1)) | xargs -I {} rm -- {}
}


frontend ()
{
if [ $# -gt 0 ]
then 
   subcmd=$1
   if [ $subcmd = "gen" ]
   then 
	 gen_logs earth-log 50
   elif [ $subcmd = "rotate" ]
   then 
	   rotate_logs earth-log 20
   elif [ $subcmd = "--help" ]
   then
	   help_info
   else 
	  clean_logs 5
   fi
fi

}

frontend $@

