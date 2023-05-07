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

  def launcher
    b0 = Block.first( { from: "Dhaval", to: "Humber", what: "coin", qty: "10" } )
    b1 = Block.next(b0, { from: "Humber", to: "Yulia", what: "coin", qty: "5" } )
    b2 = Block.next(b1, { from: "Yulia", to: "Dhaval", what: "coin", qty: "2" } )
    b3 = Block.next(b2, { from: "Dhaval", to: "Yulia", what: "coin", qty: "3" } )
    puts b0.inspect
    puts b1.inspect
    puts b2.inspect
    puts b3.inspect
  end
end

# Configura las IPs y puertos de las tres máquinas aquí
HOST = '192.168.1.125'
PORT = 8000
PEER2_HOST = '192.168.1.193'
PEER2_PORT = 8002
PEER1_HOST = '192.168.1.143'
PEER1_PORT = 8001

# Crea un nuevo objeto de la clase Network
network = Network.new(HOST, PORT)
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
blockchain = Blockchain.new
blockchain.launcher
