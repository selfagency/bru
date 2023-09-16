# Check your system for potential problems.
# Usage: bru doctor
export def main [] {
  try {
    let tmp_file = $"/tmp/bru.doctor.(random chars -l 20)"
    let cmd = $"brew doctor > ($tmp_file) 2>&1;"
    (sh -c $cmd)
    let items = (open $tmp_file
        | split row \n\n --regex
        | skip 1 | parse '{status}: {message}'
    )
    (rm $tmp_file)
    return $items
  } catch {|err|
    log debug $err
  }
}