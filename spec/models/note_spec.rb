require 'rails_helper'

describe Note do
  subject { build :note }

  describe 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:body) }

    describe "validates presence of photo delegates to dropin.file" do
      it "valid when present" do
        expect(subject).to be_valid
      end
      it "invalid when photo_dropin nil" do
        subject.photo_dropin = nil
        expect(subject).to_not be_valid
      end
      it "invalid when photo_dropin.file removed" do
        subject.photo_dropin.remove_file!
        expect(subject).to_not be_valid
      end
    end
  end


  # describe 'photo dropin' do
  #   describe '#photo' do
  #     it 'manages photo' do
  #       photo1 = build(:dropin)
  #       subject.photo = photo1
  #       expect(subject.photo).to eql photo1

  #       photo2 = build(:dropin)
  #       subject.photo = photo2
  #       expect(subject.photo).to eql photo2

  #       subject.photo = nil
  #       expect(subject.photo).to be_nil
  #     end
  #   end

  #   describe '#photo?' do
  #     it 'checks whether photo is present' do
  #       expect(subject.photo?).to be_true
  #       subject.photo = nil
  #       expect(subject.photo?).to be_false
  #     end
  #   end
  # end

  # describe 'image dropins' do
  #   describe '#images' do
  #     it 'manages images' do
  #       expect(subject.images?).to be_false

  #       image1 = build :dropin
  #       subject.images << image1
  #       expect(subject.images).to eql [image1]

  #       image2 = build :dropin
  #       subject.images << image2
  #       expect(subject.images).to eql [image1, image2]

  #       subject.images = nil
  #       expect(subject.images).to be_blank
  #     end
  #   end
  # end

end