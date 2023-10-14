class ParentController < ApplicationController
  before_action :validate_password_confirmation, only: %i[parent_signin parent_signup]
  skip_before_action :verify_authenticity_token

  def parent_signin
    response = signin_respone('parent', parent_signin_params)

    if response.code == '200'
      # API call was successful, so proceed with your app logic
      redirect_to 'localhost:3002/parent_dashboard/'.response.body['id']
    else
      # API call returned an error, so handle the error response
      error_message = JSON.parse(response.body)['error']
      render json: {
        text: error_message,
                status: response.code
      }
    end
  end

  def parent_signup
    response = signup_respone('3001/parent_create', parent_signup_params)

    if response.code == '200'
      # API call was successful, so proceed with your app logic
      console.log(response.body)

      render json: {text: 'User created successfully'}
    else
      # API call returned an error, so handle the error response
      error_message = JSON.parse(response.body)['error']
      render json: {
        text: error_message,
                status: response.code
      }
    end
  end

  private

  def parent_signin_params
    params.require(:parent).permit(:email, :password, :password_confirmation)
  end

  def parent_signup_params
    params.require(:parent).permit(:name,
                                   :surname,
                                   :child_name,
                                   :email,
                                   :phone_number,
                                   :password,
                                   :password_confirmation,
                                   :social_id,
                                   :parent_job,
                                   :parent_age,
                                   :child_age,
                                   :child_grade,
                                   :child_school_id,
                                   :is_only_child,
                                   :school_name)
  end

  def validate_password_confirmation
    check_password_confirmation(params[:password], params[:password_confirmation])
  end
end
