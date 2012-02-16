module Spree
  class PagSeguroConfiguration < Spree::Preferences::Configuration
    preference :email, :string, default: "seu_email_cadastrado@pag_seguro.com.br"
    preference :token, :string, default: "SEUTOKENNOPASEGURO"
  end
end