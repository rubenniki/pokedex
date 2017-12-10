#!/bin/bash
n=2
wget "http://www.pokeyplay.com/info_pokedex.php"
cat info_pokedex.php > paginapoke.txt
rm info_pokedex.php
while [ $n != 10 ];do

wget "www.pokeyplay.com/info_pokedex"$n".php"
cat info_pokedex"$n".php >> paginapoke.txt
echo $n
rm info_pokedex"$n".php
n=$[n+1]
done
#########obtener fotos con toda la etiqueta

cat paginapoke.txt | grep -a urpgstatic > paginapokefoto.txt


#########fotos limpias

awk 'NF > 5{print $5 }' paginapokefoto.txt > fotospokemon.txt

#### fotos limpias con nombres
#awk 'NF > 5{print $5 $8 $9 $10}' paginapokefoto.txt > fotospokemon.txt 

############meter fotos pagina 

echo "Que pokemons quieres?"
echo "	a. Pokemons estaticos"
echo "	b. Pokemons en movimiento"
echo "	c. Todos"
read option

if [ $option = a ];then
	option=1
fi

if [ $option = b ];then
        option=2
fi

if [ $option = c ];then
        option=3
fi

case $option in
	"1")
		#lineas=`awk '$8 $9 $10 !~ /comparte/ && $5 !~ /animated/ && /strong/{print $5 $8 $9 $10}' paginapokefoto.txt' > paginaa
		lineas=`awk '$0 !~ /animated/ {print $0}' fotospokemon.txt` > paginaa
		echo "<!DOCTYPE html>" > pagina
		echo "<html>" >> pagina
		echo "<body>" >> pagina
		echo "<h2>Pokedex</h2>" >> pagina
		for i in $lineas 
		do
			echo "<img "$i">" >> pagina
		done
		echo "</body>" >> pagina
		echo "</html>" >> pagina

		firefox file:///home/niki/pagina
		rm fotospokemon
		rm paginaa
                rm pagina
		;;
	"2")
		echo "<!DOCTYPE html>" > pagina
                echo "<html>" >> pagina
                echo "<body>" >> pagina
                echo "<h2>Pokedex</h2>" >> pagina
		lineas=`awk '/animated/ {print $0}' fotospokemon.txt` > paginaa
		#####foto mas nombres
		#lineas=`awk '$8 $9 $10 !~ /compare/ && $5 ~/animated/ && /strong/{print $5 $8 $9 $10}' paginapokefoto.txt` > paginaaa

		for i in $lineas
                do
                        echo "<img "$i" >"  >> pagina
                done
                echo "</body>" >> pagina
                echo "</html>" >> pagina

		firefox file:///home/niki/pagina
		rm fotospokemon.txt
		rm paginaa
                rm pagina
                ;;
        "3")
		echo "<!DOCTYPE html>" > pagina
                echo "<html>" >> pagina
                echo "<body>" >> pagina
                echo "<h2>Pokedex</h2>" >> pagina

		lineas=`awk ' {print $0}' fotospokemon.txt`  > paginaa
                for i in $lineas
                do
                        echo "<img "$i">" >> pagina
                done
                echo "</body>" >> pagina
                echo "</html>" >> pagina

		firefox file:///home/niki/pagina
		rm fotospokemon.txt
		rm paginaa
		rm pagina
                ;;
esac
