#    OOOR: OpenObject On Ruby
#    Copyright (C) 2009-2012 Akretion LTDA (<http://www.akretion.com>).
#    Author: Raphaël Valyi
#    Licensed under the MIT license, see MIT-LICENSE file

require File.dirname(__FILE__) + '/../lib/ooor-doc'

#RSpec executable specification; see http://rspec.info/ for more information.
#Run the file with the rspec command  from the rspec gem
describe Ooor do
  before(:all) do
    @url = 'http://localhost:8069/xmlrpc'
    @db_password = 'admin'
    @username = 'admin'
    @password = 'admin'
    @database = 'ooor_test'
    @ooor = Ooor.new(:url => @url, :username => @username, :password => @password)
  end

  it "should keep quiet if no database is mentioned" do
    @ooor.loaded_models.should be_empty
  end

  it "should be able to list databases" do
    @ooor.list.should be_kind_of(Array) 
  end

  it "should be able to create a new database with demo data" do
    unless @ooor.list.index(@database)
      @ooor.create(@db_password, @database)
    end
    @ooor.list.index(@database).should_not be_nil
  end

  
  describe "Configure existing database" do
    before(:all) do
      @ooor = Ooor.new(:url => @url, :username => @username, :password => @password, :database => @database)
    end

    it "should be able to load a profile" do
      module_ids = IrModuleModule.search(['name','=', 'sale']) + IrModuleModule.search(['name','=', 'account_voucher']) + IrModuleModule.search(['name','=', 'sale_stock'])
      module_ids.each do |accounting_module_id|
        mod = IrModuleModule.find(accounting_module_id) 
        unless mod.state == "installed"
          mod.button_install
        end
      end
      wizard = BaseModuleUpgrade.create
      wizard.upgrade_module
      @ooor.load_models
      @ooor.loaded_models.should_not be_empty
    end
  end


  describe "UML features" do
    before(:all) do
      @ooor = Ooor.new(:url => @url, :username => @username, :password => @password, :database => @database,
        :models => ['res.user', 'res.partner', 'product.product',  'sale.order', 'account.invoice', 'product.category', 'stock.move', 'ir.ui.menu'])
    end

    it "should be able to draw the UML of any class" do
      SaleOrder.print_uml.should be_true
    end

    it "should be able to draw the UML of several classes" do
      OoorDoc::UML.print_uml([SaleOrder, SaleShop]).should be_true
    end

    it "should accept rendering options" do
      SaleOrder.print_uml({:detailed => true}).should be_true
    end
  end

end
