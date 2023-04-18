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

  def is_confirmation_equals_password?(password, password_confirmation)
    return password == password_confirmation
  end
end
