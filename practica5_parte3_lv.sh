#!/bin/bash
#775750, Espinosa Gonzalo, Angel, T, 2, A
#777638, Gilgado Barrachina, Andres Maria, T, 2, A

if [ $UID -ne 0 ]
then
	echo "Faltan permisos de administracion"
	exit 1
fi
if [ $# -eq 0 ]
then
	echo "Faltan parametros"
	exit 85
fi
while read line
do 
	nGrupo=$(echo "$line" | cut -d ',' -f 1)
	nVL=$(echo "$line" | cut -d ',' -f 2)
	tamano=$(echo "$line" | cut -d ',' -f 3)
	tSF=$(echo "$line" | cut -d ',' -f 4)
	dM=$(echo "$line" | cut -d ',' -f 5)
	grep "$nVL" '/etc/fstab'
	if [ $? -eq 0 ]
	then
		lvextend -L+"$tamano" "/dev/$nGrupo/$nVL"
		resize2fs "/dev/$nGrupo/$nVL"
	else
		lvcreate -L "$tamano" --name "$nVL" "$nGrupo"
		mkfs -t "$tSF" "/dev/$nGrupo/$nVL"
		mount -t "$tSF" "/dev/$nGrupo/$nVL" "$dM"
		cat "/dev/$nGrupo/$nVL $dM $tSF defaults 0 0" >> "/etc/fstab"
		
	fi
done < $1
