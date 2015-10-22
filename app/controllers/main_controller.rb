class MainController < ApplicationController
    before_filter :authenticate_user!, except: [:index]
    before_filter :find_user_by_key, only: [:profile, :profile_killin_its_given, :profile_killin_its_received]

    def index
        if !params[:search].nil? && !params[:search].empty?
            @users = User.like(params[:search])
        else
            @users = []
        end
    end

    def killin_its_given
        @killin_its = current_user.killin_its_from.order(:created_at => :desc).page(params[:page]).per(20)
    end

    def killin_its_received
        @killin_its = current_user.killin_its_to.order(:created_at => :desc).page(params[:page]).per(20)
    end

    def profile
        @new_killin_it = KillinIt.new
        @new_killin_it.from_user = current_user
        @new_killin_it.to_user = @user
    end

    def profile_killin_its_given
        @killin_its = @user.killin_its_from.order(:created_at => :desc).page(params[:page]).per(20)
    end

    def profile_killin_its_received
        @killin_its = @user.killin_its_to.order(:created_at => :desc).page(params[:page]).per(20)
    end

    private

    def find_user_by_key
        @user = User.find_by_userkey(params[:key])
        if @user.nil?
            render_error :notfound
        end
    end
end
