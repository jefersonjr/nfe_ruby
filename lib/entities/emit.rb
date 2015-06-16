require 'entities/end'

module NfeRuby
  class Emit
    attr_accessor :cnpj_cpf, :ie, :x_nome, :x_fant, :ender_emit, :iest, :crt, :cnpj_cpf
    attr_accessor :isuf, :x_nome, :im, :cnae, :crt
    
    def initialize
      self.ender_emit = NfeRuby::End.new 
    end
    
  end
end