require "rails_helper"

RSpec.describe "Pages", type: :request do
  it "renders the home page" do
    get root_path
    expect(response).to have_http_status(:ok)
  end
end
