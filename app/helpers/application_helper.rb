module ApplicationHelper
  def get_all_schools
    url = URI("http://localhost:3001/schools_index")

    request = Net::HTTP::Get.new(url)
    
    response = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == "https") do |http|
      http.request(request)
    end

    response = JSON.parse(response.body)

    return response.map { |school| [school['name']]}
  end
end
