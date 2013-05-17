require 'active_support/concern'
require 'active_support/dependencies/autoload'
require 'ooor'
require 'ooor/base'
require 'ooor-doc/uml'

module OoorDoc
  module PrintUml
    extend ActiveSupport::Concern
    module ClassMethods
      def print_uml(options={}); OoorDoc::UML.print_uml([self], options); end
    end
  end

  Ooor::Base.send :include, PrintUml
end
