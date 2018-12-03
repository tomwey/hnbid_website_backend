class ProjectsController < ApplicationController
  layout 'project'
  
  def show
    @project = Project.find_by(uniq_id: params[:id])
    @project.add_visit
  end
  
end