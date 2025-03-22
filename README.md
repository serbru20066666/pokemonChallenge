PokeChallenge

PokeChallenge es una aplicación iOS que muestra una lista de Pokémon obtenida desde la PokeAPI. Permite buscar Pokémon, ver detalles e imágenes, y cuenta con una interfaz fluida gracias a SwiftUI y Combine.

📌 Características

📜 MVVM + Services

🔍 Búsqueda de Pokémon por nombre.

📜 Lista de Pokémon con imágenes obtenidas desde la API.

⏳ Carga asincrónica con indicador de progreso.

🛠️ Arquitectura MVVM con Combine.

🌍 Soporte para localización usando String Catalogs.

🛠️ Tecnologías Utilizadas

Swift y SwiftUI para la UI.

Combine para manejar datos de forma reactiva.

PokeAPI como fuente de datos.

AsyncImage para la carga de imágenes remotas.

XCTest para pruebas unitarias.

📲 Instalación

Requisitos

macOS con Xcode 16+

iOS 16+

Pasos para clonar y correr el proyecto

# Clonar el repositorio
git clone https://github.com/serbru20066666/pokemonChallenge.git
cd PokeChallenge

# Abrir en Xcode
Abrir el .project

Ejecuta el proyecto en un simulador o dispositivo real desde Xcode.

🔬 Pruebas Unitarias

El proyecto incluye pruebas unitarias para validar la obtención de Pokémon desde la API.
Ejecuta las pruebas desde Xcode:

Selecciona Product > Test o usa el atajo Cmd + U.

Asegúrate de que todos los tests pasen correctamente.

📖 Localización

El proyecto utiliza String Catalogs para manejar traducciones.
Para agregar más idiomas:

Abre Localizable.xcstrings en Xcode.

