user = node["users"].first["username"]
sudo "gem cleanup bundler"
run "cd #{release_path} && bundle install --relock"
