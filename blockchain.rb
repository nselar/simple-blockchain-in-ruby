require_relative 'block'

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
end
