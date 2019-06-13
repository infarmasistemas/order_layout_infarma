require 'fileutils'

module OrderLayoutInfarma
  class FileComposer
    attr_accessor :compose_order, :file_content, :file

    def initialize(compose_order, file_content)
      self.compose_order = compose_order
      self.file = create_file
      self.file_content = file_content
    end

    def create_file_path
      file_path = StringIO.new()
      file_path << "#{compose_order.directory_name}"
      file_path << "/"
      file_path << "#{compose_order.formatted_current_date}"
      file_path << "/"
      file_path << "#{compose_order.cod_client}"
      file_path << "/"
      file_path << "#{compose_order.formatted_current_date}"
      file_path << "#{"%09i" % compose_order.cod_client}"
      file_path << "#{"%04i" % compose_order.num_order}"
      file_path << ".PED"

      file_path_as_string = file_path.string

      file_path_as_string
    end

    def create_file
      check_or_create_folder
      File.new(create_file_path, "w")
    end

    def write_file
      file.puts(file_content)
      file.close
    end

    def check_or_create_folder
      path = "#{compose_order.directory_name}/#{compose_order.formatted_current_date}/#{compose_order.cod_client}"
      FileUtils.mkdir_p(path) unless File.exists?(path)
    end

  end
end
