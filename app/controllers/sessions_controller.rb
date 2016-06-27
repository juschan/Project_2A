class SessionsController < ApplicationController
  def new
    #redirect_to post_path unless session[:user_id]==nil
    @posts = Post.all
    render "new"
  end

  def create
    user=User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash.now.alert ="Couldn't sign you in. Please check your email and password."
      #redirect_to signin_path
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now.alert ="Signed Out"
    #params[:error]="Signed Out"
    redirect_to home_path, notice: "Signed out"
  end
end

