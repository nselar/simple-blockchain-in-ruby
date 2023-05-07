# blockchain.rb

require_relative 'block'
require_relative 'transaction'
require_relative 'network'

class Blockchain
  attr_reader :chain

  def initialize
    @chain = [Block.first("Genesis Block")]
  end

  def add_block(transactions)
    new_block = Block.next(@chain.last, transactions)
    @chain << new_block
  end

  def last_block_hash
    @chain.last.hash
  end

  def launcher(network)
    loop do
      puts "Enter a new transaction (Y/n):"
      input = gets.chomp.downcase
      break if input != "y"
    
      transaction = get_transactions_data
      transaction.each do |t|
      network.broadcast_transaction(t)
      end
    end
  end
end




# Configura las IPs y puertos de las tres máquinas aquí
HOST = '192.168.1.40'
PORT = 8000
PEER2_HOST = '192.168.1.194'
PEER2_PORT = 8002
PEER1_HOST = '192.168.1.143'
PEER1_PORT = 8001

blockchain = Blockchain.new
network = Network.new(HOST, PORT, blockchain)

# Crea un nuevo objeto de la clase Network

puts "blockchain.rb: Servidor abierto en #{HOST}:#{PORT}"
network.add_peer(PEER1_HOST, PEER1_PORT)
puts "blockchain.rb: Agregado par #{PEER1_HOST}:#{PEER1_PORT}"
network.add_peer(PEER2_HOST, PEER2_PORT)
puts "blockchain.rb: Agregado par #{PEER2_HOST}:#{PEER2_PORT}"
network.start
puts "blockchain.rb: Servidor iniciado"

# Comparte la información de los pares
network.share_peers
puts "blockchain.rb: Pares: #{network.peers}"

# Ejecuta el código existente para crear y mostrar la cadena de bloques

blockchain.launcher(network)


