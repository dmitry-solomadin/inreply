module ApplicationHelper

  def collect_controller_related
    controller_folder = (params[:controller].include? File::Separator) ?
        params[:controller].split("\/").last : params[:controller]
    "#{controller_folder}/#{controller_folder}"
  end

end
