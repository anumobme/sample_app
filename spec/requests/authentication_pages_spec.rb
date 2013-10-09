require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link('Users',       href: users_path) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "after visiting another page" do
        before { 
        	within(".footer") do
        		click_link "Home" 
        	end

        	}
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
        
        describe "as non-admin user" do
          let!(:user) { FactoryGirl.create(:user) }
          let!(:non_admin) { FactoryGirl.create(:user) }

          before { sign_in non_admin, no_capybara: true }

          describe "submitting a DELETE request to the Users#destroy action" do
            before { delete user_path(user) }
            specify { expect(response).to redirect_to(root_url) }
          end
        end

      end
    end
  end

  

end