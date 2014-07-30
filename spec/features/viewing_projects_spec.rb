require 'rails_helper'

feature "Viewing projects" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }

  before do
    define_permission!(user, :view, project) 
    sign_in_as! user
  end

  scenario "Listing all projects" do
    visit '/'

    click_link project.name
    
    expect(page.current_url).to eql(project_url(project))
  end 
end