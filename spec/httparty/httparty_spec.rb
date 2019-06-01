describe 'HttParty' do
  it 'HttParty', vcr: { cassette_name: 'jsonplaceholder/posts', :record => :new_episodes } do
    #stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
    #       to_return(status: 200, body: "", headers: {'content_type':'application/json; charset: UTF-8'})
    response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/4")
    content_type = response.headers['content-type']
    expect(content_type).to match(/application\/json/)
  end
end
