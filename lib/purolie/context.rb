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

require 'etc'

module Purolie

  class Context

    attr_reader :sudo, :path, :environment, :mandatory, :format, :filepath

    def initialize options = {}
      @sudo = options[:sudo]
      @format = options[:format]
      @mandatory = options[:mandatory]
      @environment = options[:environment]
      @filepath = options[:filepath]
      @path = detect_path options[:path], options[:sudo]
    end

    def detect_path path, sudo
      if path.nil? and sudo
        '/etc/puppet/modules'
      elsif path.nil? and !sudo
       "#{Etc.getpwuid.dir}/.puppet/modules"
      else
        if path.start_with? '~/'
          "#{Etc.getpwuid.dir}#{path[1..-1]}"
        else
          path
        end
      end
    end

  end

end
