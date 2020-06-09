require './lib/file_validation.rb'
require './lib/style_validate.rb'

describe FileValidation do
  describe '#file_exist(file)' do
    it 'Returns true if file exists' do
      file = FileValidation.new
      expect(file.file_exist('./bin/linter.rb')).to eql(true)
    end
  end
  describe '#file_exist(file)' do
    it 'Returns Nil if file does not exists' do
      file = FileValidation.new
      expect(file.file_exist('./bin/new.rb')).to eql(nil)
    end
  end
end
