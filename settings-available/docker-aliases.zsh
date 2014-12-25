# remote dangling containers
alias docker-clean-containers='docker rm `docker ps -a -f status=exited -q`'
# remove untageed images
alias docker-clean-images='docker rmi $(docker images -f "dangling=true" -q)'
