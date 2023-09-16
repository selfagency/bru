# `command_not_found` hook
export def main [cmd: string] {
    if (
        ($cmd | str contains '-h') or
        ($cmd | str contains '--help') or
        ($cmd | str contains '--usage') or
        ($cmd | str contains '-?')
    ) {
        return null
    } else {
        return (^brew which-formula --explain $cmd)
    }
}
