vim-header
==========
Easily adds brief author info and license headers

Table of Contents
=================

* [Install](#install)
* [Usage](#usage)
* [Examples](#examples)
* [Commands](#commands)
* [Settings](#settings)
* [Filetypes support](#filetypes-support)

Install
-------
Preferred installation method is
[Pathogen](https://github.com/tpope/vim-pathogen)

```sh
cd ~/.vim/bundle
git clone https://github.com/alpertuna/vim-header
```

Or you can use your own way

Usage
-----
This is a general usage example.
You can add these lines into your `.vimrc`

```vim
let g:header_field_author = 'Your Name'
let g:header_field_author_email = 'your@mail'
map <F4> :AddHeader<CR>
```

Pressing `F4` in normal mode will add a brief author information at the top of
your buffer.

Examples
--------
For example, when you open a file named `start.sh` and press `F4` after above
settings, plugin will add these lines at the top of your buffer

```sh
#!/bin/bash
# File: start.sh
# Author: Your Name <your@mail>
# Date: 13.03.2016
# Last Modified Date: 13.03.2016
# Last Modified By: Your Name <your@mail>
```

or for a file named `index.php`

```php
<?php
/*
 * File: index.php
 * @author: Your Name <your@mail>
 * Date: 13.03.2016
 * Last Modified Date: 13.03.2016
 * Last Modified By: Your Name <your@mail>
 */
```

[⬆ back to top](#table-of-contents)

Commands
--------
Adding Headers

- `:AddHeader` Adds brief author information or updates if exists
- `:AddMinHeader` Adds minified version of author information

Adding Licenses

- `:AddMITLicense` Adds **MIT License**
- `:AddApacheLicense` Adds **Apache License**
- `:AddGNULicense` Adds **GNU GP License v3**
- `:AddAGPLicense` Adds **GNU Affero GP License v3**
- `:AddLGPLLicense` Adds **GNU Lesser GP License**
- `:AddMPLLicense` Adds **Mozilla Public License**
- `:AddWTFPLLicense` Adds **WTFPL License**
- `:AddZlibLicense` Adds **zlib License**

[⬆ back to top](#table-of-contents)

Settings
--------
These settings are for your `$MYVIMRC` (vim: `.vimrc`, neovim:
`.config/nvim/init.vim`)

### Settings List

Settings related to **headers**:

- [`g:header_auto_add_header`](#gheader_auto_add_header)
- [`g:header_auto_update_header`](#gheader_auto_update_header)
- [`g:header_alignment`](#gheader_alignment)
- [`g:header_max_size`](#gheader_max_size)

Settings related to **headers' fields**:

- [`g:header_field_filename`](#gheader_field_filename)
- [`g:header_field_filename_path`](#gheader_field_filename_path)
- [`g:header_field_author`](#gheader_field_author)
- [`g:header_field_author_email`](#gheader_field_author_email)
- [`g:header_field_copyright`](#gheader_field_copyright)
- [`g:header_field_timestamp`](#gheader_field_timestamp)
- [`g:header_field_modified_timestamp`](#gheader_field_modified_timestamp)
- [`g:header_field_modified_by`](#gheader_field_modified_by)
- [`g:header_field_timestamp_format`](#gheader_field_timestamp_format)
- [`g:header_field_license_id`](#gheader_field_license_id)

Settings related to **supported filetypes**:

- [`g:header_cfg_comment_char`](#gheader_cfg_comment_char)

g:header_auto_add_header
------------------------

```vim
let g:header_auto_add_header = 1
```

Toggles automatic headers' addition. **0 by default**.
If enable this feature and there is already header in current file,
this plugin will update it automaically.
But if you only want to update the header, look at the option below.

g:header_auto_update_header
---------------------------

```vim
let g:header_auto_update_header = 1
```
Toggles automatic headers' update. **0 by default**.
Ignore this option if `g:header_auto_add_header` is enabled

g:header_alignment
------------------

```vim
let g:header_alignment = 0
```

Aligns headers' values. **1 by default**.

g:header_max_size
-----------------

```vim
let g:header_max_size = 20
```

Sets the range from which vim-header will search for required headers (ones sets
in global options) to determinate if it should update existing headers or add
new ones.

This options is used to prevent text replacement if your file contains text
matching headers (for instance `File:`). See
[#20](https://github.com/alpertuna/vim-header/issues/20#issuecomment-319127330)
for more explanations. **7 by default**.

g:header_field_filename
-----------------------

```vim
let g:header_field_filename = 0
```

Toggles `File:` header field. **1 by default**.

g:header_field_filename_path
----------------------------

```vim
let g:header_field_filename_path = 1
```

Uses filename instead of full path in `File:` header field. **0 by default**.

g:header_field_author
---------------------

```vim
let g:header_field_author = 'Your Name'
```

Sets defined value for `Author:` and `Last Modified By:` fields. Empty string
disables it. **'' by default**.

g:header_field_author_email
---------------------------

```vim
let g:header_field_author_email = 'your@mail'
```

Adds defined value surrounded by `<`, `>` after author name in `Author:` and
`Last Modified By:` fields. `g:header_field_author` must be set and not be empty
in order to add email to its value. Empty string disables adding email value.
**'' by default**.

g:header_field_copyright
------------------------
```vim
let g:header_field_copyright = ''
```

Adds custom copyright lines. **'' by default**.

g:header_field_timestamp
------------------------

```vim
let g:header_field_timestamp = 0
```

Toggles `Date:` header field. **1 by default**.

g:header_field_modified_timestamp
---------------------------------

```vim
let g:header_field_modified_timestamp = 0
```

Toggles `Last Modified Date:` header field. **1 by default**.

g:header_field_modified_by
--------------------------

```vim
let g:header_field_modified_by = 0
```

Toggles `Last Modified By:` header field. This header value relies on
`g:header_field_author` value. In order to shows up **`g:header_field_author`
must be set and not be empty**. **1 by default**.

g:header_field_timestamp_format
-------------------------------

```vim
let g:header_field_timestamp_format = '%d.%m.%Y'
```

Sets timestamp format. **`%d.%m.%Y` by default**.

g:header_field_license_id
-------------------------------

```vim
let g:header_field_license_id = 'BSD-3-Clause'
```

Sets license field. **'' by default**.

g:header_cfg_comment_char
-------------------------

```vim
let g:header_cfg_comment_char = ';'
```

Sets cfg's filetype comment character as this filetype supports multiple set of
comment characters (`;`, `//`, `#`, ...). **`#` by default**.

[⬆ back to top](#table-of-contents)

Filetypes support
-----------------
Supported filetypes are:
- ada
- arduino
- asm
- c
- cfg
- clojure
- coldfusion(cfc,cfml)
- cpp
- cs
- css
- dart
- dosini
- elixir
- erlang
- go
- groovy
- haskel
- java
- javascript
- jsx
- kotlin
- less
- lex
- lisp
- lua
- make
- markdown
- matlab/octave
- ocaml
- perl
- php
- plaintex
- pug
- proto
- python
- racket
- rst
- ruby
- rust
- sass
- scala
- scheme
- sh
- tcl
- tex
- tmux
- tsx
- vhdl
- verilog
- vim
- xdefaults
- yacc
- yaml
- vimwiki

And licenses are:

- Apache
- EUP
- GNU GPL
- GNU AGPL
- GNU LGPL
- MIT
- MPL
- WTFPL
- zlib

If you want more filetypes or licenses, you can open issues or provide any
improvements by pull requests on
[alpertuna/vim-header](https://github.com/alpertuna/vim-header). Also you can
correct my English on README file or at comments in source code.

### Thanks to Contributors
[Contributors List](https://github.com/alpertuna/vim-header/graphs/contributors)

[⬆ back to top](#table-of-contents)
