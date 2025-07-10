# search forumalae
def search-formulae [terms: any] {
    return ([(^brew search --formulae ...$terms), (char newline)]
        | str join
        | str replace (char newline) $" formula(char newline)" -a
    )
}

# search casks
def search-casks [terms: any] {
    return ([(^brew search --casks ...$terms), (char newline)]
        | str join
        | str replace (char newline) $" cask(char newline)" -a
    )
}

# search forumalae descriptions
def search-desc-formulae [terms: any] {
    return ((^brew search --formulae --desc ...$terms --eval-all)
        | str join
        | str replace (char newline) $" formula(char newline)" -a
    )
}

# search casks descriptions
def search-desc-casks [terms: any] {
    return ((^brew search --casks --desc ...$terms --eval-all)
        | str join
        | str replace (char newline) $" cask(char newline)" -a
    )
}

# search all
def search-all [desc: bool, terms: any] {
    mut formulae = null
    mut casks = null

    if ($desc) {
        $formulae = (search-desc-formulae $terms)
        $casks = (search-desc-casks $terms)
    } else {
        $formulae = (search-formulae $terms)
        $casks = (search-casks $terms)
    }

    return ([$formulae, $casks]
        | str join (char newline)
    )
}

# Perform a substring search of cask tokens and formula names for text. If text is flanked by slashes, it is interpreted as a regular expression.
# Usage: bru search [terms] [--desc] [--formulae, -f] [--casks, -c]
# Options:
#   terms: Search terms
#   --desc, -d: Search descriptions as well as titles
#   --formulae, -f: Search formulae
#   --casks, -c: Search casks
export def main [...terms: any, --desc, --formulae (-f), --casks (-c)] {
    mut res: any = null;

    if ($desc and (not $formulae) and (not $casks)) {
        $res = (search-all true $terms)
    } else if ($desc and $formulae and (not $casks)) {
        $res = (search-desc-formulae $terms)
    } else if ($desc and (not $formulae) and $casks) {
        $res = (search-desc-casks $terms)
    } else if ((not $desc) and $formulae and (not $casks)) {
        $res = (search-formulae $terms)
    } else if ((not $desc) and (not $formulae) and $casks) {
        $res = (search-casks $terms)
    } else {
        $res = (search-all false $terms)
    }

    return ($res
        | lines
        | parse "{name} {type}"
        | sort-by name
        | insert description {|r|
            let desc = (^brew desc $r.name --eval-all)
            if ($desc != null) {
                $desc
            } else {
                null
            }
        }
    )
}