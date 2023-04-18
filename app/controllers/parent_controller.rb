class ParentController < ApplicationController
  skip_before_action :verify_authenticity_token


  def parent_signin
    return render json: { :text => "Password and password confirmation are not equals", 
                          :status => 400 
                        } if !is_confirmation_equals_password(parent_signin_params[:password], 
                                                                parent_signin_params[:password_confirmation])
    response = signin_respone('parent', parent_signin_params)

    if response.code == '200'
      # API call was successful, so proceed with your app logic
      redirect_to 'localhost:3002/parent_dashboard/' . response.body['id']
    else
      # API call returned an error, so handle the error response
      error_message = JSON.parse(response.body)['error']
      render json: {
                :text => error_message, 
                :status => response.code }
    end
  end

  def parent_signup
  end

  private

  def parent_signin_params
    params.require(:parent).permit(:email, :password, :password_confirmation)
  end

  def parent_signup_params
    params.require(:parent).permit(:name, :email, :password, :password_confirmation)
  end
end
