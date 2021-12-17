class SessionsController < ApplicationController

  def new
  end

  # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        user.create_notice('初回ログインありがとうございます。', 'first_login') if user.sign_in_count.zero?
        user.update(sign_in_count: user.sign_in_count += 1)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  # rubocop:enable Metrics/MethodLength,Metrics/AbcSize

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
