require 'spec_helper'

describe Page do

  let(:page) { FactoryGirl.build(:page) }

  it 'should be valid with valid attributes' do
    page.should be_valid
  end

  describe '#content' do
    it 'should be valid html' do
      ['<div> left oak', 'right oak </div>', '<div>center oak</span>'].each do |html|
        page.content = html
        page.should have(1).errors_on(:content)
      end
      page.content = "<div>right oak</div><a href='forest'>oaks forest</a>"
      page.should be_valid
    end
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

    context 'when slug blank' do
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

    context 'when slug present' do
      it 'should not be changed after validation' do
        page.slug = 'world-hedgehogs-association'
        page.should be_valid
        page.slug.should == 'world-hedgehogs-association'
      end
    end
  end

end
