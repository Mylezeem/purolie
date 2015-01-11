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

require 'purolie/modeltreedumper'
require 'purolie/treedumper'
require 'purolie/klass'
require 'puppet/version'
require 'puppet/interface'
require 'puppet/parser'
require 'puppet/face'
require 'puppet/pops'

module Purolie

  class Purolie

    attr_reader :parsed_klasses, :context

    def initialize context
      @original_file = nil
      @parsed_klasses = Array.new
      @to_parse_klasses = Array.new
      @parser = Puppet::Pops::Parser::Parser.new
      @dumper = ModelTreeDumper.new
      @context = context
    end

    def bootstrap file
      @original_file = file
      first_class = @dumper.dump(@parser.parse_file file)
      @to_parse_klasses.push first_class[1]
      parse_tree @to_parse_klasses
    end

    def klass_path klass
      return @original_file if @parsed_klasses.empty?
      tokens = klass.gsub(/'/, '').split("::")
      if tokens.size > 1
        file_path = "#{@context.path}/#{tokens[0]}/manifests/#{tokens[1..-1].join("/")}.pp"
      else
        file_path = "#{@context.path}/#{tokens[0]}/manifests/init.pp"
      end
    end

    def display_params
       output = String.new
       @parsed_klasses.each do |klass|
         if (@context.mandatory and klass.contains_mandatory?) or !@context.mandatory
           if @context.format.downcase == 'json'
             output = output + klass.to_json.join("")
           else
             output = output + klass.to_yaml.join("")
           end
         end
       end
       if @context.format.downcase == 'json'
         puts "{\n#{output[0..-3]}\n}"
       else
         puts "---\n#{output}"
       end
    end

    # TODO (spredzy): Put in a Util class
    def sanitize_include_klass klass
      if klass.gsub(/'/, '').start_with? "::"
        klass.gsub(/'/, '')[2..-1]
      else
        klass.gsub(/'/, '')
      end
    end

    def parse_tree klass_list
      return nil if klass_list.empty?
      begin
        klass_file = klass_path(sanitize_include_klass klass_list.shift)
        klass_dump = @dumper.dump(@parser.parse_file klass_file)
        cur_klass = Klass.new klass_dump
        @parsed_klasses.push cur_klass
        update_to_parse_klasses cur_klass.include_klasses
        parse_tree(@to_parse_klasses)
      rescue Exception => e
        STDERR.puts "Could not load puppet class: #{klass_file}"
        exit 1
      end
    end

    def update_to_parse_klasses klass_list
      parsed_klass_name = @parsed_klasses.collect do |klass|
        klass.name
      end
      @to_parse_klasses.concat (klass_list - parsed_klass_name)
    end

  end

end
