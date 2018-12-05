class HomeController < ApplicationController
  def error_404
    render text: 'Not found', status: 404, layout: false
  end
  
  def index
    @tags = []
    @projects = []
  end
  
end