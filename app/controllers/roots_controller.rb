class RootsController < ApplicationController
    
    def root
        @orders = Order.all
    end

end
