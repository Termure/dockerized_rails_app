require 'rails_helper'

RSpec.describe 'PageViews' do
  it 'shows the number of pages' do
    visit '/welcome'
    expect(page.text).to match(/This page has been viewed [0-9]+ times ?!/)
  end
end
