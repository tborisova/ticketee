require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }
  
  it 'displays an error for a missing project' do
    get :show, id: 'not-here'

    expect(response).to redirect_to(projects_path)
    message = 'The project you were looking for could not be found.'
    expect(flash[:alert]).to eq message
  end

  it "cannot access the show action without permission" do
    project = FactoryGirl.create(:project)
  
    get :show, id: project.id
  
    expect(response).to redirect_to(projects_path)
    expect(flash[:alert]).to eql("The project you were looking for could not be found.")
  end
  
  context "standard users" do
    { new: :get, edit: :get, create: :post, update: :put, destroy: :delete }.each do |action, method|
      it "cannot access the new action" do
        send(method, action, :id => FactoryGirl.create(:project))

        expect(response).to redirect_to('/')
        expect(flash[:alert]).to eql("You must be an admin to do that.")
      end
    end
  end
end
