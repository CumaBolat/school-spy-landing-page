module ApplicationHelper
  def all_schools
    url = URI('http://localhost:3001/schools_index')

    request = Net::HTTP::Get.new(url)

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == 'https') do |http|
      http.request(request)
    end

    response = JSON.parse(response.body)

    response.map { |school| [school['name']] }
  end

  def all_teachers
    url = URI('http://localhost:3001/teachers_index')

    request = Net::HTTP::Get.new(url)

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == 'https') do |http|
      http.request(request)
    end

    response = JSON.parse(response.body)

    response.map { |teacher| [teacher['name']] }
  end
end
