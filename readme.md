# Taller en Ruby

Desarrollar una aplicación que permita extraer datos de la web usando Ruby y sus gemas.

Web: https://editorial.rottentomatoes.com/guide/2021-best-movies/

1.	El primer ejercicio será crear el archivo principal.rb para implementar un programa en ruby que permita definir el siguiente menú.
```
Menu Scrapeando v0.01
a. Top 10
b. Top 100
c. Todas las películas
d. Extraer por palabra clave
e. Salir
```

2.	Para el segundo ejercicio (a,b,c) deberá crear una clase **Extractor** que permite definir una clase capaz de establecer  atributos como: link (a scrapear) y el nro de top peliculas (10, 100, más de 100). Adicionalmente, crear una clase **Pelicula** con los atributos: titulo, sinopsis, protagonistas (separe por -), director, rating, y que permita registrar estos datos en el archivo ranking.csv. En caso de no existir algún valor colocar nil. El formato sería:
```
top,titulo,sinopsis,rating,protagonistas,direccion
```

3.	Para el tercer ejercicio (d) deberá **analizar si rediseña** la clase Extractor o **crea una nueva clase que mantenga** las características de Extractor, para permitir el envío de una palabra para realizar un scraping según esta clave específica. Cada vez que realice una busqueda con esta opcion debe anadirla al archivo busquedas.csv usando el mismo formato de ranking.
