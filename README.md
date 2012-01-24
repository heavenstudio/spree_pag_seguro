# Spree Pagseguro

Uma extensão do [Spree](http://spreecommerce.com) para permitir pagamentos utilizando o PagSeguro.

## Instalação

Adicione spree ao gemfile da sua aplicação, e também:

    gem "spree_pag_seguro", :git => "git://github.com/heavenstudio/spree-pag_seguro.git"

Rode a task de instalação:

    rails generate spree_pag_seguro:install

## Configuração

Adicione as seguintes linhas em config/initializers/spree_pag_seguro.rb, de acordo com sua conta no pag_seguro:

	<SuaAplicacao>::Application.configure do
	  config.after_initialize do
	    Spree::PagSeguro::Config.email = "seu_email_cadastrad@pag_seguro.com.br"
	    Spree::PagSeguro::Config.token = "ALGUMTOKENMALDITO"
	  end
	end
    
## TODO

* Fazer funcionar
* README mais completo
* Testes
