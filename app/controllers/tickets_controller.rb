class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been created."
      render "new"
    end
  end

  def show
    @ticket = @project.tickets.find(params[:id])
  end

  private
    
    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The ticket you were looking for could not be found."
        redirect_to projects_path
    end

    def ticket_params
      params.require(:ticket).permit(:title, :description)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
