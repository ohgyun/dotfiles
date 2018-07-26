# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

# init z   https://github.com/rupa/z
. ~/code/z/z.sh

# 직접 설치한 경우(http://ohgyun.com/413)
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi

# 홈브루로 설치한 경우
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Add docker completion
if [[ -f /usr/local/etc/bash_completion.d/docker.bash-completion ]]; then
    source /usr/local/etc/bash_completion.d/docker-compose.bash-completion
    source /usr/local/etc/bash_completion.d/docker-machine.bash-completion
    source /usr/local/etc/bash_completion.d/docker.bash-completion
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# rbenv 실행
if [ -f /usr/local/bin/rbenv ]; then
    eval "$(rbenv init -)"
fi

# Grunt autocomplete
if [[ -f /usr/local/bin/grunt ]]; then
    eval "$(grunt --completion=bash)"
fi
