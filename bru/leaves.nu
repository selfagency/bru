# List installed formulae that are not dependencies of another installed formula or cask.
# Usage: bru leaves
export def main [] {
  let on_request = (
      brew leaves --installed-on-request
        | lines
        | parse "{name}"
        | insert "type" "on request"
    )


  let as_dependency = (
      brew leaves --installed-as-dependency
        | lines
        | parse "{name}"
        | insert "type" "as dependency"
    )

  return ($on_request | merge ($as_dependency)) | sort
}
