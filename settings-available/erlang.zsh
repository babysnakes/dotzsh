test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

erlang_dir="$HOME/.local/erlang/"
elixir_13="1.3.3"
elixir_12="1.2.4"

function use-erlang-elixir() {
    erlang_ver=$1
    elixir_ver=$2
    if [ -z "$erlang_ver" -o -z "$elixir_ver" ]; then
        echo "Error seting erlang and elixir version: missing erlang or elixir version!"
    fi
    whence kerl_deactivate >/dev/null && kerl_deactivate
    source $erlang_dir/$erlang_ver/activate
    kiex use $elixir_ver >/dev/null
}

function use-elixir-13() {
    use-erlang-elixir r19 $elixir_13
}

function use-elixir-12() {
    use-erlang-elixir r18 $elixir_12
}

use-elixir-13
