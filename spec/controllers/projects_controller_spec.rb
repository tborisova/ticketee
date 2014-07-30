require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  
  it 'displays an error for a missing project' do
    get :show, id: 'not-here'

    expect(response).to redirect_to(projects_path)
    message = 'The project you were looking for could not be found.'
    expect(flash[:alert]).to eq message
  end
  
  context "standard users" do
    before { sign_in(user) }
    
    it "cannot access the new action" do
      get :new
      expect(response).to redirect_to('/')
      expect(flash[:alert]).to eql("You must be an admin to do that.")
    end
  end
end
