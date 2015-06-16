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

  CODIGO_UF = { 'RO' => 11, 'AC' => 12, 'AM' => 13, 'RR' => 14, 'PA' => 15, 'AP' => 16, 'TO' => 17,
                'MA' => 21, 'PI' => 22, 'CE' => 23, 'RN' => 24, 'PB' => 25, 'PE' => 26, 'AL' => 27,
                'SE' => 28, 'BA' => 29, 'MG' => 31, 'ES' => 32, 'RJ' => 33, 'SP' => 35, 'PR' => 41,
                'SC' => 42, 'RS' => 43, 'MS' => 50, 'MT' => 51, 'GO' => 52, 'DF' => 53}

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
      self.ide = NfeRuby::Ide.new
      self.emit = NfeRuby::Emit.new
      self.dest = NfeRuby::Dest.new
      self.imposto = NfeRuby::Imposto.new
      self.total = NfeRuby::Total.new
      self.transp = NfeRuby::Transp.new
      self.inf_adic = NfeRuby::InfAdic.new

      self.uf_wsdl = options[:uf_wsdl]
      self.cert_file = options[:cert_key_file]
      self.priv_key_file = options[:priv_key_file]
      self.priv_key_pass = options[:priv_key_pass]
    end
  end
end
