#!/bin/bash

echo "Программа вычисления контрольной суммы файла"
echo
echo "Программа создаёт контрольную сумму первого файла и записывает во второй"
echo
echo "Разработчик: Дейнеко Алексей"

repeat=true;

while($repeat)
do
repeat=false

# вывод текущего каталога
echo -n "Текущий каталог: "
tail=${PWD##*/}
echo $tail

# запрос пути к первому файлу
echo -n "Дорогой друг, введи пожалуйста путь к первому файлу:"
read file_name1
while ([ -z $file_name1 ] ||  !([ -f $file_name1 ]) || !([ -r $file_name1 ]))
do
	#cheking for empty string
	while [ -z $file_name1 ];
	do
		echo "Пичалька, ничего не введено, попробуем ещё раз(y/n)?" >&2
		read answer1
		if [ "$answer1" != "y" ] 
		then
			echo "...выход из программы..."
			exit 250
		fi	
		echo -n "Дорогой друг, введи пожалуйста путь к первому файлу:"
		read file_name1	
	done		
	
	#cheking for exsistance 
	while !([ -f $file_name1 ])
	do
		echo "Пичалька,файла с таким путём не обнаружено, попробуем ещё раз(y/n)?">&2
		read answer2
		if [ "$answer2" != "y" ] 
		then
			echo "...выход из программы..."
			exit 250
		fi
		echo -n "Дорогой друг, введи пожалуйста путь к первому файлу:"
		read file_name1
	done
	
	#cheking for reading 
	while !([ -r $file_name1 ]) 
	do
		echo "Пичалька,	файл невозможно открыть попробуем ещё раз(y/n)?" >&2
		read answer1
		if [ "$answer1" != "y" ] 
		then
			echo "...выход из программы..."
			exit 250
		fi	
		echo -n "Дорогой друг, введи пожалуйста путь к первому файлу:"
		read file_name1
	done	
done
echo "Такой файл с таким путём есть, и его можно открыть"
#генерирование контрольной суммы первого файла по алгоритму md5
string=$( md5sum $file_name1 )
echo $string
string1=${string:0:32}
echo $string1

# запрос пути к второму файлу
echo -n "Дорогой друг, введи пожалуйста путь к второму файлу: "
read file_name2

while ([ -z $file_name2 ] ||  !([ -f $file_name2 ]))
do
	while [ -z $file_name2 ];
	do
		echo "Пичалька, ничего не введено, попробуем ещё раз(y/n)?">&2
		read answer1
		if [ "$answer1" != "y" ] 
		then	
			echo "...выход из программы..."
			exit 250
		fi	
		echo -n "Дорогой друг, введи пожалуйста путь к второму файлу: "
		read file_name2	
	done		
	if !([ -f $file_name2 ])
	then
		echo "Пичалька,файла с таким путём не обнаружено, создать его(y/n)?">&2
		read answer2
		if [ "$answer2" == "y" ] 
		then
			echo "Создаём файл и записываем"
			echo $string1 > $file_name2
			echo "Ты молодец!!!"
			echo "Повторить ещё раз для других файлов(y/n)?"
			read answer3
			if [ "$answer3" != "y" ] 
			then	
				echo "...выход из программы..."
				exit 0
			else
				repeat=true
						 
			fi 
		fi
		if [ "$repeat" != true ]; then
			echo -n "Дорогой друг, введи пожалуйста путь к второму файлу:"
			read file_name2
		fi		
	fi	
done
if [ "$repeat" != true ]; then
	echo "Такой файл с таким путём есть"
	echo "Перезаписываем его"
	echo $string1 > $file_name2
	echo "Ты молодец!!!"
	echo "Повторить ещё раз для других файлов(y/n)?"
	read answer3
	if [ "$answer3" != "y" ] 
	then	
		echo "...выход из программы..."
		exit 0
	else
		repeat=true		 
	fi 
fi

done


