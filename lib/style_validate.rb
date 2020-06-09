class StyleError
  def space_between_method_parenthesis(array)
    error_array = []
    array.each_with_index do |x, index|
      if x.match(/^\s*def\s{1}[\w]*\s{1,}\([\w]*\)/)
        error_array.push("Space found before parenthesis. Line No. #{index + 1}")
      elsif x[x.length - 2] == ' '
        error_array.push("Trailing space at the end. Line No. #{index + 1}")
      end
    end
    error_array
  end

  def comma_with_space(line)
    error_array = []
    line.each_with_index do |x, index|
      (0...x.length).find_all { |y| x[y] == ',' }
      if x.match(/\s+[,]/)
        error_array.push("Space before Comma found. Line No. #{index + 1}")
      elsif x.match(/[,][^\s?]/)
        error_array.push("Space After Comma is missing. Line No. #{index + 1}")
      elsif x.match(/,\s{2,}/)
        error_array.push("one space is required after comma. Line No. #{index + 1}")
      end
    end
    error_array
  end

  def indentation(lines)
    error_array = []
    my_array = ['if', 'def', '{', 'class', 'module', 'unless']
    spaces = 0
    space_hash = { 1 => 0 }
    lines.each_with_index do |x, index|
      if my_array.any? { |y| x.match(/^\s*#{y}/) }
        spaces += 2
        space_hash[index + 2] = spaces
      elsif x.include?('end') || x.include?('}')
        spaces -= 2
        space_hash[index + 1] = spaces
      end
    end
    space_hash.each do |x, y|
      if lines[x - 1].match(/^\s{#{y + 1}}[\w]*/)
        error_array.push("StyleError:Indentation at Line no. #{x}  Indentations required: #{y}")
      end
    end
    error_array
  end
end