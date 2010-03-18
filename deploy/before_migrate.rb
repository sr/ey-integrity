user = node["users"].first["username"]
sudo "gem cleanup bundler"
run "cd #{release_path} && /usr/bin/env HOME=/home/#{user} bundle install --relock"
