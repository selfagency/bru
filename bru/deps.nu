# Show dependencies for formula/e. When given multiple formulae, show the intersection of dependencies for each formula. If no formula/e is given, show dependencies for all installed formulae.
# Usage: bru deps [formula]
# Options:
#   formula: Formula/e to show dependencies for
export def main [formula?: string] {
    mut res = null

    if ($formula != null) {
        $res = (brew deps $formula --include-requirements --topological)

        return (
            $res
            | lines
        )
    } else {
        $res = (brew deps --installed --topological)

        return (
            $res
            | lines
            | parse "{name}: {dependencies}"
            | update dependencies {|e| ($e.dependencies | split row ' ')}
        )
    }
}

# Check the given formula/e for missing dependencies. If no formulae are provided, check all kegs.
# Usage: bru deps missing [formula]
# Options:
#   formula: Formula/e to check for missing dependencies
export def missing [formula: string] {
    return (brew deps $formula --missing
        | lines
        | parse "{name}: {dependencies}"
    )
}

# Show dependencies for formula/e. When given multiple formulae, show the intersection of dependencies for each formula. If no formula/e is given, show dependencies for all installed formulae.
# Usage: bru deps tree [formula]
# Options:
#   formula: Formula/e to show dependencies for
export def tree [formula?: string] {
    mut res = null

    if ($formula != null) {
        $res = (brew deps $formula --include-requirements --topological --tree)
    } else {
        $res = (brew deps --installed --include-requirements --topological --tree)
    }

    return (
        $res
    )
}