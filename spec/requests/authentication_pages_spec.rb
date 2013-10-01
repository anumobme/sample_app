require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

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
end