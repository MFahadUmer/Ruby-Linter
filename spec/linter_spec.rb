# rubocop:disable Layout/LineLength
require './lib/file_validation.rb'
require './lib/style_error.rb'

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

describe StyleError do
  describe 'space_between_method_parenthesis' do
    it 'Returns Empty Array if No space found' do
      validate = StyleError.new
      lines = ['def main()', 'end']
      expect(validate.space_between_method_parenthesis(lines)).to eql([])
    end
    it 'Returns Array with messages if space found' do
      validate = StyleError.new
      lines = ['def main ()', 'end']
      expect(validate.space_between_method_parenthesis(lines)).to eql(['Space found before parenthesis. Line No. 1'])
    end
  end

  describe 'Indentation' do
    it 'Returns Empty Array if No Indentation Error found' do
      validate = StyleError.new
      lines = ["class TestClass\n", "  def my_method\n", "    if true\n", "      puts 'Yes'\n", "      puts 'False' if false\n", "      if false\n", "        puts 'Again false'\n", "      end\n", "    end\n", "  end\n", 'end']
      expect(validate.indentation(lines)).to eql([])
    end
    it 'Returns Array with messages if Indentations found' do
      validate = StyleError.new
      lines = ["class TestClass\n", "  def my_method\n", "    if true\n", "      puts 'Yes'\n", "      puts 'False' if false\n", "      if false\n", "          puts 'Again false'\n", "      end\n", "     end\n", "  end\n", 'end']
      expect(validate.indentation(lines)).to eql(['StyleError:Indentation at Line no. 7  Indentations required: 8', 'StyleError:Indentation at Line no. 9  Indentations required: 4'])
    end
  end

  describe 'Space_after_comma' do
    it 'Returns Empty Array if only one space found after comma' do
      validate = StyleError.new
      lines = ['my_array = [1, 2, 3, 4, 5, 6]']
      expect(validate.comma_with_space(lines)).to eql([])
    end
    it 'Returns Array with messages if more than one space found after comma' do
      validate = StyleError.new
      lines = ['my_array = [1, 2,  3, 4, 5, 6]']
      expect(validate.comma_with_space(lines)).to eql(['one space is required after comma. Line No. 1'])
    end
    it 'Returns Array with messages if no space found after comma' do
      validate = StyleError.new
      lines = ['my_array = [1,2,3,4,5,6]']
      expect(validate.comma_with_space(lines)).to eql(['Space After Comma is missing. Line No. 1'])
    end
  end
end
# rubocop:enable Layout/LineLength
