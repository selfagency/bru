# List information about all managed services for the current user (or root).
# Usage: bru services
export def main [subcommand: string, service?: string] {
    if ($subcommand == 'list' or $subcommand == 'ls' or $subcommand == null) {
        let services = (^brew services list --json)
            | from json
            | sort-by name
            | update status {|r|
                if ($r.status == 'none') {
                    'stopped'
                } else {
                    $r.status
                }
            }
        return $services
    } else {
        return (^brew services $subcommand $service)
    }
}
