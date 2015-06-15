require 'entities/end'

module NfeRuby
  class Dest
    attr_accessor :cnpj_cpf
    attr_accessor :isuf
    attr_accessor :x_nome
    attr_accessor :ender_dest
    attr_accessor :email
    attr_accessor :ie
    
    def initialize
      self.ender_dest = NfeRuby::End.new
    end
    
  end
end