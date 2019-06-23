#!/bin/bash

zip="C:\Program Files\7-Zip\7z.exe"
fielName=output.zip
wrokdir=out
workdirAutoDelete=1

if [ -e $fielName ]; then
    echo "$file ファイルが存在します"
    echo "先に削除してください"
fi 

if [ -e $wrokdir ]; then
    rm -rf $wrokdir
fi
mkdir $wrokdir
cp *.gbr *.drl $wrokdir
cd $wrokdir

file=
RES=`find -maxdepth 1 -name *-F_Cu.gbr 2>/dev/null`
if [ $? -ne 0 ]; then
    echo エラーが発生しました
    exit　
elif [ -z "$RES" ]; then
    echo ファイルが存在しません
    exit
else
    echo $RES
    if [[ $RES =~ ^./(.+)-F_Cu.gbr ]]; then
        file=${BASH_REMATCH[1]}
    fi
fi
if [ "$file" = "" ]; then
    echo "ファイル名の検出に失敗しました"
else 
    echo ファイル名は$file

    f="$file-F_Cu.gbr"
    t="$file.GTL"
    echo "$f to $t"
    if [ -e $f ]; then
        mv "$f" "$t"
    else
        echo $fがありません
        exit
    fi
    
    f="$file-B_Cu.gbr"
    t="$file.GBL"
    echo "$f to $t"
    if [ -e $f ]; then
        mv "$f" "$t"
    else
        echo $fがありません
        exit
    fi
    
    f="$file-F_Mask.gbr"
    t="$file.GTS"
    echo "$f to $t"
    if [ -e $f ]; then
        mv "$f" "$t"
    else
        echo $fがありません
        exit
    fi
    
    f="$file-B_Mask.gbr"
    t="$file.GBS"
    echo "$f to $t"
    if [ -e $f ]; then
        mv "$f" "$t"
    else
        echo $fがありません
        exit
    fi
    
    f="$file-F_Silks.gbr"
    t="$file.GTO"
    echo "$f to $t"
    if [ -e $f ]; then
        mv "$f" "$t"
    else
        echo $fがありません
        exit
    fi
    
    f="$file-B_Silks.gbr"
    t="$file.GBO"
    echo "$f to $t"
    if [ -e $f ]; then
        mv "$f" "$t"
    else
        echo $fがありません
        exit
    fi
    
    f="$file-PTH.drl"
    t="$file.TXT"
    echo "$f to $t"
    if [ -e $f ]; then
        mv "$f" "$t"
    else
        echo $fがありません
        exit
    fi
    
    f="$file-NPTH.drl"
    t="$file-NPTH.TXT"
    echo "$f to $t"
    if [ -e $f ]; then
        mv "$f" "$t"
    else
        echo $fがありません
        exit
    fi
    
    f="$file-Edge_Cuts.gbr"
    t="$file.GML"
    echo "$f to $t"
    if [ -e $f ]; then
        mv "$f" "$t"
    else
        echo $fがありません
        exit
    fi
    
fi

"$zip" a "$file.zip" $file*
mv "$file.zip" ..
cd ..
rm -rf out
# "$zip" a shino3.zip *.gbr