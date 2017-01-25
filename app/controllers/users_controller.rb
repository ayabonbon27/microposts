class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update]
  
   def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
       redirect_to @user 
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'プロフィールを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :location, :profile)
  end
  
   def set_user
      @user = User.find(params[:id])
    if @user != current_user
     redirect_to root_path , notice: 'あなた以外のプロフィールは編集できません'
    end
   end
end
