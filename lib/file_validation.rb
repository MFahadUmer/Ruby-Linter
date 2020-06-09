class FileValidation
  def file_exist(file)
    return true if File.exist?(file) && File.extname(file) == '.rb'
  end
end
