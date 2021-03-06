require 'spec_helper'

module Spice
  describe Chef do
    describe '.connection' do
      before {  }
      it "returns an instance of Spice::Connection" do
        Spice::Chef.connection.should be_an_instance_of(Spice::Connection)
      end
    end
    
    describe '.clients' do
      let(:clients) { Chef.clients }
      
      before do
        stub_request(:get, "http://localhost:4000/clients").
          to_return(
            :status => 200, 
            :body => '{"testclient":"http://localhost:4000/clients/testclient",
                      "goodclient":"http://localhost:4000/clients/goodclient"}',    
            :headers => {})
      end
      it "should return a list of all clients" do
        clients.length.should == 2
      end
      it "should provide valid client" do
        clients["testclient"].should == "http://localhost:4000/clients/testclient"
      end
    end
    
    describe '.nodes' do
      let(:nodes) { Chef.nodes }
      
      before do
        stub_request(:get, "http://localhost:4000/nodes").
          to_return(
            :status => 200,
            :body => '{"testnode":"http://localhost:4000/nodes/testnode"}',
            :headers => {}
          )
      end
      it "should return a list of all nodes" do
        nodes.length.should == 1
        # nodes.first["testnode"].should == "http://localhost:4000/nodes/testnode"
      end
      it "should provide valid node" do
        nodes["testnode"].should == "http://localhost:4000/nodes/testnode"
      end
    end
    
    describe '.data_bags' do
      let(:data_bags) { Chef.data_bags }
      before do
        stub_request(:get, "http://localhost:4000/data").
          to_return(
            :status => 200,
            :body => '{"testdata":"http://localhost:4000/data/testdata"}',
            :headers => {}
          )
      end
      it "should return a list of all data bags" do
        data_bags.length.should == 1
      end
      it "should provide valid data" do
        data_bags["testdata"].should == "http://localhost:4000/data/testdata"
      end
    end
    
    describe '.roles' do
      let(:roles) { Chef.roles }
      before do
        stub_request(:get, "http://localhost:4000/roles").
          to_return(
            :status => 200,
            :body => '{"testrole":"http://localhost:4000/roles/testrole"}',
            :headers => {}
          )
      end
      it "should return a list of all roles" do
        roles.length.should == 1
      end
      it "should provide valid role" do
        roles["testrole"].should == "http://localhost:4000/roles/testrole"
      end
    end
    
    describe '.cookbooks' do
      let(:cookbooks) { Chef.cookbooks }
      before do
        stub_request(:get, "http://localhost:4000/cookbooks").
          to_return(
            :status => 200,
            :body => '{"testcookbook":"http://localhost:4000/cookbooks/testcookbook"}',
            :headers => {}
          )
      end
      it "should return a list of all cookbooks" do
        cookbooks.length.should == 1
      end
      it "should provide valid cookbook" do
        cookbooks["testcookbook"].should == "http://localhost:4000/cookbooks/testcookbook"
      end
    end
  end
end