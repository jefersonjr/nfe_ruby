module NfeRuby
  class Signer
    def initialize(options = {})
      # Inicializar certificado, chave privada e digest
      @pub_key = OpenSSL::X509::Certificate.new(File.read(options[:cert_file])) if options[:cert_file].present?
      @priv_key = OpenSSL::PKey::RSA.new(File.read(options[:priv_key_file]), options[:priv_key_pass]) if options[:priv_key_file].present?
      @digest = OpenSSL::Digest::SHA1.new
    end

    # Assinar um documento XML
    def assinar(xml, tag)
      @xml = Nokogiri::XML(xml, &:noblanks)
      node = @xml.at(tag)
      if node.present?
        digest(node, node.attribute('Id'))
        sign_document
        @xml.to_xml(:save_with => 0)
      else
        raise "Tag informada não existe no XML informado."
      end
    end

    def sign_document
      # Montar tag contendo informações do certificado
      key_info

      # Assinar
      signed_info_canon = canonicalize(signed_info_node)
      signature = @priv_key.sign(@digest, signed_info_canon)
      signature_value_digest = Base64.encode64(signature).gsub("\n", '')

      # Adicionar no XML conteudo da assinatura
      signature_value_node = Nokogiri::XML::Node.new('SignatureValue', @xml)
      signature_value_node.content = signature_value_digest
      signed_info_node.add_next_sibling(signature_value_node)
    end

    def key_info
      cert_node = Nokogiri::XML::Node.new('X509Certificate', @xml)
      cert_node.content = Base64.encode64(@pub_key.to_der).gsub("\n", '')

      data_node = Nokogiri::XML::Node.new('X509Data', @xml)
      data_node.add_child(cert_node)

      key_info_node = Nokogiri::XML::Node.new('KeyInfo', @xml)
      key_info_node.add_child(data_node)

      signed_info_node.add_next_sibling(key_info_node)
    end

    def signed_info_node
      node = signature_node.at_xpath('ds:SignedInfo', ds: 'http://www.w3.org/2000/09/xmldsig#')
      unless node
        node = Nokogiri::XML::Node.new('SignedInfo', @xml)
        signature_node.add_child(node)

        canonicalization_method_node = Nokogiri::XML::Node.new('CanonicalizationMethod', @xml)
        canonicalization_method_node['Algorithm'] = 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315'
        node.add_child(canonicalization_method_node)

        signature_method_node = Nokogiri::XML::Node.new('SignatureMethod', @xml)
        signature_method_node['Algorithm'] = "http://www.w3.org/2000/09/xmldsig#rsa-sha1"
        node.add_child(signature_method_node)
      end
      node
    end

    def signature_node
      @signature_node ||= begin
        @signature_node = @xml.document.root.at_xpath('ds:Signature', ds: 'http://www.w3.org/2000/09/xmldsig#')
        unless @signature_node
          @signature_node = Nokogiri::XML::Node.new('Signature', @xml)
          @signature_node.default_namespace = 'http://www.w3.org/2000/09/xmldsig#'
          @xml.document.root.add_child(@signature_node)
        end
        @signature_node
      end
    end

    def canonicalize(node = document)
      node.canonicalize(Nokogiri::XML::XML_C14N_EXCLUSIVE_1_0, nil, nil)
    end

    def digest(node, id_doc)
      target_canon = canonicalize(node)
      target_digest = Base64.encode64(@digest.digest(target_canon)).strip

      reference_node = Nokogiri::XML::Node.new('Reference', @xml)
      reference_node['URI'] = "##{id_doc}"
      signed_info_node.add_child(reference_node)

      transforms_node = Nokogiri::XML::Node.new('Transforms', @xml)
      reference_node.add_child(transforms_node)

      env_node = Nokogiri::XML::Node.new('Transform', @xml)
      env_node['Algorithm'] = 'http://www.w3.org/2000/09/xmldsig#enveloped-signature'

      can_node = Nokogiri::XML::Node.new('Transform', @xml)
      can_node['Algorithm'] = 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315'

      transforms_node.add_child(env_node)
      transforms_node.add_child(can_node)

      digest_method_node = Nokogiri::XML::Node.new('DigestMethod', @xml)
      digest_method_node['Algorithm'] = 'http://www.w3.org/2000/09/xmldsig#sha1'
      reference_node.add_child(digest_method_node)

      digest_value_node = Nokogiri::XML::Node.new('DigestValue', @xml)
      digest_value_node.content = target_digest
      reference_node.add_child(digest_value_node)
      self
    end
  end
end
