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
require 'purolie/util'
require 'purolie/version'

module Purolie
  class Profile
    include Purolie::Util

    attr_reader :parsed_klasses, :context, :name

    def initialize context
      @name = :nil
      @original_file = context.filepath
      @parsed_klasses = Array.new
      @to_parse_klasses = Array.new
      @parser = Puppet::Pops::Parser::Parser.new
      @dumper = ModelTreeDumper.new
      @context = context
      bootstrap
    end

    def bootstrap
      first_class = @dumper.dump(@parser.parse_file @original_file)
      @name = first_class[1]
      @to_parse_klasses.push @name
      parse_tree @to_parse_klasses
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

    def get_content
      output = String.new
      @parsed_klasses.each do |klass|
        if @context.format.downcase == 'json'
          output = output + klass.to_json(@context.mandatory).join("")
        else
          output = output + klass.to_yaml(@context.mandatory).join("")
        end
      end
      output
    end

    def to_s
      output = get_content
      if @context.format.downcase == 'json'
        output = "{\n#{output[0..-3]}\n}"
      else
        output = "---\n#{output}"
      end
    end

  end
end
