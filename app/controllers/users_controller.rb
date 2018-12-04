class UsersController < ApplicationController
  before_filter :require_user
  
  layout 'user_layout'
  
  def home
    set_menu_active('user_home')
  end
  
  def bids
    set_menu_active('user_bids')
  end
  
  def bid_results
    set_menu_active('user_bid_results')
  end
  
  def messages
    set_menu_active('messages')
  end
  
  def company
    set_menu_active('user_company')
  end
  
  def profile
    set_menu_active('profile')
  end
  
  def edit_pwd
    set_menu_active('edit_pwd')
  end
    
end