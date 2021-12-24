puts "Scraper Ruby"
require './principal.rb'

opcion = ''
while opcion != 'e'

  menu = "Menu 
  a. Top 10
  b. Top 100
  c. Todas las películas
  d. Extraer por palabra clave
  e. Salir"
  puts menu

  puts "Escoger una opción:"

  opcion = gets.chomp
  link = "https://editorial.rottentomatoes.com/guide/2021-best-movies/"
  palabra_clave = ''

  case opcion
  when 'a'
    puts "Ejecutando la opción (a)..."
    scraper = Extractor.new(10,link)
    scraper.extraer
    puts "La opción (a) se ejecutó correctamente...\n"
  when 'b'
    puts "Ejecutando la opción (b)..."
    scraper = Extractor.new(100, link)
    scraper.extraer
    puts "La opción (b) se ejecutó correctamente...\n"
  when 'c'
    puts "Ejecutando la opción (c)..."
    scraper = Extractor.new(235, link)
    scraper.extraer
    puts "La opción (c) se ejecutó correctamente...\n"
  when 'd'
    puts "Ingresar la palabra clave:"
    palabra_clave = gets.chomp
    if palabra_clave != ""
      scraper = Extractor.new(235, link, palabra_clave)
      scraper.extraer_palabra_clave
      puts "La opción (d) se ejecutó correctamente...\n"
    else
      puts "Debe colocar una palabra!\n"
    end
  when 'e'
    puts "Gracias por usar el sitema Scrapeando v0.01"
    break
  else
    puts "La opción no existe..."
  end
end

puts "Fin de práctica"