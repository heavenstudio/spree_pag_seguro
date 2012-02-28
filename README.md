# Spree Pagseguro

Uma extensão do [Spree](http://spreecommerce.com) para permitir pagamentos utilizando o PagSeguro.

## Instalação

Adicione spree ao gemfile da sua aplicação, e também:

    gem "spree_pag_seguro"

Rode a task de instalação:

    rails generate spree_pag_seguro:install
	
## Configuração

É necessário configurar as seguintes informaçãoes na sua conta no PagSeguro:

    Em Integrações -> Token de segurança clique em Gerar novo token e guarde esta informação em local seguro
    Em Integrações -> Pagamentos via API é necessário ativar a opção "Quero receber somente pagamentos via API."
    Em Integrações -> Notificação de transações é necessário ativar a notificação de transações e definir a url para receber as notificações como: <url da sua aplicação>/pag_seguro/notify
	
Após feita a instalação e migração, acesse a administração do spree, vá em Configuração -> Métodos de Pagamento e adicione um novo método selecionando `Spree::PaymentMethod::PagSeguroMethod`, adicionando seu e-mail e token utilizados no PagSeguro.

## Adaptação

É bem provável que você queira alterar as informações presentes na página de callback para onde o usuário é levado após realizar a compra no pag seguro.
Para tanto, basta criar um arquivo em app/views/spree/pag_seguro/callback.html.erb.
No momento em que o usuário é redirecionado, a compra pode ter sido aprovada ou não, então a mensagem desta página é genérica e reflete esta incerteza.

Caso queira enviar um e-mail ao usuário quando a compra for aprovada pelo pagseguro, sobrescreva a máquina de estados do `Spree::Payment` em sua aplicação para fazer o envio do e-mail (a classe PaymentMailer não existe, e precisa ser criada por você):
	
	Spree::Payment.class_eval do
	  state_machine do
	    after_transition :to => 'completed', :do => :send_confirmation!
	  end
  
	  def send_confirmation!
	    PaymentMailer.confirm_email(self.order).deliver
	  end
	end
    
    
## TODO

* Adicionar Testes
* Fazer a página de Callback verificar se a compra já está aprovada ou não no PagSeguro

## Contribuindo

Caso queira contribuir, faça um fork desta gem no [github](https://github.com/heavenstudio/spree_pag_seguro), corriga o bug/ adicione a feature desejada e faça um merge request.

## Sobre

Desenvolvida por [Stefano Diem Benatti](mailto:stefano.diem@gmail.com)
