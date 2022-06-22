module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /typeahead/:input
    def typeahead
      key = params[:input]

      @results = User.where("firstName LIKE ? or lastName LIKE ? or email LIKE ?", "%"+key+"%", "%"+key+"%", "%"+key+"%")

      render json: @results, only: [:id, :firstName, :lastName, :email]
    end

    # GET /users
    def index
      @users = User.all

      render json: @users, only: [:id, :firstName, :lastName, :email]
    end

    # GET /user/:id
    def show
      render json: @user, only: [:id, :firstName, :lastName, :email]
    end

    # POST /user
    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: @user_url, only: [:id, :firstName, :lastName, :email]
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /user/:id
    def update
      if @user.update(user_params)
        render json: @user, only: [:id, :firstName, :lastName, :email]
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /user/:id
    def destroy
      @user.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:firstName, :lastName, :email)
      end
  end
end