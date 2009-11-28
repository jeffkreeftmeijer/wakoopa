require 'rubygems'
require 'httparty'

module Wakoopa
  class << self
    attr_accessor :username, :feedkey
  end
  
  class Base
    attr_accessor :data
    
    def initialize(item)
      @data = item
    end           
    
    def method_missing(method_id, *args)
      @data[method_id.to_s]
    end
     
    class << self
      attr_accessor :section
      
      def find(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        warn "The Wakoopa API doesn\'t support finding single rows. \n Please use \".all()\" or \"s.find(:all)\" instead of \".find()\"." unless args.first == :all
        find_every(options)
      end
      
      def find_every(options = {})
        query = {:limit => 100}.merge(options)
            
        feedkey = Wakoopa.feedkey
        if feedkey
          query.merge!(:key => feedkey)
        end
                
        Wakoopa::Request.get(@section, :query => query)
      end
      
      def all(*args)
        find(:all, *args)
      end                                      
      
      def method_missing(method_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        
        method_id.to_s.match(/^find_all_by_([_a-zA-Z]\w*)$/)
        attributes = {}

        $1.split('_and_').each do |key|
          attributes.merge!({key.intern => args.shift})
        end
       
        find(:all, attributes.merge(options))
      end
    end
  end
  
  class Request
    class << self
      def get(section, options={})                                                                  
        response = HTTParty.get("http://api.wakoopa.com/#{Wakoopa.username}/#{section}.xml", options)
                               
        result = []
        response[section].each do |item|
          result << (Software.new(item))
        end
        result
      end
    end    
  end
  
  class Software < Base
    @section = 'software'
  end
    
  class Comment < Base
    @section = 'comments'
  end
  
  class PlacedComment < Base
    @section = 'placed_comments'
  end
  
  class Review < Base
    @section = 'reviews'
  end
    
  class Relation < Base
    @section = 'relations'
  end
  
  class Team < Base
    @section = 'teams'
  end   
end