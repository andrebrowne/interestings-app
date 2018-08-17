require 'rails_helper'

RSpec.describe OtdsController, type: :controller do
    describe "GET index" do

        it "renders the index template" do
            get :index
            expect(response).to render_template("index")
        end

        it "assigns @interestings" do
            get :index
            expect(assigns(:interestings)).to be_an_instance_of(Wikipedia::Page)
        end
    end
end
