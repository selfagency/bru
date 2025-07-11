# List all installed formulae and casks.
# Usage: brew list [--extended (-e)]
# Options:
#   --extended (-e)  Show extended information.
export def main [--extended (-e)] {
    let res = (^brew info --installed --json=v2 | from json)

    let casks = ($res.casks
        | upsert full_name { |r| $r.name }
        | upsert name { |r| $r.token }
        | insert license null
        | insert pinned false
        | reject token)

    let formulae = $res.formulae

    mut output = ($formulae
        | merge $casks
        | upsert type { |r| if 'token' in $r { 'cask' } else { 'formula' } }
        | where { |r| $r.installed != null }
        | update installed { |r|
            if (($r.installed | describe) != 'string') {
                $r.installed | first | get version
            } else {
                $r.installed
            }
        }
        | sort)

    if (not $extended) {
        $output = ($output
            | select name desc homepage license type installed pinned outdated
            | rename name description homepage license type version pinned outdated
        )
    }
    return $output
}
