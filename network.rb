# network.rb

require 'socket'
require 'json'

class Network
  attr_reader :peers

  def initialize(host, port, blockchain)
    @host = host
    @port = port
    @peers = []
    @blockchain = blockchain
  end

  def add_peer(peer_host, peer_port)
    @peers << { host: peer_host, port: peer_port }
  end

  def start
    server = TCPServer.new(@host, @port)
    puts "network.rb: Servidor abierto en #{@host}:#{@port}"

    Thread.new do
      loop do
        client = server.accept
        puts "network.rb: Conexión aceptada desde #{client.peeraddr[2]}:#{client.peeraddr[1]}"
        handle_client(client)
      end
    end
  end

  def handle_client(client)
    message = client.gets.chomp
    data = JSON.parse(message)
    puts "network.rb: Recibido: #{data}"

    case data['type']
    when 'transaction'
      transaction = data['data']
      @blockchain.add_block([transaction])
      puts "network.rb: Transacción agregada: #{transaction}"
    when 'peers'
      @peers |= data['data']
      client.puts({ type: 'peers', data: @peers }.to_json)
      puts "network.rb: Enviado: { type: 'peers', data: #{@peers} }"
    end

    client.close                                                                                              
  end

  def broadcast_transaction(transaction)
    @peers.each do |peer|
      begin
        socket = TCPSocket.new(peer[:host], peer[:port])
        socket.puts({ type: 'transaction', data: transaction }.to_json)
        puts "network.rb: Enviado: { type: 'transaction', data: #{transaction} }"
        socket.close
      rescue => e
        puts "network.rb: Error al enviar la transacción: #{e.message}"
      end
    end
  end
  

  def share_peers
    @peers.each do |peer|
      begin
        puts "network.rb: estoy en el begin #{peer[:host]}:#{peer[:port]}"
        socket = TCPSocket.new(peer[:host], peer[:port])
        puts "network.rb: Conectado a #{peer[:host]}:#{peer[:port]}"                                                                                              
        socket.puts({ type: 'peers', data: @peers }.to_json)
        puts "network.rb: Enviado: { type: 'peers', data: #{@peers} }"
        response = JSON.parse(socket.gets.chomp)
        @peers |= response['data']
        puts "network.rb: Recibido: #{response}"
        socket.close
        puts "network.rb: Compartiendo pares con #{peer[:host]}:#{peer[:port]}"
      rescue => e
      end
    end
  end
end
