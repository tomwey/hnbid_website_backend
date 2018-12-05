class Portal::ApplicationController < ApplicationController
  # include Pundit
  layout 'user_layout'
  
  before_filter :require_user
  before_filter :check_user
  # before_filter :check_user_profile
  
  private
  def check_user_profile
    if current_user.company_id.blank?
      redirect_to new_company_user_path(current_user.login)
    end
  end
  
end