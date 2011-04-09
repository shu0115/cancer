# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :authorize

  PER_PAGE = 15
  $entry_attend = [ "-", "○", "△", "×" ]
  $day_week = { "0" => "日", "1" => "月", "2" => "火", "3" => "水", "4" => "木", "5" => "金", "6" => "土" }
  $mode = { "public" => "公開", "private" => "非公開", "protect" => "保護" }

  private
  #-----------#
  # authorize #
  #-----------#
  def authorize
    # ログイン制限 除外リスト
    except_hash = Hash.new{ | hash, key | hash[key] = Hash.new }
    except_hash["entry"]["login"] = "EXCEPT"
    except_hash["entry"]["input"] = "EXCEPT"
    except_hash["entry"]["confirmation"] = "EXCEPT"
    except_hash["entry"]["complete"] = "EXCEPT"
    
    unless except_hash[params[:controller]][params[:action]].blank?
      return
    else
      user = User.find_by_id( session[:user_id] )
      if user.blank?
#        print "[ request.url ] : "; p request.url ;
        session[:request_url] = request.url
        flash[:login_notice] = "ログインが必要です。<br /><br />"
        redirect_to :controller => "entry", :action => "login" and return
      end
    end
  end

end
