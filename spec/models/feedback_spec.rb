require 'spec_helper'

describe Feedback do

  let(:feedback) { FactoryGirl.build(:feedback) }

  it 'should be valid with valid attributes' do
    feedback.should be_valid
  end

  describe '#email' do
    it 'should not be empty' do
      [nil, '', ' '].each do |email|
        feedback.email = email
        feedback.should be_invalid
      end
    end

    it 'should be valid' do
      ["fat@@hedgehog.com", "thin!@hedgehog.com", "drunk@hedgehog./"].each do |email|
        puts "-> #{email}"
        feedback.email = email
        feedback.should be_invalid
      end
    end
  end

  describe '#message' do
    it 'should not be empty' do
      [nil, '', ' '].each do |message|
        feedback.message = message
        feedback.should be_invalid
      end
    end

    it 'should have size 6-2048 symbols' do
      feedback.message = 'gunner'
      feedback.should be_valid

      feedback.message = 'lolol'
      feedback.should be_invalid

      feedback.message = 'l' * 2048
      feedback.should be_valid

      feedback.message = 'o' * 2049
      feedback.should be_invalid
    end
  end
end
