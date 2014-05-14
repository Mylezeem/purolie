require 'purolie/parser'

module Purolie

  class Inspector
    @@main_array = Array.new

    def inspect (root_filepath_to_inspect)
      file_to_inspect = File.read(root_filepath_to_inspect)
      file_to_inspect.chomp!
      puts "#{file_to_inspect}"
      parser = Purolie::Parser.new
      result = parser.parse(file_to_inspect)
      puts result
      #@@main_array.push result
      
      #result['includes'].each do |class_to_include|

      #  base_path = '/home/yguenane/github/purolie/environments/spredzy/modules/'
      #  puppet_module, puppet_class = result['class_name'].split "::"
      #  if class_to_include.start_with? "::"
      #    puppet_module = class_to_include.split("::")[1]
      #    _class_to_include = class_to_include[2..-1]
      #  else
      #    _class_to_include = class_to_include
      #  end
      #  _class_to_include.gsub!("::", "/")
      #  if _class_to_include.include? "/"
      #    class_to_parse = "#{_class_to_include}.pp"
      #  else
      #    class_to_parse = 'init.pp'
      #  end
      #  class_to_parse.slice! puppet_module if class_to_parse.start_with?("#{puppet_module}/")

      #  path = "#{base_path}#{puppet_module}/manifests/#{class_to_parse}"
      #  return self.inspect path
      #end
      
     #return self.inspect('/home/yguenane/github/purolie/environments/spredzy/modules/', )
    end
  end

end
