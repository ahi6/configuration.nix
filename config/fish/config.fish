zoxide init fish | source
nix-your-shell fish | source
export PATH="/home/ahi/.local/bin:$PATH"

function fish_right_prompt
  set -l prevstatus $status
  if string match -qr '(python|ghci)' -- $history[1]
    mommy -1 -s $prevstatus
  end
end
