#!/bin/bash
while true
do

	if [ -f ./log ]; then

		before_list=`cat log`
		
		list=`find ./ -maxdepth 1 -name "*.jpg" | tee log` #現在の状態
		addlist=()
	
		for a in ${list[@]} #追加ファイルを探索
		do

			flag=0

		    	for b in ${before_list[@]}
			do
		    
				if [ $a = $b ]; then
				
					flag=1 #もし同じファイル名があった場合

				fi		

			done

			if [ $flag -eq 0 ]; then
			
				addlist=("${addlist[@]}" $a)

			fi

		done

	else
	
		addlist=`find ./ maxdepth 1 -name "*.jpg" | tee log`

	fi

	echo ${addlist[@]}

	for n in ${addlist[@]}
	do
		echo $n
		./darknet detector test cfg/my-dataset.data cfg/my-dataset.cfg 12000.weights $n
		mv predictions.png `date +%Y%m%d_%H-%M-%S`.png

	done

	echo "待機"

	sleep 5

done
