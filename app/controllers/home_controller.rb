class HomeController < ApplicationController
  def error_404
    render text: 'Not found', status: 404, layout: false
  end
  
  def index
    @tags = Tag.all
    @projects = Project.where(opened: true).order('sort asc')
  end
  
end