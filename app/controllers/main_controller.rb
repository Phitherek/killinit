class MainController < ApplicationController
    before_filter :authenticate_user!, except: [:index]

    def index
    end

    def killin_its_given
    end

    def killin_its_received
    end

    def profile
    end

    def profile_killin_its_given
    end

    def profile_killin_its_received
    end
end
