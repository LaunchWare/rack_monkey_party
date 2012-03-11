require "monkey_party"
require "rack"
require "monkey_party/rack"

module MonkeyParty
  class Exception < Exception; end;
  class ListNotFound < Exception; end;
  class ListNotSet < Exception; end;

  def self.list_name=(list_name)
    @list_name = list_name
  end

  def self.list_name
    @list_name
  end

  def self.list
    raise MonkeyParty::ListNotSet if list_name.nil?
    if list_map[list_name.downcase]
      list_map[list_name.downcase]
    else
      raise MonkeyParty::ListNotFound
    end
  end

  def self.list_map
    @list_map ||= account_lists.inject({}) do |map, list|
      map[list.name.downcase] = list
      map
    end
  end

  protected
  def self.account_lists
    MonkeyParty::List.all
  end
end

