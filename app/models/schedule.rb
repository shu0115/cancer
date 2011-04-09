class Schedule < ActiveRecord::Base

  validates_uniqueness_of :schedule_day, :scope => :event_id, :message => 'は既に登録されています。'  # 一意検証

  private
  #--------------------------#
  # self.search_schedule_day #
  #--------------------------#
  # 予定日検索
  def self.search_schedule_day( args )
    self.find_by_event_id_and_schedule_day( args[:event_id], args[:schedule_day] )
  end

  #--------------------------#
  # self.schedule_day_format #
  #--------------------------#
  # 予定日整形
  def self.schedule_day_format( schedule_day )
    unless schedule_day.blank?
      return "#{schedule_day.strftime("%m/%d")}(#{$day_week[schedule_day.strftime("%w")]})"
    else
      return ""
    end
  end

  #-------------------#
  # self.attend_count #
  #-------------------#
  # 参加者予定カウント
  def self.attend_count( event_id )
    search = Hash.new
    search[:event_id] = event_id
    entries = Entry.all( :conditions => search, :select => "DISTINCT schedule_day" )
    entry_count = Entry.count( :conditions => search, :select => "DISTINCT user_id" )

    count_hash = Hash.new{ | hash, key | hash[key] = Hash.new }

    entries.each{ |entry|
      search[:schedule_day] = entry.schedule_day

      # 参加数
      count_hash[entry.schedule_day][:circle] = Entry.count( :conditions => [ "attend = '○' AND event_id = :event_id AND schedule_day = :schedule_day", search ] )
      count_hash[entry.schedule_day][:triangle] = Entry.count( :conditions => [ "attend = '△' AND event_id = :event_id AND schedule_day = :schedule_day", search ] )
      count_hash[entry.schedule_day][:bad] = Entry.count( :conditions => [ "attend = '×' AND event_id = :event_id AND schedule_day = :schedule_day", search ] )

      # 参加率
      count_hash[entry.schedule_day][:circle_rate] = count_hash[entry.schedule_day][:circle].to_f / entry_count.to_f
      count_hash[entry.schedule_day][:triangle_rate] = count_hash[entry.schedule_day][:triangle].to_f / entry_count.to_f
      count_hash[entry.schedule_day][:bad_rate] = count_hash[entry.schedule_day][:bad].to_f / entry_count.to_f
    }

    return count_hash
  end

end
