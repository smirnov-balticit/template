require 'spec_helper'

describe Page do

  let(:page) { FactoryGirl.build(:page) }

  it 'should be valid with valid attributes' do
    page.should be_valid
  end

  describe '#name' do
    it 'should not be empty' do
      page.name = ' '
      page.should have(1).errors_on(:name)
    end
  end

  describe '#slug' do
    it 'should be unique' do
      FactoryGirl.create :page, :slug => page.slug
      page.should have(1).errors_on(:slug)
    end

    context 'when slug is blank' do
      context 'when there is only russian translation' do
        it 'should be filled with transliterated name' do
          rus = FactoryGirl.build(:page_translation, locale: :ru, name: 'Всероссийская ассоциация ежей')
          page.translations = [rus]
          page.slug = ' '
          page.should be_valid
          page.slug.should == 'vserossiyskaya-assotsiatsiya-ezhey'
        end
      end

      context 'when there is english translation' do
        it 'should be filled with parameterized english name' do
          eng = FactoryGirl.build(:page_translation, locale: :en, name: 'Russian hedgehogs assosiation')
          rus = FactoryGirl.build(:page_translation, locale: :ru, name: 'Всероссийская ассоциация ежей')
          page.translations = [eng, rus]
          page.slug = ' '
          page.should be_valid
          page.slug.should == 'russian-hedgehogs-assosiation'
        end
      end

      context 'when there are not translations' do
        it 'should be invalid' do
          page.translations = []
          page.slug = ' '
          page.should have(1).errors_on(:slug)
        end
      end
    end
  end

end
