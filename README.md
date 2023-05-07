# Red de blockchain simple P2P usando ruby

Versión mejorada de Simple Blockchain usando Ruby obtenida de https://github.com/apradillap/simple-blockchain-in-ruby

Este repositorio es un fork que contiene una implementación básica de una red de blockchain en Ruby. La red está diseñada para ser ejecutada en varias computadoras dentro de una red LAN y en al menos 2 máquinas.
La comunicación entre máquinas se realiza mediante Sockets TCP.

## Archivos

- `block.rb`: Contiene la implementación de la clase `Block`, que representa un bloque en la cadena de bloques.

- `blockchain.rb`: Contiene la implementación de la clase `Blockchain`, que representa la cadena de bloques en sí. También incluye el código para interactuar con la red y agregar transacciones a la cadena.

- `network.rb`: Contiene la implementación de la clase `Network`, que maneja la comunicación entre los nodos de la red y la difusión de transacciones.

- `transaction.rb`: Contiene el código para obtener los datos de transacción del usuario.

## Configuración de la red

Antes de ejecutar la red blockchain, asegúrate de configurar las direcciones IP y los puertos de las computadoras en la red LAN. Puedes hacerlo editando las siguientes variables en el archivo `blockchain.rb`:

```ruby
HOST = 'localhost' # Direccion ip del propio ordenador donde se ha clonado el proyecto. Puede ser localhost, 127.0.0.1 o la ip asignada en red, ej 192.168.1.40
PORT = 8000
PEER2_HOST = 'IP_MAQUINA2' # Dirección ip del segundo ordenador remoto
PEER2_PORT = 8002
PEER1_HOST = 'IP_MAQUINA1' # Direccion ip del primer ordenador remoto
PEER1_PORT = 8001
````
Se pueden añadir tantas direcciones ip y puertos como máquinas se desean que participen en la red.
Es muy importante que te asegures de que tanto la IP como los puertos son los correctos y están abiertos en el firewall de tu equipo. Puedes desactivar tu firewall en debian ejecutando: 
```
$ sudo ufw disable
````
## Uso

Para ejecutar la red de blockchain:
  1. Instala ruby en tu equipo con ``` $ sudo apt-get install ruby``` si tienes una distribución debian.
  2. Clona este repositorio en cada una de las computadoras de tu red LAN que deseas que participe en la red de blockchain,
  3. En cada computadora navega hasta los archivos del respositorio y abre una terminal. Ejecuta: ``` $ ruby blockchain.rb```
  4. Cada uno de los ordenadores se pondrá a la escucha de transacciones y una vez que haya al menos dos participantes, te indicará las instrucciones para agregar transacciones.
  5. Las transacciones se propagarán por la red y se mostrarán en todos los equipos implicados.

¡Disfruta de tu red de blockchain en tu LAN!
