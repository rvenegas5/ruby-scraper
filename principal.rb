require 'open-uri'
require 'nokogiri'
require 'csv'

class Extractor
  def initialize(top_peliculas, link, palabra_clave = '')
    @extractor_top = top_peliculas
    @extractor_link = link
    @extractor_palabra_clave = palabra_clave
  end

  def extraer
    CSV.open('ranking.csv', 'wb') do |csv|
      csv << %w[top titulo sinopsis rating protagonistas direccion]
      peliculas = URI.open(@extractor_link)
      datos = peliculas.read
      parsed_content = Nokogiri::HTML(datos)
      galeria = parsed_content.css('.countdown-item-content').reverse
      
      if @extractor_top == 10
        galeria = galeria.slice(0,10)
      elsif @extractor_top == 100
        galeria = galeria.slice(0,100)        
      end
      galeria.each do |contenido|

        titulo = contenido.css('.countdown-item-title-bar').at_css('a').inner_text

        sinopsis = contenido.css('.countdown-item-details').css('.synopsis').inner_text
        sinopsis["Synopsis: "] = ''
        sinopsis[" [More]"] = ''
        if sinopsis[',']
          sinopsis[','] = ''
        end
        
        protagonistas = contenido.css('.cast').inner_text.strip
        protagonistas['Starring:'] = ''
        if protagonistas[',']
          protaArr = protagonistas.split(',')
          protagonistas = protaArr.join('-').strip
        end
        if protagonistas.empty?
          protagonistas = nil
        end
        director = contenido.css('.director').at_css('a').inner_text.strip

        top = contenido.css('.countdown-index').inner_text
        top["#"] = ''

        rating = contenido.css('.tMeterScore').inner_text
        rating["%"] = ''
        pelicula = Pelicula.new(top, titulo, sinopsis, protagonistas, director, rating)
        csv << [pelicula.top.to_i, pelicula.titulo.to_s, pelicula.sinopsis.to_s, pelicula.rating.to_i, pelicula.protagonistas.to_s, pelicula.director.to_s]
        end
      end
    end

  def extraer_palabra_clave
    CSV.open('busquedas.csv', 'wb') do |csv|
      csv << %w[top titulo sinopsis rating protagonistas direccion]
      peliculas = URI.open(@extractor_link)
      datos = peliculas.read
      parsed_content = Nokogiri::HTML(datos)
      galeria = parsed_content.css('.countdown-item-content').reverse
      galeria.each do |contenido|

        titulo = contenido.css('.countdown-item-title-bar').at_css('a').inner_text

        sinopsis = contenido.css('.countdown-item-details').css('.synopsis').inner_text
        sinopsis["Synopsis: "] = ''
        sinopsis[" [More]"] = ''
        if sinopsis[',']
          sinopsis[','] = ''
        end
        
        protagonistas = contenido.css('.cast').inner_text.strip
        protagonistas['Starring:'] = ''
        if protagonistas[',']
          protaArr = protagonistas.split(',')
          protagonistas = protaArr.join('-').strip
        end
        if protagonistas.empty?
          protagonistas = nil
        end
        director = contenido.css('.director').at_css('a').inner_text.strip

        top = contenido.css('.countdown-index').inner_text
        top["#"] = ''

        rating = contenido.css('.tMeterScore').inner_text
        rating["%"] = ''
        if !@extractor_palabra_clave.empty? and (titulo[@extractor_palabra_clave] or sinopsis[@extractor_palabra_clave])
          pelicula = Pelicula.new(top, titulo, sinopsis, protagonistas, director, rating)
          csv << [pelicula.top.to_i, pelicula.titulo.to_s, pelicula.sinopsis.to_s, pelicula.rating.to_i, pelicula.protagonistas.to_s, pelicula.director.to_s]
        end
      end
    end
  end
end

class Pelicula
  def initialize(top, titulo, sinopsis, protagonistas, director, rating)
    @pelicula_titulo = titulo
    @pelicula_sinopsis = sinopsis
    @pelicula_protagonistas = protagonistas
    @pelicula_director = director
    @pelicula_rating = rating
    @pelicula_top = top
  end

  def top
    @pelicula_top
  end

  def titulo
    @pelicula_titulo
  end

  def sinopsis
    @pelicula_sinopsis
  end

  def protagonistas
    @pelicula_protagonistas
  end

  def director
    @pelicula_director
  end

  def rating
    @pelicula_rating
  end
end