#ajout des librairie necessaire
require 'rubygems'
require 'nokogiri'
require 'open-uri'

#je viens definir l'url et ouvre la page à scrapper
puts "demarrage de l'analyse"
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/"))   
lien2 = page.css('td a')[83]['href']

#je viens me deplacer vers la page du val-d'oise
lien =  "http://annuaire-des-mairies.com/" + lien2
page = Nokogiri::HTML(open(lien))
puts "direction " + lien


tab = []
#compteur pour repéré le nombre de mairies à analiser
k = 0
#boucle qui vien récupéré les liens de chaque mairie
	page.css('a.lientxt').each do|x|
			tab << x['href'].slice(1..-1)
		k += 1
	end

#affiche le nobre de mairies trouvé
puts k.to_s + "mairies trouvé"
puts tab 

mail = []
puts "demarrage de la recherche des mails"
#boucle qui viens récupéré les emails dans chaque page web de chauqe mairies et l'ajoute dans un tableau mail
tab.each_with_index do |x,j|
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/" + x))
	page.css("p.Style22").each do |a| 
		mail << a.text if a.text.include?("@")
	end	
	puts j.to_s + " / " + k.to_s # permet de suivre en temps réel le code travaillé
end
puts "analyse terminé"
puts mail