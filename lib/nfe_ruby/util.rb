module NfeRuby
  class Util
    # Formatar data/hora (2015-06-15T15:01:00-03:00)
    def self.formatar_dh(data)
      data.strftime('%FT%T%:z')
    end

    # Calcular digito verificador da chave de acesso
    def self.calcular_digito_verificador(chave)
      peso = '4329876543298765432987654329876543298765432'
      aux = 0
      digito = 0

      (0..42).each do |i|
        aux = aux + chave[i].to_i * peso[i].to_i
        digito = 11 - aux.modulo(11)
      end

      if aux.modulo(11) < 2
        digito = 0
      end

      digito
    end
  end
end