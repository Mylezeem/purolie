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

require 'purolie/parameter'

module Purolie
  class Klass

    attr_reader :name, :parameters, :include_klasses, :dump

    def initialize klass_dump
      @name = nil
      @parameters = Array.new
      @include_klasses = Array.new
      @dump = klass_dump
      parse klass_dump
    end

    def contains_mandatory?
      mandatory = @parameters.collect do |param|
        param.is_mandatory?
      end
      mandatory.include? true
    end

    def is_include? element
      element.size == 3 and
       element[0].eql? 'invoke' and
        element[1].eql? 'include'
    end

    # TODO (spredzy): Put in a Util class
    def sanitize_include_klass klass
      if klass.gsub(/'/, '').start_with? "::"
        klass.gsub(/'/, '')[2..-1]
      else
        klass.gsub(/'/, '')
      end
    end

    def parse klass_informations
      klass_informations.each_with_index do |information, index|
        case index
        when 0
          # do nothing
        when 1
          @name = information
        else
          case information[0]
          when 'inherits'
            # do nothing
          when 'parameters'
            information.shift
            information.each do |parameter|
              @parameters.push(Parameter.new parameter)
            end 
          when 'block'
            information.each do |element|
              find_inner_include element
            end
          end
        end 
      end
    end

    def find_inner_include element
      if element.is_a? Array and
           element.size == 3 and
             element[0].eql? 'invoke' and
               element[1].eql? 'include'
        @include_klasses.push(sanitize_include_klass element[2])
      elsif element.is_a? Array
          element.each do |inner_element|
            find_inner_include inner_element
          end
      end
    end

    def to_s
#       @name
#      @include_klasses.each do |inklude|
#        puts ">> #{inklude}"
#      end
#      final_parameters = @parameters.collect do |parameter|
#        "#{@name}::#{parameter.key}: #{parameter.value}"
#      end
#      final_parameters
       @parameters[0]
    end

  end
end
