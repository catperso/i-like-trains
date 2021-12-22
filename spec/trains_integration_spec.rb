require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

DB = PG.connect({ dbname: 'train_station_test', host: 'db', user: 'postgres', password: 'password' })

describe('visits home page', {:type => :feature}) do
  it('should visit the home page') do
    visit('/')
    expect(page).to have_content("Choo Choo Mfer")
  end
end