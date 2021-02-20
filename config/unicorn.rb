#サーバ上でのアプリケーションコードが設置されているディレクトリを変数に入れておく
#app_path = File.expand_path('../../', __FILE__)
app_path = File.expand_path('../../../', __FILE__)  # 「../」が一つ増えている

#アプリケーションサーバの性能を決定する
#リクエストを受け付けレスポンスを生成するworker(ワーカー)の数を決めます。
worker_processes 1

#アプリケーションの設置されているディレクトリを指定
#UnicornがRailsのコードを動かす際、ルーティングなど実際に参照するファイルを探すディレクトリを指定します。
#working_directory app_path
working_directory "#{app_path}/current"  # 「current」を指定

#Unicornの起動に必要なファイルの設置場所を指定
#Unicornは、起動する際にプロセスidが書かれたファイルを生成します。その場所を指定します
#pid "#{app_path}/tmp/pids/unicorn.pid"
pid "#{app_path}/shared/tmp/pids/unicorn.pid"  # 「shared」の中を参照するよう変更

#ポート番号を指定
#どのポート番号のリクエストを受け付けることにするかを決定します。今回は、3000番ポートを指定しています
#↓listen 3000↓に変更
#listen "#{app_path}/tmp/sockets/unicorn.sock"
listen "#{app_path}/shared/tmp/sockets/unicorn.sock"  # 「shared」の中を参照するよう変更

#エラーのログを記録するファイルを指定
#stderr_path "#{app_path}/log/unicorn.stderr.log"
stderr_path "#{app_path}/shared/log/unicorn.stderr.log"  # 「shared」の中を参照するよう変更

#通常のログを記録するファイルを指定
#stdout_path "#{app_path}/log/unicorn.stdout.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"  # 「shared」の中を参照するよう変更

#Railsアプリケーションの応答を待つ上限時間を設定
timeout 60

#以下は応用的な設定なので説明は割愛

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end


# 「worker」とは、分裂したUnicornの全プロセスのことです。
# プロセスを分裂させることで、リクエストに対してのレスポンスを高速にできます。
# 後述するworker_processesという設定項目で、workerの数を決定します。

# ブラウザなどからリクエストが来ると、
# UnicornのworkerがRailsアプリケーションを動かします。
# Railsは、リクエストの内容とルーティングを照らし合わせ、
# 最終的に適切なビュー(HTML)もしくはJSONをレスポンスします。
# レスポンスを受け取ったUnicornは、
# それをブラウザに返します。
# 一連の動きはおよそ0.1 ~ 0.5秒程度で行われます。
# 常にそれ以上のスピードでリクエストが頻発するようなアプリケーションだと、
# 1つのworkerだけでは処理が追いつかず、
# レスポンスまで長い時間がかかってしまったり最悪サーバがストップしてしまいます。
# そんな時、worker_processesの数を 2,3,4と増やすことで、
# アプリケーションからのレスポンスを早くできます。