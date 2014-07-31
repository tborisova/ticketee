require 'rails_helper'

RSpec.describe TicketsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context 'standard users' do
    it 'cannot access a ticket for a project' do
      sign_in user

      get :show, id: ticket, project_id: project

      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eq 'The project you were looking for could not be found.'
    end
  end
  context "with permission to view the project" do
    before do
      sign_in(user)
      define_permission!(user, "view", project)
    end

    def cannot_create_tickets!
      response.should redirect_to(project)
      message = "You cannot create tickets on this project."
      flash[:alert].should eql(message)
    end
    
    it "cannot begin to create a ticket" do
      get :new, project_id: project.id
      cannot_create_tickets!
    end
    
    it "cannot create a ticket without permission" do
      post :create, project_id: project.id
      cannot_create_tickets!
    end 
  end
end
