class Event < ActiveRecord::Base

  private
  #----------------#
  # self.get_title #
  #----------------#
  # 表示名取得
  def self.get_title( event_id )
#    print "[ event_id ] : "; p event_id ;
    event = self.find( :first, :select => 'title', :conditions => [ "id = :id", { :id => event_id } ] )
    unless event.blank?
      return event.title
    else
      return ""
    end
  end
  
end
