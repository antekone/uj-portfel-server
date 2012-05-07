root = "ROOT_PATH"
working_directory root
pid "#{root}/tmp/pids/unicorn.wallet.pid"
stderr_path "#{root}/log/unicorn.wallet.log"
stdout_path "#{root}/log/unicorn.wallet.log"

listen "/tmp/wallet.sock"
worker_processes 1
timeout 30
