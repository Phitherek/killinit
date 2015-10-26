class ApiController < ApplicationController

    protect_from_forgery with: :null_session

    before_filter :find_user_by_token, except: [:login]
    before_filter :find_user_by_key, only: [:user_profile, :user_given, :user_received]

    def login
        if params[:username].nil? || params[:password].nil? || params[:username].empty? || params[:password].empty?
            render json: {error: "emptyparams"}
        else
           @user = User.find_by_username(params[:username])
           if @user.nil?
               render json: {error: "unauthorized"}
           else
               if @user.valid_password?(params[:password])
                   @token = ApiToken.generate_for(@user)
                   render json: @token
               else
                   render json: {error: "unauthorized"}
               end
           end
        end
    end

    def search
        if params[:query].nil? || params[:query].empty?
            render json: {empty: "empty"}
        else
            @users = User.like(params[:query])
            if @users.empty?
                render json: {empty: "empty"}
            else
                render json: @users, root: :users
            end
        end
    end

    def my_profile
        render json: @current_user
    end

    def my_given
        render json: @current_user.killin_its_from, root: :killin_its
    end

    def my_received
        render json: @current_user.killin_its_to, root: :killin_its
    end

    def user_profile
        render json: @user
    end

    def user_given
        render json: @user.killin_its_from, root: :killin_its
    end

    def user_received
        render json: @user.killin_its_to, root: :killin_its
    end

    def create_killin_it
        if params[:to_userkey].nil? || params[:to_userkey].empty?
            render json: {error: "emptyparams"}
        else
            @to_user = User.find_by_userkey(params[:to_userkey])
            if @to_user.nil?
                render json: {error: "notfound"}
            else
                @killin_it = KillinIt.create(from_user: @current_user, to_user: @to_user, message: params[:message])
                if @killin_it.new_record?
                    render json: {error: KillinIt.errors.full_messages.join(", ")}
                else
                    render json: {success: "success"}
                end
            end
        end
    end

    def update_killin_it
        if params[:killin_it_id].nil? || params[:killin_it_id].empty?
            render json: {error: "emptyparams"}
        else
            begin
                @killin_it = KillinIt.find(params[:killin_it_id])
                if @killin_it.from_user == @current_user
                    @killin_it.message = params[:message]
                    if @killin_it.save
                        render json: {success: "success"}
                    else
                        render json: {error: @killin_it.errors.full_messages.join(", ")}
                    end
                else
                    render json: {error: "unauthorized"}
                end
            rescue ActiveRecord::RecordNotFound => e
                render json: {error: "notfound"}
            end
        end
    end

    def destroy_killin_it
        if params[:killin_it_id].nil? || params[:killin_it_id].empty?
            render json: {error: "emptyparams"}
        else
            begin
                @killin_it = KillinIt.find(params[:killin_it_id])
                if @killin_it.from_user == @current_user
                    if @killin_it.destroy
                        render json: {success: "success"}
                    else
                        render json: {error: @killin_it.errors.full_messages.join(", ")}
                    end
                else
                    render json: {error: "unauthorized"}
                end
            rescue ActiveRecord::RecordNotFound => e
                render json: {error: "notfound"}
            end
        end
    end

    def logout
        if @token.destroy
            render json: {success: "success"}
        else
            render json: {error: "destroyfailure"}
        end
    end

    private

    def find_user_by_token
        if params[:token].nil? || params[:token].empty?
            render json: {error: "emptyparams"}
        else
            @token = ApiToken.find_by_token(params[:token])
            if @token.nil?
                render json: {error: "unauthorized"}
            else
                @current_user = @token.user
                if @current_user.nil?
                    render json: {error: "unauthorized"}
                end
            end
        end
    end

    def find_user_by_key
        if params[:userkey].nil? || params[:userkey].empty?
            render json: {error: "emptyparams"}
        else
            @user = User.find_by_userkey(params[:userkey])
            if @user.nil?
                render json: {error: "notfound"}
            end
        end
    end
end
