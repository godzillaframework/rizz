module FileSet
    extend self

    def glob(glob_pattern, file_path=nil)
      glob_pattern = File.join(File.dirname(file_path), glob_pattern) if file_path
      file_list = Dir.glob(glob_pattern).sort
      file_list.each{ |file| yield(file) }
      file_list
    end
  
    def glob_require(glob_pattern, file_path=nil)
      glob(glob_pattern, file_path) { |f| require f }
    end
  end