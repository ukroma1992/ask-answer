class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index 
    @users = User.all
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    
    if @user.save 
      redirect_to root_path, notice: "Пользователь успешно зарегистрирован!"
    else 
      render 'new'
    end
  end

  def edit
  end

  def update 
    if @user.update(user_params) 
      redirect_to user_path(@user), notice: "Данные обновлены!"
    else 
      render 'edit'
    end
  end

  private 

  def set_user 
    @user ||= User.find(params[:id])
  end

  def user_params 
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url)
  end
end
