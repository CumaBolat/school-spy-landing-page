class TeacherController < ApplicationController
  before_action :validate_password_confirmation, only: %i[teacher_signin teacher_signup]
  skip_before_action :verify_authenticity_token

  def teacher_signin
    response = signin_respone('teacher', params)

    if response.code == '200'
      redirect_to "http://localhost:3002/teacher_dashboard/#{JSON.parse(response.body)['id']}"
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
    response = signup_respone('/teacher_create', params)

    if response.code == '200'
      redirect_to "http://localhost:3002/teacher_dashboard/#{JSON.parse(response.body)['id']}"
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

  def validate_password_confirmation
    check_password_confirmation(params[:password], params[:password_confirmation])
  end
end
