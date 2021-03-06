# Copyright:: Copyright (c) 2013, 2015 Megam Systems
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Megam
  class Event < Megam::ServerAPI
    def initialize(email=nil, api_key=nil, host=nil)
      @a_id = nil
      @a_name = nil
      @command = nil
      @launch_type = nil
      super(email, api_key, host)
    end

    def event
      self
    end

    
    def a_id(arg=nil)
      if arg != nil
        @a_id = arg
      else
      @a_id
      end
    end

   
    def a_name(arg=nil)
      if arg != nil
        @a_name = arg
      else
      @a_name
      end
    end

   

    
    def command(arg=nil)
      if arg != nil
        @command = arg
      else
      @command
      end
    end

    def launch_type(arg=nil)
      if arg != nil
        @launch_type = arg
      else
      @launch_type
      end
    end

    def error?
      crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["a_id"] = a_id
      index_hash["a_name"] = a_name
      index_hash["command"] = command
      index_hash["launch_type"] = launch_type
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = {
        "a_id" => a_id,
        "a_name" => a_name,
        "command" => command,
        "launch_type" => launch_type
        }
      result
    end

    def self.json_create(o)
      event = new
      event.a_id(o["a_id"]) if o.has_key?("a_id")
      event.a_name(o["a_name"]) if o.has_key?("a_name")
      event.command(o["command"]) if o.has_key?("command")
      event.launch_type(o["launch_type"]) if o.has_key?("launch_type") #this will be an array? can hash store array?
      event
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      event = self.new(tmp_email, tmp_api_key, tmp_host)
      event.from_hash(o)
      event
    end

    def from_hash(o)
      @a_id                = o[:a_id] if o.has_key?(:a_id)
      @a_name              = o[:a_name] if o.has_key?(:a_name)
      @command      = o[:command] if o.has_key?(:command)
      @launch_type        = o[:launch_type] if o.has_key?(:launch_type)
      
     self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)     
      event = from_hash(o, tmp_email, tmp_api_key, tmp_host)
      event.create
    end

    # Create the node via the REST API
    def create
      megam_rest.post_event(to_hash)
    end

   

    def self.list(tmp_email=nil, tmp_api_key=nil, tmp_host=nil, inflated=false)
      event = self.new(tmp_email, tmp_api_key, tmp_host)
      event.megam_rest.get_events
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
