#!/bin/bash
#775750, Espinosa Gonzalo, Angel, T, 2, A
#777638, Gilgado Barrachina, Andres Maria, T, 2, A

if [ $UID -ne 0 ]
then
	echo "Este script necesita privilegios de administracion"
	exit 1
fi

if [ $# -eq 0 ]
then 
	echo "Error de parámetros"
	exit 85
fi
num=0
for i in $@
do
	if [ $num -eq 0 ]
	then
		echo "$i"
		vgcreate vg_p5 "$i" 
		vgchange -a y vg_p5
		num=$((num+1))
	else
		vgextend vg_p5 "$i"
		vgchange -a y vg_p5
	fi	

done
