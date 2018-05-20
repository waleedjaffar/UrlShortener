module ApplicationHelper

  def base_url(short_url = nil)
    "#{request.protocol}#{request.host_with_port}/#{short_url}"
  end
end
