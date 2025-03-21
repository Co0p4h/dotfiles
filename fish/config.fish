## colors
set -l foreground e0def4
set -l selectio  c4a7e7
set -l comment 908caa
set -l red eb6f92
set -l orange f6c177
set -l yellow ebbcba
set -l green 9ece6a
set -l purple c4a7e7
set -l cyan 9ccfd8
set -l pink ecaff2

# syntax highlighting colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# completion pager colors
set -g fish_pager_color_progress $gray
set -g fish_pager_color_prefix $mauve
set -g fish_pager_color_completion $peach
set -g fish_pager_color_description $gray

set -g man_blink -o $teal
set -g man_bold -o $pink
set -g man_standout -b $gray
set -g man_underline -u $blue

# default text editor
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

# set go path 
set -x GOPATH $HOME/.go

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# function show_random_image_iterm2
  # set image_dir /Users/coopa/t7/images/anime/
  # set images (ls $image_dir/*.{png,jpg,jpeg})
  # set num_images (count $images)
  # set random_index (math (random % $num_images))
  # set image_path $images[$random_index + 1]
#
  # if test -f "$image_path"
    # printf "\e]1337;File=inline=1;width=auto;height=auto;preserveAspectRatio=1;:%s\a" (base64 < $image_path)
  # else
    # echo "No image found in the directory."
  # end
# end

function show_image
  set image_path /Users/coopa/t7/images/random/fish-cat.jpg
  # iterm2
  printf "\e]1337;File=inline=1;width=400px;height=auto;preserveAspectRatio=1;:%s\a" (base64 < $image_path)
  # kitty terminal
  # kitty +kitten icat $image_path
end

function fish_greeting
  echo "おかえりなさい、"$USER"様！"
  # show_image
end

alias vim=nvim

if status is-interactive
  # commands to run in interactive sessions can go here
  starship init fish | source
end
