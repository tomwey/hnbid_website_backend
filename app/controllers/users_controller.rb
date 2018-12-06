# coding: utf-8
class UsersController < ApplicationController
  before_filter :require_user
  before_filter :authrize_user
  before_filter :check_user_profile, except: [:new_company, :save_company]
    
  layout :layout_by
  
  def layout_by
    puts request.referer
    if action_name == 'new_company' || (action_name == 'save_company' && params[:from].blank?)
      'account'
    else
      'user_layout'
    end
  end
  # def home
  #
  # end
  
  def new_company
    # puts '123'
    session[:company_params] ||= {}
    
    @company = Company.new(session[:company_params])
    @company.current_step = session[:company_step]
    
    # puts @company
    
    @action = '供应商资料录入'
  end
  
  def save_company
    # puts params[:company]
    
    session[:company_params].deep_merge!(params[:company]) if params[:company]
    @company = Company.new(session[:company_params])
    @company.current_step = session[:company_step]
    if @company.valid?
      if params[:back_button]
        @company.previous_step
      elsif @company.last_step?
        # @company.users << current_user
        current_user.company = @company
        if @company.all_valid?
          if @company.save
            current_user.company_id = @company.id
            current_user.save
          else
            
          end
        else
        end
        
      else
        @company.next_step
      end
      session[:company_step] = @company.current_step
      # puts session[:company_step]
    else
      
    end
    
    @action = '供应商资料录入'
    
    # redirect_to portal_root_path
    if @company.new_record?
      render "new_company"
    else
      session[:company_step] = session[:company_params] = nil
      flash[:notice] = "保存成功"
      redirect_to home_user_path(current_user.login)
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
    @company = current_user.company
    session[:company_params] ||= {}
    
    @company.current_step = session[:company_step]
  end

  def edit_pwd
    set_menu_active('edit_pwd')
  end
  
  private
    def check_user_profile
      if current_user.company_id.blank?
        redirect_to new_company_user_path(current_user.login)
      end
    end
    
    def authrize_user
      # puts params
      if params[:id] != current_user.login
        redirect_to root_path, alert: '非法访问'
      end
    end
    
end