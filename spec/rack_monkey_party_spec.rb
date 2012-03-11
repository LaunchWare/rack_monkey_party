require 'spec_helper'

describe MonkeyParty, :vcr do
  it "retains a key value pair of lists" do
    MonkeyParty.list_map.should_not eql({})
    MonkeyParty.list_map.keys.should include("testing")
  end

  let(:new_list_name) { "some_list" }

  it "allows for the setting of a list name" do
    retain_old_list do
      MonkeyParty.list_name = new_list_name
      MonkeyParty.list_name.should eql(new_list_name)
    end
  end

  describe "the list" do
    it "raises an exception if the list is not found" do
      retain_old_list do
        MonkeyParty.list_name = "something nonexistant"
        lambda { MonkeyParty.list }.should raise_error(MonkeyParty::ListNotFound)
      end
    end

    it "raises an exception if the list is nil" do
      retain_old_list do
        MonkeyParty.stubs(:list_name).returns(nil)
        lambda { MonkeyParty.list }.should raise_error(MonkeyParty::ListNotSet)
      end
    end
    it "returns a monkey party list" do
      retain_old_list do
        MonkeyParty.list_name = 'testing'
        MonkeyParty.list.should be_kind_of(MonkeyParty::List)
      end
    end
  end

  def retain_old_list(&block)
    old_list = MonkeyParty.list_name.nil? ? nil : MonkeyParty.list_name.dup
    yield
    MonkeyParty.list_name = old_list
  end
end

