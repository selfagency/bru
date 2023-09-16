<h1 align="center">Welcome to bru 👋</h1>
<p>
  <a href="https://www.npmjs.com/package/bru" target="_blank">
    <img alt="Version" src="https://img.shields.io/npm/v/bru.svg">
  </a>
  <a href="https://opensource.org/license/mit/" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
</p>

> Nushell wrapper for Homebrew

### 🏠 [Homepage](https://github.com/selfagency/bru)

## Install

```sh
cd $nu.default-config-path
git clone git@github.com:selfagency/bru.git
vi config.nu
```

Insert the line:

```sh
use ./bru/bru.nu
```

## Usage

```sh
bru [subcommand] [parameters] [options]
```

## Subcommands

### `config`

Show Homebrew and system configuration info useful for debugging.

**Usage**

`bru config [key]`

**Parameters**

- `key`: The key to show. If not specified, all keys will be shown.

### `deps`

Show dependencies for formula/e. When given multiple formulae, show the intersection of dependencies for each formula. If no formula/e is given, show dependencies for all installed formulae.

**Usage**

`bru deps [formula]`

**Parameters**

- `formula`: Formula/e to show dependencies for

### `deps missing`

Check the given formula/e for missing dependencies. If no formulae are provided, check all kegs.

**Usage**

`bru deps missing [formula]`

**Parameters**

- `formula`: Formula/e to check for missing dependencies

### `deps tree`

Show dependencies for formula/e. When given multiple formulae, show the intersection of dependencies for each formula. If no formula/e is given, show dependencies for all installed formulae.

**Usage**

`bru deps tree [formula]`

**Parameters**

- `formula`: Formula/e to show dependencies for

### `doctor`

Check your system for potential problems.

**Usage**

`bru doctor`

### `info`

Display brief statistics for your Homebrew installation. If a formula or cask is provided, show summary of information about it.

**Usage**

`bru info [formula|cask] [--extended|-e] [--cask|-c]`

**Options**

- `--extended`, `-e`: Display extended info
- `--cask`, `-c`: Display info for cask instead of formula

### `info desc`

Display a formula or cask's name and one-line description.

**Usage**

`bru info desc [formula|cask] [--cask|-c]`

**Options**

- `--cask`, `-c`: Display info for cask instead of formula

### `leaves`

List installed formulae that are not dependencies of another installed formula or cask.

**Usage**

`bru leaves`

### `list`

List all installed formulae and casks.

**Usage**

`brew list [--extended|-e]`

**Options**

- `--extended`, `-e`: Show extended information.

#### `outdated`

List installed casks and formulae that have an updated version available.

**Usage**

`bru outdated`

### `search`

Perform a substring search of cask tokens and formula names for text. If text is flanked by slashes, it is interpreted as a regular expression.

**Usage**

`bru search [terms] [--desc] [--formulae|-f] [--casks|-c]`

**Parameters**

- `terms`: Search terms

**Options**

- `--desc`, `-d`: Search descriptions as well as titles
- `--formulae`, `-f`: Search formulae
- `--casks`, `-c`: Search casks

### `services`

List information about all managed services for the current user (or root).

**Usage**

`bru services`

### `shellenv`

Print export statements.

**Usage**

`bru shellenv`

## `Command not found` hook

```sh
if (not ($env | default false __bru_hooked | get __bru_hooked)) {
    $env.__bru_hooked = true
    $env.config = ($env.config
        | upsert hooks.command_not_found (
            ($env.config.hooks.command_not_found | default [])
                | append {|cmd| bru not-found $cmd}
        )
    )
}
```

## Author

👤 **Daniel Sieradski**

- Website: <https://self.agency>
- GitHub: [@selfagency](https://github.com/selfagency)
- LinkedIn: [@selfagency](https://linkedin.com/in/selfagency)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](https://github.com/selfagency/bru/issues).

## Show your support

Give a ⭐️ if this project helped you!

## 📝 License

Copyright © 2023 [Daniel Sieradski](https://github.com/selfagency).<br />
This project is [MIT](https://opensource.org/license/mit/) licensed.

***
*This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)*
