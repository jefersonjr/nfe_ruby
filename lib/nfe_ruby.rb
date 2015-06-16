require 'entities/ide'
require 'entities/emit'
require 'entities/dest'
require 'entities/det'
require 'entities/imposto'
require 'entities/total'
require 'entities/transp'
require 'entities/inf_adic'
require 'xmldsig'

module NfeRuby
  class Nfe
    # Detalhes da NF-e
    @det = []

    @wsdl = "https://nfe.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx"

    attr_accessor :ide
    attr_accessor :emit
    attr_accessor :dest
    attr_accessor :det
    attr_accessor :imposto
    attr_accessor :total
    attr_accessor :transp
    attr_accessor :inf_adic
    attr_accessor :cert_file
    attr_accessor :priv_key_file
    attr_accessor :priv_key_pass
    attr_accessor :uf_wsdl

    def initialize(options = {})
      self.ide = NfeRails::Ide.new
      self.emit = NfeRails::Emit.new
      self.dest = NfeRails::Dest.new
      self.imposto = NfeRails::Imposto.new
      self.total = NfeRails::Total.new
      self.transp = NfeRails::Transp.new
      self.inf_adic = NfeRails::InfAdic.new

      self.uf_wsdl = @options[:uf_wsdl]
      self.cert_file = @options[:cert_key_file]
      self.priv_key_file = @options[:priv_key_file]
      self.priv_key_pass = @options[:priv_key_pass]
    end
  end
end
