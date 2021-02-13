#Victor Daniel Bohorquez Toribio
# Analisis de Algoritmos  3CV4
puts "Ingresa el tamaño a llevar pon un espacio despues del número     Mb-M   GB-G  TB-T"
tam = gets.chomp
tama = tam.split(" ")

case tama[1]
	when "M"
		espacio = tama[0].to_f
	when "G"
		espacio = tama[0].to_f*1024
	when "T"
		espacio = tama[0].to_f*1024*1024
end

nombres = []
pesos = []
costos = []
importancia = []
importancia2 = []
lista = []
listacosto = []
listapeso = []

File.open('datos.txt', 'r') do |f1|
  while linea = f1.gets
    arreglo = linea.split(",")
    nombres.push(arreglo[0])
    ps = arreglo[1].split(" ")
    case ps[1]
		when "M"
			peso = ps[0].to_f
		when "G"
			peso = ps[0].to_f*1024
		when "T"
			peso = ps[0].to_f*1024*1024
	end
    pesos.push(peso)
    costos.push(arreglo[2])
  end
end

for i in (0..costos.length-1)
	costos[i].delete!("\n")
end

for i in (0..costos.length-1)
	importancia.push(costos[i].to_f/pesos[i].to_f)
end

importancia2 = importancia.sort{ |a, b|
	if a >= b
		-1
	elsif
	a <= b
		1
	else
		0
	end
}

for i in (0..importancia2.length-1)
	indice = importancia.index(importancia2[i])
	if pesos[indice].to_f< espacio.to_f
		espacio = espacio.to_f - pesos[indice].to_f
		lista.push(nombres[indice])
		listacosto.push(costos[indice])
		listapeso.push(pesos[indice])
		importancia.delete_at(indice)
		nombres.delete_at(indice)
		pesos.delete_at(indice)
		costos.delete_at(indice)
	end
end

puts "Lista de Archivos que llevar\n"

for i in (0..lista.length-1)
	puts lista[i].to_s + "\t" + listapeso[i].to_s + "MB\t" + "$ " + listacosto[i].to_s + "\n"
end

pes = 0
ct = 0
listapeso.each do |num|
pes += num.to_f
end
listacosto.each do |num|
ct += num.to_f
end
puts "Peso Total\t"+pes.to_s+"MB"
puts "Sobrante\t"+espacio.to_s+"MB"
puts "Peso Total\t"+"$ "+ct.to_s