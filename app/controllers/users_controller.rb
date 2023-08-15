# frozen_string_literal: true

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    unless User.find_by(email: params[:user][:email]).present?
      @user = User.create(sign_up_params)
      if @user.save
        account = Account.create!(user_id: @user.id, balance: 100, account_type:  params[:user][:account_type].to_sym)
        redirect_to root_path
      else
        puts @user.errors.full_messages
      end
    else
      flash[:error] = "User already exists"
      redirect_to new_user_path
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.password.match(params[:password])
      @user.update(logout_token: nil)
      redirect_to account_path(id: @user.id)
    else
      flash[:error] = "Invalid email or password"
      render :login
    end
  end

  def logout
    @user = User.find(params[:id])
    @user.update(logout_token: SecureRandom.hex)
    redirect_to root_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :logout_token, :username)
  end
end