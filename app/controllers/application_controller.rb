class ApplicationController < ActionController::Base
    include Pundit::Authorization
    before_action :configure_permitted_parameters, if: :devise_controller?
    rescue_from Pundit::NotAuthorizedError, with: :forbidden

    private

    def forbidden
        flash[:alert] = "You are not authorised to perform that action."
        redirect_to root_path
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, address_attributes: [:street, :city, :postcode]])
    end
end
