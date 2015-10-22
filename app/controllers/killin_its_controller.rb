class KillinItsController < ApplicationController

    before_filter :find_killin_it, except: [:create]
    before_filter :owner_or_admin_only, except: [:create]

    def create
        params[:killin_it][:from_user_id] = current_user.id
        @killin_it = KillinIt.create(killin_it_params)
        if @killin_it.new_record?
            flash[:error] = "Error while creating Killin' It: #{@killin_it.errors.full_messages.join(", ")}"
            redirect_to profile_path(@killin_it.to_user.userkey)
        else
            flash[:success] = "Successfully created Killin' It!"
            redirect_to given_path
        end
    end

    def edit
    end

    def update
        if @killin_it.update_attributes(killin_it_params)
            flash[:success] = "Successfully updated Killin' It!"
        else
            flash[:error] = "Error while updating Killin' It: #{@killin_it.errors.full_messages.join(", ")}"
        end
        redirect_to given_path
    end

    def destroy
        if @killin_it.destroy
            flash[:success] = "Successfully deleted Killin' It!"
        else
            flash[:error] = "Error while destroying Killin' It!"
        end
        redirect_to given_path
    end

    private

    def killin_it_params
        params.require(:killin_it).permit(:from_user_id, :to_user_id, :from_user, :to_user, :message, :created_at, :updated_at)
    end

    def find_killin_it
        begin
            @killin_it = KillinIt.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            render_error :notfound
        end
    end

    def owner_or_admin_only
        unless @killin_it.from_user == current_user || current_user.admin?
            render_error :forbidden
        end
    end
end
