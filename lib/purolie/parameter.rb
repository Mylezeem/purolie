##
## Copyright (C) 2015 Yanis Guenane <yguenane@gmail.com>
##
## Author: Yanis Guenane <yguenane@gmail.com>
##
## Licensed under the Apache License, Version 2.0 (the "License"); you may
## not use this file except in compliance with the License. You may obtain
## a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
## WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
## License for the specific language governing permissions and limitations
## under the License.

module Purolie

  class Parameter

    attr_reader :key, :value

    def initialize parameter
      @key = nil
      @value = nil
      parse parameter
    end

    def is_mandatory?
      @value.nil?
    end

    def parse_parameter parameter
      case parameter
      when String
        parameter
      when Array
        type = parameter.shift
        if type == '[]'
          parameter.collect do |elt|
            elt.tr("'", '')
          end
        elsif type == '{}'
          hash = Hash.new
          parameter.each do |elt|
            hash[elt[0].tr("'", '')] = elt[1].tr("'", '')
          end
          hash
        end
      end
    end

    def parse parameter
      case parameter
      when Array
        @key = parameter[1]
        @value = parse_parameter(parameter[2])
      when String
        @key = parameter
      end
    end

  end

end
