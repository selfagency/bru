use std log

# completions
# services
# shellenv
# tap
# tap-info
# uninstall
# unlink
# unpin
# untap
# update
# update-report
# update-reset
# upgrade
# uses
# vendor-install
# which-formula
# which-update

export use not-found.nu
export use config.nu
export use deps.nu
export use doctor.nu
export use info.nu *
export use leaves.nu
export use list.nu
export use outdated.nu
export use search.nu
export use services.nu
export use shellenv.nu

export alias ls = list

export def main [
    ...args: any
] {
    # flags
    # --cache,
    # --caskroom,
    # --cellar,
    # --env,
    # --prefix,
    # --repository,
    # --version,
    # --debug (-d),
    # --quiet (-q),
    # --verbose (-v),
    # --help (-h)

    return (^brew $args)
}

export-env {
    let prefix = (^brew --prefix)

    $env.PATH = ($env.PATH
        | prepend $"($prefix)/sbin"
        | prepend $"($prefix)/bin"
    )

    $env.HOMEBREW_PREFIX = $prefix
    $env.HOMEBREW_CELLAR = $"($prefix)/Cellar"
    $env.HOMEBREW_REPOSITORY = $prefix

    if ('MANPATH' not-in $env) {
        $env.MANPATH = [$"($prefix)/share/man"]
    } else {
        $env.MANPATH | append $"($prefix)/share/man"
    }

    if ('INFOPATH' not-in $env) {
        $env.INFOPATH = [$"($prefix)/share/info"]
    } else {
        $env.INFOPATH | append $"($prefix)/share/info"
    }

    # if (not ($env | default false __brew_hooked | get __brew_hooked)) {
    #     $env.__brew_hooked = true
    #     $env.config = ($env.config | upsert hooks.command_not_found (($env.config.hooks.command_not_found | default [])| append {|cmd|
    #         bru not-found $cmd
    #     }))
    # }
}
