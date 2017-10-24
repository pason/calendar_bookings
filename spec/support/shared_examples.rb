require "set"

shared_examples "booking conflict" do
  it 'returns status code 422' do
    expect(response).to have_http_status(422)
  end

  it 'returns a failure message' do
    expect(response.body).to match(/Booking conflicts with an existing booking/)
  end
end