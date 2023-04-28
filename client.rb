require 'socket'
require_relative 'transaction'

# Reemplaza "IP2" con la dirección IP del cliente y "IP1" con la dirección IP del servidor
client_ip = "192.168.1.143"
server_ip = "192.168.1.143"
server_port = 3000

puts "Iniciando cliente en #{client_ip}..."
puts "Conectando a #{server_ip}:#{server_port}..."

socket = TCPSocket.new(server_ip, server_port)
puts "Conexión establecida."

transactions_block = get_transactions_data

transactions_block.each do |transaction|
  puts "Enviando transacción..."
  transaction_data = "#{transaction[:from]} envía #{transaction[:qty]} #{transaction[:what]} a #{transaction[:to]}"
  socket.send(transaction_data, 0)
  puts "Transacción enviada: #{transaction_data}"
  sleep(1)
end

puts "Cerrando conexión..."
socket.close
puts "Conexión cerrada."
