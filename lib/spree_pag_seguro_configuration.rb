module Spree
  class PagSeguroConfiguration < Spree::Preferences::Configuration
    preference :email, default: "seu_email_cadastrad@pag_seguro.com.br"
    preference :token, default: "ALGUMTOKENMALDITO"
  end
end