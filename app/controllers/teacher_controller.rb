class TeacherController < ApplicationController
  before_action :validate_password_confirmation, only: %i[teacher_signin teacher_signup]
  skip_before_action :verify_authenticity_token

  def teacher_signin
    response = signin_respone('teacher', teacher_signin_params)

    if response.code == '200'
      # API call was successful, so proceed with your app logic
      render json: response.body
      redirect_to 'localhost:3002/teacher_dashboard/'.response.body['id']
    else
      # API call returned an error, so handle the error response
      error_message = JSON.parse(response.body)['error']
      render json: {
        text: error_message,
                status: response.code
      }
    end
  end

  def teacher_signup
    response = signup_respone('3001/teacher_create', teacher_signup_params)

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

  def teacher_signin_params
    params.permit(:email, :password, :password_confirmation)
  end

  def teacher_signup_params
    params.require(:teacher).permit(:name,
                                    :surname,
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    :phone_number,
                                    :age,
                                    :school_id,
                                    :description)
  end

  def validate_password_confirmation
    check_password_confirmation(params[:password], params[:password_confirmation])
  end
end
