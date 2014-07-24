require 'rails_helper'

describe Note do
  subject { build :note }

  describe 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:body) }
  end

  describe 'photo dropin' do
    it { should have_one :photo }

    describe "validates presence of photo delegates to dropin.file" do
      it "valid when present" do
        expect(subject.photo).to be_present
        expect(subject).to be_valid
      end
      it "invalid when photo_dropin.file removed" do
        subject.photo.remove_file!
        expect(subject).to_not be_valid
      end
    end

    describe "#photo= file stream" do
      it "adds a new uploader" do
        note = Note.new
        expect(note.photo).to be_nil
        note.photo = File.open(File.join(Rails.root, '/spec/support/valdez.jpg'))
        expect(note.photo.class).to eql Dropin
        expect(note.photo.url).to include('valdez')
      end

      it "uses existing uploader" do
        uploader = subject.photo
        expect(subject.photo.url).to include('obiwan')
        subject.photo = File.open(File.join(Rails.root, '/spec/support/valdez.jpg'))
        expect(subject.photo).to eql uploader
        expect(subject.photo.url).to include('valdez')
      end
    end

    describe "#photo= url" do
      it "adds a new uploader" do
        note = Note.new
        expect(note.photo).to be_nil
        note.photo = 'http://linowes.com/images/rayna_egg.jpg'
        expect(note.photo.class).to eql Dropin
        expect(note.photo.url).to include('rayna')
      end

      it "uses existing uploader" do
        uploader = subject.photo
        expect(subject.photo.url).to include('obiwan')
        subject.photo = 'http://linowes.com/images/rayna_egg.jpg'
        expect(subject.photo).to eql uploader
        expect(subject.photo.url).to include('rayna')
      end
    end


  end

  describe 'image dropins' do
    it { should have_many :images }

    describe "#image=" do
      it "adds a new uploader" do
        expect(subject.images).to be_empty
        subject.image = File.open(File.join(Rails.root, '/spec/support/valdez.jpg'))
        expect(subject.images.size).to eql 1
        uploader = subject.images.first
        expect(uploader.class).to eql Dropin
        expect(uploader.url).to include('valdez')
      end

      it "doesnt destroy existing uploaders" do
        subject.image = File.open(File.join(Rails.root, '/spec/support/valdez.jpg'))
        expect(subject.images.size).to eql 1
        subject.image = File.open(File.join(Rails.root, '/spec/support/obiwan.jpg'))
        expect(subject.images.size).to eql 2
        uploader = subject.images.first
        expect(subject.images[0].url).to include('valdez')
        expect(subject.images[1].url).to include('obiwan')

      end
    end

    describe '#images' do
    end
  end

end