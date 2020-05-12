#!/bin/bash
#775750, Espinosa Gonzalo, Angel, T, 2, A
#777638, Gilgado Barrachina, Andres Maria, T, 2, A

while read line
do
	maquina=$line
	echo "Informacion de la maquina $maquina"
	echo "Los discos duros disponibles y sus tamaños en bloques:"
	ssh -i '/home/as/.ssh/id_as_ed25519' "as@$maquina" sudo sfdisk -s
	echo "Las particiones y sus tamaños:"
	ssh -i '/home/as/.ssh/id_as_ed25519' "as@$maquina" sudo sfdisk -l
	echo "Informacion de montaje de sistema de ficheros:"
	ssh -i '/home/as/.ssh/id_as_ed25519' "as@$maquina" sudo df -hT
done < $1

