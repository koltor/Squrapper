require 'rubygems'
require 'nokogiri'
require 'open-uri'

puts "demarrage du suivi"
#je viens ouvrir la page web qui m'interesse
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

#boucle infini
while true
	price = []
	element = []
	# boucle qui viens chercher tous les prix des crypto monnais
	page.css('a.price').each do|x|
				price << x['data-usd']
	end

#viens chercher le nom de toutes les crypto monnais
	page.css('a.currency-name-container').each do|x|
			element << x.text
	end
	#creation d'un Hashes
	res = Hash.new('0')
	#je viens remplir le Hache avec les valeur et les clé
	for i in 0...element.length
		res[element[i]] = price[i]
	end
	sleep(3)#temps de pose entre chaque actualisaiton

	res.each do |(key, value)|
		puts "#{key} worth #{value} today, enjoy !" #afficahge du Hache
	end
end