module Spree
  module PagSeguro
    class Engine < Rails::Engine
      engine_name 'spree_pag_seguro'
    
      initializer "spree.active_shipping.configuration", :after => "spree.environment" do |app|
        Dir.glob(File.join(File.dirname(__FILE__), "../../lib/spree_pag_seguro_configuration.rb")) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end
    
      initializer "spree.pag_seguro.preferences", :after => "spree.active_shipping.configuration" do |app|
        Spree::PagSeguro::Config = Spree::PagSeguroConfiguration.new
      end
          
      config.autoload_paths += %W(#{config.root}/lib)
    
      # use rspec for tests
      config.generators do |g|
        g.test_framework :rspec
      end
    
      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end
    
      config.to_prepare &method(:activate).to_proc
    end
  end
end