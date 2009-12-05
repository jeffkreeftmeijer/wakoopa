require 'rubygems'
require 'httparty'

module Wakoopa
  class << self
    attr_accessor :username, :feedkey
  end
  
  # Wakoopa::Base
  #
  # Will be extended by Wakoopa::Software, Wakoopa::Comment, Wakoopa::PlacedComment,
  # Wakoopa::Review, Wakoopa::Relation and Wakoopa::Team to add the @section variable.
  
  class Base
    attr_accessor :data
    
    # Wakoopa::Base#initialize(Hash)
    #
    # Creates a new Wakoopa::Base object with the data provided. 
    #
    # Example:
    #   Wakoopa::Software.new({:name => 'Firefox'})
    
    
    def initialize(item)
      @data = item
    end           
    
    # Wakoopa::Base#method_missing(Symbol, *)
    #
    # Catches missing methods and try to return a value from the @data object.
    #
    # Example:
    #   software = Wakoopa::Software.new({:name => 'Firefox})
    #   software.name # => 'Firefox'
    
    def method_missing(method_id, *args)
      @data[method_id.to_s]
    end
     
    class << self
      attr_accessor :section
      
      # Wakoopa::Base#self.find(*)
      #
      # Delegates find commands to the find... methods. The Wakoopa API only supports
      # fetching multiple rows, you can't find anything by id. This means this method
      # will always call Wakoopa::Base#self.find_every() and throw a warning when its
      # being called with anything else then ":all" as it's first parameter.
      #
      # Example:
      #
      #   software = Wakoopa::Software.find(:all) # => Array
      #   software = Wakoopa::Software.find()     # => throws a warning, Array
      
      def find(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        warn "The Wakoopa API doesn\'t support finding single rows. \n Please use \".all()\" or \"s.find(:all)\" instead of \".find()\"." unless args.first == :all
        find_every(options)
      end
      
      # Wakoopa::Base#self.find_every(Hash/nil)
      #
      # Creates an arguments hash and calls Wakoopa::Request.get(). Will check if the
      # user has provided a feedkey (using Wakoopa.feedkey=()). If so, it'll put it 
      # into the arguments Hash.
      #
      # Example
      #   software = Wakoopa::Software.find_every # => Array
      
      def find_every(options = {})
        query = {:limit => 100}.merge(options)
            
        feedkey = Wakoopa.feedkey
        if feedkey
          query.merge!(:key => feedkey)
        end
                
        Wakoopa::Request.get(@section, :query => query)
      end
      
      # Wakoopa::Base#self.all(*)
      #
      # Calls find(:all, *) directly. This method is only here for convenience.
      #
      # Example
      #   software = Wakoopa::Software.all # => Array
      
      def all(*args)
        find(:all, *args)
      end                                      
      
      # Wakoopa::Base#self.method_missing(Symbol, *)
      #
      # Catches missing methods and checks for find_all_by... calls. If it finds any,
      # It'll call find(:all) directly, passing the arguments it pulled from the
      # method_id and the supplied arguments.
      #
      # Example:
      #
      #   software = Wakoopa::Software.find_all_by_name('Firefox') # => Array
      
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
  
  # Wakoopa::Request
  #
  # Handles requests sent to the Wakoopa API
  
  class Request
    class << self
      
      # Wakoopa::Request#self.get(String, Hash)
      #
      # Passes the section and the options directly to HTTParty.get and an array of 
      # Wakoopa::Base objects will be returned.
      #
      # Example:
      #
      #   software = Wakoopa::Request.get('software', {:name => 'Firefox'}) # => Array
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
  
  # Wakoopa::Software
  #
  # Extends Wakoopa::Base and passes 'software' as a @section variable
  class Software < Base
    @section = 'software'
  end
  
  # Wakoopa::Comment
  #
  # Extends Wakoopa::Base and passes 'comments' as a @section variable  
  class Comment < Base
    @section = 'comments'
  end
  
  # Wakoopa::PlacedComment
  #
  # Extends Wakoopa::Base and passes 'placed_comments' as a @section variable
  class PlacedComment < Base
    @section = 'placed_comments'
  end
  
  # Wakoopa::Review
  #
  # Extends Wakoopa::Base and passes 'reviews' as a @section variable
  class Review < Base
    @section = 'reviews'
  end
    
  # Wakoopa::Relation
  #
  # Extends Wakoopa::Base and passes 'relations' as a @section variable
  class Relation < Base
    @section = 'relations'
  end
  
  # Wakoopa::Team
  #
  # Extends Wakoopa::Base and passes 'teams' as a @section variable
  class Team < Base
    @section = 'teams'
  end   
end
