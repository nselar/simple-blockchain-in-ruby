require 'socket'
require_relative 'blockchain'

# Inicializa la blockchain
blockchain = Blockchain.new

# Reemplaza "IP1" con la dirección IP del servidor
server_ip = "192.168.1.143"
server_port = 3000

puts "Iniciando servidor en #{server_ip}:#{server_port}..."

server = TCPServer.new(server_ip, server_port)
puts "Servidor iniciado. Esperando conexión..."

loop do
  socket = server.accept
  puts "Conexión establecida desde: #{socket.peeraddr[2]}"

  while (transaction = socket.recv(1024).force_encoding('UTF-8')).size > 0
    puts "Transacción recibida: #{transaction}"

    transactions = []
    transactions << transaction

    puts "Agregando transacción a la cadena de bloques..."
    blockchain.add_block(transactions)
    puts "Transacción agregada. Último bloque: #{blockchain.chain.last.hash}"

    puts "Esperando siguiente transacción..."
  end

  puts "Cerrando conexión..."
  socket.close
  puts "Conexión cerrada."
end
