require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Wakoopa' do
  before do
    Wakoopa.username = 'jkreeftmeijer'
  end
  
  it 'should set the feedkey' do
    Wakoopa.feedkey = '12345'
    Wakoopa.feedkey.should eql('12345')
  end 
  
  describe 'Base' do
    describe '.new' do
      before do
        @item = Wakoopa::Base.new({'woo' => 'grr'})
      end
      
      it 'should have a data array' do
        @item.data['woo'].should eql('grr')
      end
      
      it 'should be able to use magic attrubutes' do
        @item.woo.should eql('grr')
      end          
    end
    
    describe '.find' do
      it 'should always call ".find_every()"' do
        Wakoopa::Base.should_receive(:find_every)
        Wakoopa::Base.find   
      end 
      
      it 'should pass the given options' do
        Wakoopa::Base.should_receive(:find_every).with({:woo => 'bleh'})
        Wakoopa::Base.find(:all, {:woo => 'bleh'})
      end
    end  
    
    describe '.all' do
      it 'should call ".find(:all)"' do
        Wakoopa::Base.should_receive(:find).with(:all)
        Wakoopa::Base.all
      end
      
      it 'should pass the given options' do
        Wakoopa::Base.should_receive(:find).with(:all, {:woo => 'bleh'})
        Wakoopa::Base.all({:woo => 'bleh'})
      end
    end
    
    describe '.find_every' do
      before do
        Wakoopa::Base.section =  'test'
        Wakoopa.feedkey = nil 
      end
      
      it 'should create a request without any arguments' do
        Wakoopa::Request.should_receive(:get).with('test', :query => {:limit => 100})
        Wakoopa::Base.find_every
      end
      
      it 'should create a request with the feedkey provided' do
        Wakoopa::Request.should_receive(:get).with('test', :query => {:key => '12345', :limit => 100})
        Wakoopa.feedkey = '12345'
        Wakoopa::Base.find_every
      end
      
      it 'should create a request with the category condition' do
        Wakoopa::Request.should_receive(:get).with('test', :query => {:category => 'browsers', :limit => 100})       
        Wakoopa::Base.find_every(:category => 'browsers')
      end
    end
    
    describe '.find_all_by_magic' do
      it 'should create a request with the category condition' do
        Wakoopa::Request.should_receive(:get).with('test', :query => {:category => 'browsers', :limit => 100})       
        Wakoopa::Base.find_all_by_category('browsers')
      end
      
      it 'should create a request with the category and os condition' do
        Wakoopa::Request.should_receive(:get).with('test', :query => {:category => 'browsers', :os => 'osx', :limit => 100})       
        Wakoopa::Base.find_all_by_category_and_os('browsers', 'osx')
      end
      
      it 'should create a request with the category condition, sorted by active_seconds' do
        Wakoopa::Request.should_receive(:get).with('test', :query => {:category => 'browsers', :sort => 'active_seconds', :limit => 100})
        Wakoopa::Base.find_all_by_category('browsers', :sort => 'active_seconds')
      end
    end
  end
  
  describe 'Request', '.get' do
    before do
      HTTParty.should_receive(:get).
        with('http://api.wakoopa.com/jkreeftmeijer/software.xml', {}).
        and_return(
          Crack::XML.parse(
            File.read('spec/fixtures/jkreeftmeijer_software.xml')
          )
        )
    end
    
    it 'should return an array of software objects' do
      result = Wakoopa::Request.get('software')
      result.should be_instance_of Array
      result.each do |object|
        object.should be_instance_of Wakoopa::Software
      end
    end
    
    it 'should return 10 software objects' do
      result = Wakoopa::Request.get('software')
      result.length.should eql 10
    end
  end
  
  describe 'Software', '.find' do
    it 'create a "software" request' do
      Wakoopa::Request.should_receive(:get).with('software', {:query => { :limit => 100 }})
      Wakoopa::Software.find(:all)
    end
  end
  
  describe 'Comment', '.find' do
    it 'create a "comments" request' do
      Wakoopa::Request.should_receive(:get).with('comments', {:query => { :limit => 100 }})
      Wakoopa::Comment.find(:all)
    end
  end
  
  describe 'PlacedComment', '.find' do
    it 'create a "placed_comments" request' do
      Wakoopa::Request.should_receive(:get).with('placed_comments', {:query => { :limit => 100 }})
      Wakoopa::PlacedComment.find(:all)
    end
  end
  
  describe 'Review', '.find' do
    it 'create a "reviews" request' do
      Wakoopa::Request.should_receive(:get).with('reviews', {:query => { :limit => 100 }})
      Wakoopa::Review.find(:all)
    end
  end
  
  describe 'Relation', '.find' do
    it 'create a "relations" request' do
      Wakoopa::Request.should_receive(:get).with('relations', {:query => { :limit => 100 }})
      Wakoopa::Relation.find(:all)
    end
  end
  
  describe 'Team', '.find' do
    it 'create a "teams" request' do
      Wakoopa::Request.should_receive(:get).with('teams', {:query => { :limit => 100 }})
      Wakoopa::Team.find(:all)
    end
  end
end
