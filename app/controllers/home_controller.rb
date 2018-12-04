class HomeController < ApplicationController
  def error_404
    render text: 'Not found', status: 404, layout: false
  end
  
  def index
    set_menu_active('home')
  end
  
  def about
    set_menu_active('about')
  end
  
end