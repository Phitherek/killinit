class HelperController < ApplicationController
    def parameterize
        @parameterized_str = params[:str].parameterize
        render layout: false
    end
end
