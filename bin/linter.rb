#!/usr/bin/env ruby
require_relative '../lib/file_validation.rb'
require_relative '../lib/style_error.rb'
puts 'Welcome to Linter'
file_validation = false
while file_validation == false
  print 'Please Enter the address of your file: '
  file = gets.chomp
  if file.empty?
    puts 'Empty address! Please Provide a valid address. '
  else
    file_validate = FileValidation.new
    validation = file_validate.file_exist(file)
    if !validation == true
      puts 'File not found Or Wrong format of file. PLease select .rb file'
      puts "Your file address is : #{file}"
    else
      puts 'File Loaded'
      file_validation = true
    end
  end
end

lines = []
file = File.open(file, 'r')
while (line = file.gets)
  lines << line
end
p lines
validate = StyleError.new
method_validate = validate.space_between_method_parenthesis(lines)
method_validate.each { |x| puts x } unless method_validate.empty?
comma_validate = validate.comma_with_space(lines)
comma_validate.each { |x| puts x } unless comma_validate.empty?
indentation_validate = validate.indentation(lines)
indentation_validate.each { |x| puts x } unless indentation_validate.empty?
puts 'Great Job! No Error Founds.' if method_validate.empty? && comma_validate.empty? && indentation_validate.empty?
file.close
