require 'entities/end'

module NfeRuby
  class Emit
    attr_accessor :cnpj_cpf
    attr_accessor :ie
    attr_accessor :x_nome
    attr_accessor :x_fant
    attr_accessor :ender_emit
    attr_accessor :iest
    attr_accessor :crt
    attr_accessor :cnpj_cpf
    attr_accessor :isuf
    attr_accessor :x_nome
    attr_accessor :im
    attr_accessor :cnae
    attr_accessor :crt
    
    def initialize
      self.ender_emit = NfeRuby::End.new 
    end
    
  end
end