class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def self.current_user
    session['current_user']
  end
  
  def after_sign_in_path_for(resource)
  	# for monodocument phase :)
  	documents_path
  end

  def check_profile_completeness
    redirect_to login_path if current_user.name.nil? || current_user.workplace.nil?
  end
end
