class HomesController < ApplicationController
  def top
  end
  
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲスト"
      user.last_name = "ゲスト"
      user.first_name ="ユーザー"
      user.last_name_kana ="ゲスト"
      user.first_name_kana ="ユーザー"
      
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
