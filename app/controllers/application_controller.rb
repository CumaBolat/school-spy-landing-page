class ApplicationController < ActionController::Base
  #TODO: The url should be stored in a config file.
  def signin_respone(path, params)
    url = URI("http://localhost:3001/#{path}/")
    
    cur_params = { 
      "email" => params[:email], 
      "password" => params[:password],
    }

    url.query = URI.encode_www_form(cur_params)
    request = Net::HTTP::Get.new(url)
    
    response = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == "https") do |http|
      http.request(request)
    end

    return response
  end

  def signup_respone(path, params)
    url = URI("http://localhost:3001/#{path}/")

    cur_params = create_params(params)

    url.query = URI.encode_www_form(cur_params)
    request = Net::HTTP::Post.new(url)

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == "https") do |http|
      http.request(request)
    end

    return response
  end

  def check_password_confirmation(password, password_confirmation)
    return if password == password_confirmation

    render_confirmation_is_not_equal_password
  end

  def render_confirmation_is_not_equal_password
    return render json: { :text => "Password and password confirmation are not equals", 
                          :status => 400 
                        }
  end

  private

  def create_params(params)
    common = {
      "name" => params[:name],
      "surname" => params[:surname],
      "email" => params[:email],
      "phone_number" => params[:phone_number],
      "password" => params[:password],
      "password_confirmation" => params[:password_confirmation]
    }
  
    model_specific_params = %w(child_name 
                                social_id 
                                parent_job
                                parent_age
                                child_age
                                child_grade
                                child_school_id
                                is_only_child
                                school_name
                                description
                                age
                                school_id
                              )
  
    model_specific_params.each do |param|
      common[param] = params[param] if params.key?(param)
    end
  
    common
  end
end
