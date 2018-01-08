class UsersController < ApplicationController
  before_action :authentifier, only: [:edit,:update, :index]
  before_action :autoriser, only: [:edit,:update]
  before_action :admin_user, only: [:destroy]
  before_action :verify_connected , only: [:new, :create]
  def index
    @titre = "liste utilisateurs"
    @users = User.page(params[:page]).per(20)
  end

  def new
  	@titre = "Inscription"
  	@user = User.new
  end

  def show 	
  	@user = User.find(params[:id])
  	@titre = @user.nom
    @microposts = @user.microposts.page(params[:page]).per(20)
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
      flash[:info] = "Bienvenue sur sample app #{@user.nom}"
      redirect_to @user
    else
      @titre = "Inscription"
      render 'new'
    end
  end

  def edit
   # @user = User.find(params[:id])
    @titre = "edition profil"
  end

  def update
   # @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:info] = "Modification enregistré"
      redirect_to @user
    else
      @titre = "edition profil"
      render 'edit'
    end
  end

  def user_params
    params.require(:user).permit(:nom,:email,:password,:password_confirmation)
  end

  def autoriser
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def destroy
    user = User.find_by_id(params[:id])
    user.destroy unless current_user == user
    flash[:success] = "Suppression éffectué"
    redirect_to users_path
  end

  private

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def verify_connected
    redirect_to root_path unless current_user.nil?
  end

end
