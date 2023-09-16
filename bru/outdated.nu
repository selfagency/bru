# List installed casks and formulae that have an updated version available.
# Usage: bru outdated
export def main [] {
    let res = (^brew outdated --json --greedy
        | from json)

    let casks = ($res.casks
        | insert pinned_version null
        | insert type 'cask')

    let formulae = ($res.formulae
        | insert type 'formula')
        | reject pinned

    let out = ($casks
        | merge $formulae
        | rename name installed current pinned
        | sort)

    return $out
}
