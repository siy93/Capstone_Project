#! /bin/bash

if [ "$1" == "" ] || [ "$#" -gt "1" ] || [ ! -e $1 ]
then
        echo "not exist python file or more than one file"
        echo "usage : bash ts.sh [*.py](only one file)"
        exit
fi

source error.dat

mkdir -p result

FILE=result/temp`basename $1 .py`.txt
FILE2=result/temp`basename $1 .py`2.txt
FILE3=result/`basename $1 .py`.txt

pycodestyle $1 --format='%(code)s %(row)d %(col)d' > $FILE
pylint --msg-template='{msg_id} {line:3d} {column}' --reports=n $1 >> $FILE
pymetrics -z $1 > $FILE2

IndenCount=0 NamingCount=0 CommentCount=0 WhiteSpaceCount=0 CodeFormatCount=0 StatementCount=0 FunctionCount=0 ClassCount=0 ModuleCount=0
declare -a temp1
declare -a temp2
declare -a temp3
declare -a temp4
declare -a temp5
declare -a temp6
declare -a temp7
declare -a temp8
declare -a temp9
flag=0;

while read code row col
do
        for value in "${Indentation[@]}";do
                if [ "$code" == "$value" ];
                then
                        temp1[$IndenCount]="\t\t{\n\t\t\"name\":\""$code"\",\n\t\t\"row\":"$row",\n\t\t\"col\":"$col"\n\t\t},"
                        let IndenCount=IndenCount+1;
                        let flag=1;
                        break
                fi
        done
        if [ "$flag" -eq "1" ];
        then
                let flag=0;
                continue; 
        fi
        for value in "${Naming[@]}";do
                if [ "$code" == "$value" ];
                then
                        temp2[$IndenCount]="\t\t{\n\t\t\"name\":\""$code"\",\n\t\t\"row\":"$row",\n\t\t\"col\":"$col"\n\t\t},"
                        let NamingCount=NamingCount+1;
                        let flag=1;
                        break
                fi
        done
        if [ "$flag" -eq "1" ];
        then
                let flag=0;
                continue; 
        fi
        for value in "${Comment[@]}";do
                if [ "$code" == "$value" ];
                then
                        temp3[$IndenCount]="\t\t{\n\t\t\"name\":\""$code"\",\n\t\t\"row\":"$row",\n\t\t\"col\":"$col"\n\t\t},"
                        let CommentCount=CommentCount+1;
                        let flag=1;
                        break
                fi
        done
        if [ "$flag" -eq "1" ];
        then
                let flag=0;
                continue; 
        fi
        for value in "${WhiteSpace[@]}";do
                if [ "$code" == "$value" ];
                then
                        temp4[$IndenCount]="\t\t{\n\t\t\"name\":\""$code"\",\n\t\t\"row\":"$row",\n\t\t\"col\":"$col"\n\t\t},"
                        let WhiteSpaceCount=WhiteSpaceCount+1;
                        let flag=1;
                        break
                fi
        done
        if [ "$flag" -eq "1" ];
        then
                let flag=0;
                continue; 
        fi
        for value in "${CodeFormat[@]}";do
                if [ "$code" == "$value" ];
                then
                        temp5[$IndenCount]="\t\t{\n\t\t\"name\":\""$code"\",\n\t\t\"row\":"$row",\n\t\t\"col\":"$col"\n\t\t},"
                        let CodeFormatCount=CodeFormatCount+1;
                        let flag=1;
                        break
                fi
        done
        if [ "$flag" -eq "1" ];
        then
                let flag=0;
                continue; 
        fi
        for value in "${Statement[@]}";do
                if [ "$code" == "$value" ];
                then
                        temp6[$IndenCount]="\t\t{\n\t\t\"name\":\""$code"\",\n\t\t\"row\":"$row",\n\t\t\"col\":"$col"\n\t\t},"
                        let StatementCount=StatementCount+1;
                        let flag=1;
                        break
                fi
        done
        if [ "$flag" -eq "1" ];
        then
                let flag=0;
                continue; 
        fi
        for value in "${Function[@]}";do
                if [ "$code" == "$value" ];
                then
                        temp7[$IndenCount]="\t\t{\n\t\t\"name\":\""$code"\",\n\t\t\"row\":"$row",\n\t\t\"col\":"$col"\n\t\t},"
                        let FunctionCount=FunctionCount+1;
                        let flag=1;
                        break
                fi
        done
        if [ "$flag" -eq "1" ];
        then
                let flag=0;
                continue; 
        fi
        for value in "${Class[@]}";do
                if [ "$code" == "$value" ];
                then
                        temp8[$IndenCount]="\t\t{\n\t\t\"name\":\""$code"\",\n\t\t\"row\":"$row",\n\t\t\"col\":"$col"\n\t\t},"
                        let ClassCount=ClassCount+1;
                        let flag=1;
                        break
                fi
        done
        if [ "$flag" -eq "1" ];
        then
                let flag=0;
                continue; 
        fi
        for value in "${Module[@]}";do
                if [ "$code" == "$value" ];
                then
                        temp9[$IndenCount]="\t\t{\n\t\t\"name\":\""$code"\",\n\t\t\"row\":"$row",\n\t\t\"col\":"$col"\n\t\t},"
                        let ModuleCount=ModuleCount+1;
                        break
                fi
        done
done<$FILE

echo "{" >> $FILE3
r='^[0-9]+$'
while read count category
do
        if [[ "$count" =~ $r ]];
        then
                echo "\""$category "\":" $count ',' >> $FILE3;
        fi
done<$FILE2


rm $FILE
rm $FILE2


echo -e "\"Indentation\" : {\n\t\"count\":" $IndenCount ',' >> $FILE3
echo -e "\t\t\"error\":[\n${temp1[@]}]" >> $FILE3
echo -e "\"Naming\" : {\n\t\"count\":" $NamingCount ',' >> $FILE3
echo -e "\t\t\"error\":[\n${temp2[@]}]" >> $FILE3
echo -e "\"Comment\" : {\n\t\"count\":" $CommentCount ',' >> $FILE3
echo -e "\t\t\"error\":[\n${temp3[@]}]" >> $FILE3
echo -e "\"WhiteSpace\" : {\n\t\"count\":" $WhiteSpaceCount ',' >> $FILE3
echo -e "\t\t\"error\":[\n${temp4[@]}]" >> $FILE3
echo -e "\"CodeFormat\" : {\n\t\"count\":" $CodeFormatCount ',' >> $FILE3
echo -e "\t\t\"error\":[\n${temp5[@]}]" >> $FILE3
echo -e "\"Statement\" : {\n\t\"count\":" $StatementCountCount ',' >> $FILE3
echo -e "\t\t\"error\":[\n${temp6[@]}]" >> $FILE3
echo -e "\"Function\" : {\n\t\"count\":" $FunctionCount ',' >> $FILE3
echo -e "\t\t\"error\":[\n${temp7[@]}]" >> $FILE3
echo -e "\"Class\" : {\n\t\"count\":" $ClassCount ',' >> $FILE3
echo -e "\t\t\"error\":[\n${temp8[@]}]" >> $FILE3
echo -e "\"Module\" : {\n\t\"count\":" $ModuleCount ',' >> $FILE3
echo -e "\t\t\"error\":[\n${temp9[@]}]" >> $FILE3
echo "}" >> $FILE3