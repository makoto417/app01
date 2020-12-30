class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :profile, { console_ids: [], category_ids: [] }])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :profile, :image, { console_ids: [], category_ids: [] }])
  end

end
