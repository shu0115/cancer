# 汎用メソッド用クラス
class Utility

  private
  #----------------------#
  # self.replace_message #
  #----------------------#
  # メッセージ置換
  def self.replace_message( args )
    message = args[:message]
    message = message.gsub( "Member was successfully created.", "メンバーの作成が正常に完了しました。" )
    message = message.gsub( "Member was successfully updated.", "メンバーの更新が正常に完了しました。" )
    message = message.gsub( "User was successfully created.", "ユーザ登録が正常に完了しました。" )

    return message
  end
  
  #--------------#
  # self.f_round #
  #--------------#
  # 小数点四捨五入演算
  # (指定された位で四捨五入された値を返す)
  # :precision／四捨五入対象小数点位
  def self.f_round( args )
    precision = "1"
    1.upto( args[:precision] ){ precision += "0" }
    args[:number] = ( args[:number].to_f * precision.to_i ).round / precision.to_f

    return args[:number]
  end

  #------------------------#
  # self.print_request_env #
  #------------------------#
  # 環境変数表示
  def self.print_request_env( request )
    puts ""; puts ""; puts "";
    print "[ request.domain ] : "; p request.domain ;
    print "[ request.remote_ip ] : "; p request.remote_ip ;
    print "[ request.remote_host ] : "; p request.remote_host ;
    print "[ request.host ] : "; p request.host ;
    print "[ request.url ] : "; p request.url ;

    puts ""; puts ""; puts "";

    request.env.each_pair{ |key, value|
      puts "[ #{key} : #{value} ] : "
    }
    puts ""; puts ""; puts "";
  end

end