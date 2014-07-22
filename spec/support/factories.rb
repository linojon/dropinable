include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :note do
    sequence(:body)  {|n| "Note ##{n}"}
    after(:build) do |note|
      note.photo = fixture_file_upload File.join(Rails.root, '/spec/support/obiwan.jpg')
    end
  end

  factory :dropin do
    file { fixture_file_upload File.join(Rails.root, '/spec/support/obiwan.jpg') }
    #file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/obiwan.jpg')))
  end

end