require 'entities/end'

module NfeRuby
  class Dest
    attr_accessor :cnpj_cpf, :isuf, :x_nome, :ender_dest, :email, :ie, :ind_ie_dest
    
    def initialize
      self.ender_dest = NfeRuby::End.new
    end
    
  end
end