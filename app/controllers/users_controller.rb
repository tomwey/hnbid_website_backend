# coding: utf-8
class UsersController < ApplicationController
  before_filter :require_user
  
  layout 'user_layout'
  
  # def home
  #
  # end
  
  def new_company
    session[:company_params] ||= {}
    
    @company = Company.new(session[:company_params])
    @company.current_step = session[:company_step]
    @action = '供应商资料录入'
  end
  
  def save_company
    # puts params[:company]
    session[:company_params].deep_merge!(params[:company]) if params[:company]
    @company = Company.new(session[:company_params])
    @company.current_step = session[:company_step]
    puts '-------------------'
    puts @company
    puts '-------------------'
    if @company.valid?
      if params[:back_button]
        @company.previous_step
      elsif @company.last_step?
        @company.save if @company.all_valid?
      else
        @company.next_step
      end
      session[:company_step] = @company.current_step
      puts session[:company_step]
    else
      puts 'dddddd'
    end
    
    # redirect_to portal_root_path
    if @company.new_record?
      render "new_company"
    else
      session[:company_step] = session[:company_params] = nil
      flash[:notice] = "保存成功"
      redirect_to portal_root_path
    end
  end
  
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