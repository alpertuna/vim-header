" PROPERTIES AND FUNCTIONS FOR GENERAL PURPOSES
" ---------------------------------------------
" Set default global values
if !exists('g:header_field_project')
    let g:header_field_project = ''
endif
if !exists('g:header_field_last_separator')
    let g:header_field_last_separator = 0
endif
if !exists('g:header_field_copyright')
    let g:header_field_copyright = ''
endif
if !exists('g:header_field_filename')
    let g:header_field_filename = 1
endif
if !exists('g:header_field_filename_path')
    let g:header_field_filename_path = 0
endif
if !exists('g:header_field_license_id')
    let g:header_field_license_id = ''
endif
if !exists('g:header_field_author')
    let g:header_field_author = ''
endif
if !exists('g:header_field_author_email')
    let g:header_field_author_email = ''
endif
if !exists('g:header_field_timestamp')
    let g:header_field_timestamp = 1
endif
if !exists('g:header_field_modified_timestamp')
    let g:header_field_modified_timestamp = 1
endif
if !exists('g:header_field_modified_by')
    let g:header_field_modified_by = 1
endif
if !exists('g:header_field_timestamp_format')
    let g:header_field_timestamp_format = '%d.%m.%Y'
endif
if !exists('g:header_cfg_comment_char')
    let g:header_cfg_comment_char = '#'
endif
if !exists('g:header_max_size')
    let g:header_max_size = 7
endif
if !exists('g:header_alignment')
    let g:header_alignment = 1
endif

" Path for license files directory
let s:license_files_dir = expand('<sfile>:p:h:h').'/licensefiles/'

" Sets values respect to buffer's filetype
fun s:set_props()
    " Variables for General Purposes
    let b:filetype = &ft
    let b:is_filetype_available = 1 " To check if filetype comment syntax is defined

    " Default Values for Many Languages
    let b:first_line = '' " If file type has initial line
    let b:first_line_pattern = ''
    let b:encoding = ''   " encoding
    let b:block_comment = 0 " If file type has block comment support
    let b:min_comment_begin = '' " If file type has a special char for minified versions
    let b:comment_char = '' " Comment char, or for block comment trailing char of body
    let b:auto_space_after_char = 1 " Put auto space after comment char, if line is not empty
    " Field placeholders according to doc comment syntax, if available
    let b:field_file = 'File'
    let b:field_project = 'Project'
    let b:field_license_id = 'License'
    let b:field_author = 'Author'
    let b:field_date = 'Date'
    let b:field_modified_date = 'Last Modified Date'
    let b:field_modified_by = 'Last Modified By'
    let b:field_last_separator = '-----'
    let b:field_separator = ':'

    " Setting Values for Languages
    if
        \ b:filetype == 'arduino' ||
        \ b:filetype == 'c' ||
        \ b:filetype == 'cpp' ||
        \ b:filetype == 'cuda' ||
        \ b:filetype == 'css' ||
        \ (expand('%:e') == 'cfc' && b:filetype == 'cf') ||
        \ b:filetype == 'groovy' ||
        \ b:filetype == 'java' ||
        \ b:filetype == 'kotlin' ||
        \ b:filetype == 'scala' ||
        \ b:filetype == 'javascript' ||
        \ b:filetype == 'javascript.jsx' ||
        \ b:filetype == 'javascriptreact' ||
        \ b:filetype == 'typescript' ||
        \ b:filetype == 'typescriptreact' ||
        \ b:filetype == 'less' ||
        \ b:filetype == 'php' ||
        \ b:filetype == 'go' ||
        \ b:filetype == 'sass' ||
        \ b:filetype == 'systemverilog' ||
        \ b:filetype == 'verilog' ||
        \ b:filetype == 'verilog_systemverilog' ||
        \ b:filetype == 'lex' ||
        \ b:filetype == 'yacc'

        let b:block_comment = 1
        let b:comment_char = ' *'
        let b:comment_begin = '/**'
        let b:comment_end = ' */'
    " ----------------------------------
    elseif b:filetype == 'rust'
        let b:block_comment = 1
        let b:comment_char = ' *'
        let b:comment_begin = '/*'
        let b:comment_end = ' */'
    " ----------------------------------
    elseif b:filetype == 'haskell'
        let b:block_comment = 1
        let b:comment_char = ' -'
        let b:comment_begin = '{-'
        let b:comment_end = ' -}'
    " ----------------------------------
    elseif b:filetype == 'lua'
        let b:auto_space_after_char = 0
        let b:block_comment = 1
        let b:comment_begin = '--[[--'
        let b:comment_end = '--]]--'
    " ----------------------------------
    elseif b:filetype == 'perl'
        let b:first_line = '#!/usr/bin/env perl'
        let b:first_line_pattern = '#!\s*/usr/bin/env\s* perl'
        let b:comment_char = '#'
    " ----------------------------------
    elseif b:filetype == 'perl6'
        let b:first_line = '#!/usr/bin/env perl6'
        let b:first_line_pattern = '#!\s*/usr/bin/env\s* perl6'
        let b:comment_char = '#'
    " ----------------------------------
    elseif b:filetype == 'python'
        let b:first_line = '#!/usr/bin/env python3'
        let b:first_line_pattern = '#!\s*/usr/bin/env\s* python3'
        let b:encoding = '# -*- coding: utf-8 -*-'
        let b:comment_char = '#'
    " ----------------------------------
    elseif b:filetype == 'sh'
        let b:first_line = '#!/bin/bash'
        let b:first_line_pattern = '#!\s*/bin/bash'
        let b:comment_char = '#'
    elseif b:filetype == 'zsh'
        let b:first_line = '#!/bin/zsh'
        let b:first_line_pattern = '#!\s*/bin/zsh'
        let b:comment_char = '#'
    elseif b:filetype == 'fish'
        let b:first_line_pattern = '#!\s*/bin/fish'
        let b:comment_char = '#'
    " ----------------------------------
    elseif b:filetype == "ruby" ||
          \ b:filetype == "elixir" ||
          \ b:filetype == "tmux" ||
          \ b:filetype == "yaml"
        let b:comment_char = '#'
    " ----------------------------------
    elseif b:filetype == "erlang" ||
          \ b:filetype == "plaintex"
        let b:comment_char = "%%"
    " ----------------------------------
    elseif b:filetype == 'vim'
        let b:comment_char = '"'
    " ----------------------------------
    elseif b:filetype == "lisp" ||
          \ b:filetype == "scheme" ||
          \ b:filetype == "asm" ||
          \ b:filetype == "clojure" ||
          \ b:filetype == "racket"
        let b:comment_char = ";;"
    " ----------------------------------
    elseif b:filetype == "cs" ||
          \ b:filetype == "proto" ||
          \ b:filetype == "dart"
        let b:comment_char = "//"
    " ----------------------------------
    elseif b:filetype == "xdefaults"
        let b:comment_char = "!!"
    " ----------------------------------
    elseif b:filetype == "ocaml"
        let b:comment_begin = "(**"
        let b:comment_end = "*)"
        let b:comment_char = "*"
        let b:block_comment = 1
    " ----------------------------------
    elseif b:filetype == 'html'
        let b:first_line = '<!DOCTYPE html>'
        let b:first_line_pattern = '<!DOCTYPE\s* html>'
        let b:block_comment = 1
        let b:comment_char = ' -'
        let b:comment_begin = '<!--'
        let b:comment_end = '-->'
    " ----------------------------------
    elseif b:filetype == 'svelte'
        let b:block_comment = 1
        let b:comment_char = ' -'
        let b:comment_begin = '<!--'
        let b:comment_end = '-->'
    " ----------------------------------
    elseif b:filetype == 'cf'
        let b:block_comment = 1
        let b:comment_char = ' -- '
        let b:comment_begin = '<!---'
        let b:comment_end = '--->'
    "-----------------------------------
    elseif b:filetype == 'cfm' ||
          \ b:filetype == 'cfml'
        let b:block_comment = 1
        let b:comment_char = ' -- '
        let b:comment_begin = '<!---'
        let b:comment_end = '--->'
    "-----------------------------------
    elseif b:filetype == 'pug'
        let b:first_line = '//-'
        let b:first_line_pattern = '//-'
        let b:comment_char = ' '
    " ----------------------------------
    elseif b:filetype == 'octave' ||
          \ b:filetype == 'matlab' ||
          \ b:filetype == 'tex' ||
          \ b:filetype == 'vimwiki'
        let b:comment_char = '%'
    " ----------------------------------
    elseif b:filetype == 'cfg'
        let b:comment_char = g:header_cfg_comment_char
    " ----------------------------------
    elseif b:filetype == 'r'
        let b:first_line = '#!/usr/bin/Rscript'
        let b:first_line_pattern = '#!\s*/usr/bin/r'
        let b:comment_char = '#'
    " ----------------------------------
    elseif b:filetype == 'vhdl'
        let b:comment_char = '--'
        " Support for VHDL 2008 block comments
        let b:comment_begin = '/*'
        let b:comment_end = '*/'
    " ----------------------------------
    elseif b:filetype == 'rst'
        let b:first_line = '..'
        let b:comment_char = '  '
    " ----------------------------------
    elseif b:filetype == 'dosini'
        let b:first_line = '; vim:ft=dosini'
        let b:comment_char = ';'
    " ----------------------------------
    elseif b:filetype == 'make'
        let b:comment_char = '#'
    " ----------------------------------
    elseif b:filetype == 'markdown'
        let b:block_comment = 1
        let b:comment_begin = '```'
        let b:comment_end = '```'
        " ----------------------------------
    elseif b:filetype == 'tcl'
       let b:first_line = '#!/usr/bin/env tclsh'
       let b:first_line_pattern = '#!\s*/usr/bin/env\s* tclsh'
       let b:comment_char = '#'
    " ----------------------------------
    elseif b:filetype == 'ada'
        let b:comment_char = '--'
    elseif b:filetype == 'sql'
        let b:comment_char = '--'
    else
        let b:is_filetype_available = 0
    endif

    " Individual settings for special cases
    if b:filetype == 'php'
        let b:first_line = '<?php'
        let b:first_line_pattern = '<?php'
        let b:field_author = '@author'
    endif
    if b:filetype == 'css'
        let b:min_comment_begin = '/*!'
    endif
    if
        \ b:filetype == 'javascript' ||
        \ b:filetype == 'javascript.jsx' ||
        \ b:filetype == 'javascriptreact' ||
        \ b:filetype == 'typescript' ||
        \ b:filetype == 'typescriptreact'

        let b:min_comment_begin = '/*!'
        let b:field_file = '@file'
        let b:field_author = '@author'
    endif

    " For license texts, if there is a empty line, avoid trailing white space
    let b:comment_char_wo_space = b:comment_char
    " If there is space after comment char, put it
    if b:auto_space_after_char
        let b:comment_char .= ' '
    endif

    " Headers fetched from current configuration
    let b:user_headers = s:get_user_headers()
endfun

" HEADER GENERATORS
" -----------------
" Generate Header
fun s:add_header()
    let save_pos = getpos(".")
    let i = 0

    " If filetype has initial line
    if b:first_line != ''
        let line = search(b:first_line_pattern)
        if line == 0
            call append(i, b:first_line)
            let i += 1
        else
            let i = line
        endif
    endif
    " if has encoding
    if b:encoding != ''
        call append(i, b:encoding)
        let i += 1
    endif
    " If filetype supports block comment, open comment
    if b:block_comment
        call append(i, b:comment_begin)
        let i += 1
    endif

    " Fill user's information
    if g:header_field_filename
        if g:header_field_filename_path
            call append(i, b:comment_char . b:field_file . ' ' . expand('%s:t'))
        else
            call append(i, b:comment_char . b:field_file . ' ' . split(expand('%s:t'),'/')[-1])
        endif
        let i += 1
    endif
    if g:header_field_project != ''
        call append(i, b:comment_char . b:field_project . ' ' . g:header_field_project)
        let i += 1
    endif
    if g:header_field_license_id != ''
        call append(i, b:comment_char . b:field_license_id . ' ' . g:header_field_license_id)
        let i += 1
    endif
    if g:header_field_author != ''
        if g:header_field_author_email != ''
            let email = ' <' . g:header_field_author_email . '>'
        else
            let email = ''
        endif
        call append(i, b:comment_char . b:field_author . ' ' . g:header_field_author . email)
        let i += 1
    endif
    if g:header_field_timestamp
        call append(i, b:comment_char . b:field_date . ' ' . strftime(g:header_field_timestamp_format))
        let i += 1
    endif
    if g:header_field_modified_timestamp
        call append(i, b:comment_char . b:field_modified_date . ' ' . strftime(g:header_field_timestamp_format))
        let i += 1
    endif
    if g:header_field_modified_by && g:header_field_author != ''
        if g:header_field_author_email != ''
            let email = ' <' . g:header_field_author_email . '>'
        else
            let email = ''
        endif
        call append(i, b:comment_char . b:field_modified_by . ' ' . g:header_field_author . email)
        let i += 1
    endif
    if g:header_field_last_separator
        call append(i, b:comment_char. b:field_last_separator)
        let i += 1
    endif
    if g:header_field_copyright != ''
        call append(i, b:comment_char. g:header_field_copyright)
        let i += 1
    endif

    " If filetype supports block comment, close comment
    if b:block_comment
        call append(i, b:comment_end)
    endif
    call setpos(".", save_pos)
endfun

" This will replace characters which needs to be escaped in patterns
fun s:create_pattern_text(text, ...)
    let search_patterns = [['\*', '\\\*', ''], ['\.', '\\\.', ''], [ '"', '\\"', ''], [ '/', '\\/', 'g']]
    let replace_patterns = [['\*', '\\\*', ''], ['\.', '\\\.', ''], ['@', '\\@', ''], [ '"', '\\"', ''], [ '/', '\\/', 'g']]

    let for_search_part = a:0 == 1
    if for_search_part
      let patterns = search_patterns
    else
      let patterns = replace_patterns
    endif

    let res = a:text
    for p in patterns
        let res = substitute(res, p[0], p[1], p[2])
    endfor
    return res
endfun

" Update header field with the new value
fun s:update_header_field_and_value(field, value)
    let field_without_spaces = substitute(a:field, '\s*:$', '', '')
    let field = s:create_pattern_text(field_without_spaces, 1) . '\s*.*'
    let field_add = s:create_pattern_text(a:field) . ' '
    execute '0,'. g:header_max_size .'s/' . field . '/' . field_add . s:create_pattern_text(a:value) .'/'
endfun

" Update header field without changing it's value
" Used to switch between aligned and non-aligned headers for headers
" who have fixed values (i.e File...)
fun s:update_header_field(field)
    let l:field_without_spaces = substitute(a:field, '\s*:$', '\\s*[^:]*:', '')
    execute '0,'. g:header_max_size .'s/' . l:field_without_spaces . '/' . a:field . '/'
endfun

" Update Header
fun s:update_header()
    let save_pos = getpos(".")
    " Update file name
    if g:header_field_filename
        if g:header_field_filename_path
            call s:update_header_field_and_value(b:field_file, expand('%s:t'))
        else
            call s:update_header_field_and_value(b:field_file, split(expand('%s:t'),'/')[-1])
        endif
    endif
    "" Update project field
    if g:header_field_project != ''
        call s:update_header_field(b:field_project)
    endif
    "" Update field license id
    if g:header_field_license_id != ''
        call s:update_header_field(b:field_license_id)
    endif
    "" Update author field
    if g:header_field_author != ''
        call s:update_header_field(b:field_author)
    endif
    "" Update date field
    if g:header_field_timestamp
        call s:update_header_field(b:field_date)
    endif
    "" Update last modified date
    if g:header_field_modified_timestamp
        call s:update_header_field_and_value(b:field_modified_date, strftime(g:header_field_timestamp_format))
    endif
    "" Update last modified author
    if g:header_field_modified_by && g:header_field_author != ''
        if g:header_field_author_email != ''
            let email = ' <' . g:header_field_author_email . '>'
        else
            let email = ''
        endif
        call s:update_header_field_and_value(b:field_modified_by, g:header_field_author . email)
    endif
    "echo 'Header was updated succesfully.'
    call setpos(".", save_pos)
endfun

" Generate Minified Header
fun s:add_min_header()
    let save_pos = getpos(".")
    let i = 0

    " If filetype has initial line
    if b:first_line != ''
        let line = search(b:first_line_pattern)
        if line == 0
            call append(i, b:first_line)
            let i += 1
        else
            let i = line
        endif
    endif

    if b:encoding != ''
        call append(i, b:encoding)
        let i += 1
    endif

    " Set comment open char
    if b:block_comment
        if b:min_comment_begin == ''
            let header_line = b:comment_begin
        else
            let header_line = b:min_comment_begin
        endif
    else
        let header_line = b:comment_char
    endif

    " Fill user's information
    if g:header_field_filename
        if g:header_field_filename_path
            let header_line .= ' ' . expand('%s:t')
        else
            let header_line .= ' ' . split(expand('%s:t'),'/')[-1]
        endif
    endif
    if g:header_field_author != ''
        if g:header_field_author_email != ''
            let email = ' <' . g:header_field_author_email . '>'
        else
            let email = ''
        endif
        let header_line .= ' ' . b:field_author . ' "' . g:header_field_author . email . '"'
    endif
    if g:header_field_timestamp
        let header_line .= ' ' . b:field_date . ' ' . strftime(g:header_field_timestamp_format)
    endif

    " If filetype supports block comment, close comment
    if b:block_comment
        let header_line .= ' ' . b:comment_end
    endif

    " Add line to file
    call append(i, header_line)
    call setpos(".", save_pos)
endfun

" Generate License Header
fun s:add_license_header(license_name)
    let save_pos = getpos(".")
    " Add other infos
    let i = 0

    " If filetype has initial line
    if b:first_line != ''
        let line = search(b:first_line_pattern)
        if line == 0
            call append(i, b:first_line)
            let i += 1
        else
            let i = line
        endif
    endif

    if b:encoding != ''
        call append(i, b:encoding)
        let i += 1
    endif

    " If filetype supports block comment, open comment
    if b:block_comment
        call append(i, b:comment_begin)
        let i += 1
    endif

    " Fill user's information
    if g:header_field_filename
        call append(i, b:comment_char . expand('%s:t'))
        let i += 1
    endif
    if g:header_field_author != ''
        if g:header_field_author_email != ''
            let email = ' <' . g:header_field_author_email . '>'
        else
            let email = ''
        endif
        call append(i, b:comment_char . 'Copyright (c) ' . strftime('%Y') . ' ' . g:header_field_author . email)
        call append(i+1, b:comment_char_wo_space)
        let i += 2
    endif

    " Path to license file
    let file_name = s:license_files_dir . a:license_name
    " If license file is not exists, inform user
    if !filereadable(file_name)
        echo 'There is no defined "' . a:license_name . '" license.'
        return
    endif

    " Add raw license, and count lines of it
    let license_line_count = -line('$')
    execute expand(i) . 'read ' . expand(file_name)
    let license_line_count += line('$')

    let i += 1
    let license_line_count += i
    " Take raw license into comment
    while i < license_line_count
        let line = getline(i)
        " If there is an empty line, avoid putting trailing space
        if line == ''
            let line = b:comment_char_wo_space
        else
            let line = b:comment_char . line
        endif

        call setline(i,line)
        let i += 1
    endwhile

    " If filetype supports block comment, close comment
    if b:block_comment
        call append(i - 1, b:comment_end)
        let i += 1
    endif

    call setpos(".", save_pos)
endfun

" Get headers either set by the user or either by defaults
fun s:get_user_headers()
    let l:headers_fields = [] " list holding required headers

    " File header
    if g:header_field_filename
        call add(headers_fields, b:field_file)
    endif

    " Project header
    if g:header_field_project != ''
        call add(headers_fields, b:field_project)
    endif

    " License id
    if g:header_field_license_id != ''
        call add(headers_fields, b:field_license_id)
    endif

    " Author header
    if g:header_field_author != ''
        call add(headers_fields, b:field_author)
    endif

    " Date header
    if g:header_field_timestamp
        call add(headers_fields, b:field_date)
    endif

    " Last Modified Date header
    if g:header_field_modified_timestamp
        call add(headers_fields, b:field_modified_date)
    endif

    " Last Modified By header
    if g:header_field_modified_by
        call add(headers_fields, b:field_modified_by)
    endif

    return l:headers_fields
endfun

" Compare two strings from their char length in bytes
" This returns longer string first
func Sort_longer_str(str1, str2)
    return strchars(a:str2) - strchars(a:str1)
endfunc

" Get longer header size in chars from active ones
fun s:get_longer_header(headers)
    let l:headers_sorted_by_length = sort(a:headers, "Sort_longer_str")
    let l:longer_header = get(l:headers_sorted_by_length, 0)
    return l:longer_header
endfun

" Right pad header to align it to the longer one
fun s:align_field_with_spaces(field, longer_header_length)
    let l:field_length = strchars(a:field)
    let l:right_padding = a:longer_header_length - l:field_length
    let l:spaces = repeat(' ', l:right_padding)
    return a:field . l:spaces
endfun

" Update header fields to the correct value in case they should be aligned
" or not.
fun s:update_fields(longer_header_length)

    if match(b:user_headers, b:field_file) != -1
        if g:header_alignment
            let b:field_file =
                \ s:align_field_with_spaces(b:field_file, a:longer_header_length)
        endif
        let b:field_file = b:field_file . b:field_separator
    endif

    if match(b:user_headers, b:field_project) != -1
        if g:header_alignment
            let b:field_project =
                \ s:align_field_with_spaces(b:field_project, a:longer_header_length)
        endif
        let b:field_project = b:field_project . b:field_separator
    endif

    if match(b:user_headers, b:field_license_id) != -1
        if g:header_alignment
            let b:field_license_id =
                \ s:align_field_with_spaces(b:field_license_id, a:longer_header_length)
        endif
        let b:field_license_id = b:field_license_id . b:field_separator
    endif

    if match(b:user_headers, b:field_author) != -1
        if g:header_alignment
            let b:field_author =
                \ s:align_field_with_spaces(b:field_author, a:longer_header_length)
        endif
        let b:field_author = b:field_author . b:field_separator
    endif

    if match(b:user_headers, b:field_date) != -1
        if g:header_alignment
            let b:field_date =
                \ s:align_field_with_spaces(b:field_date, a:longer_header_length)
        endif
        let b:field_date = b:field_date . b:field_separator
    endif

    if match(b:user_headers, b:field_modified_date) != -1
        if g:header_alignment
            let b:field_modified_date =
                \ s:align_field_with_spaces(b:field_modified_date, a:longer_header_length)
        endif
        let b:field_modified_date = b:field_modified_date . b:field_separator
    endif

    if match(b:user_headers, b:field_modified_by) != -1
        if g:header_alignment
            let b:field_modified_by =
                \ s:align_field_with_spaces(b:field_modified_by, a:longer_header_length)
        endif
        let b:field_modified_by = b:field_modified_by . b:field_separator
    endif
endfun

" Check if required headers (ones that are set globally as required)
" are present from the start of the buffer to the header_size_threshold.
" ----------------------------------------------------------------------
" returns 1 if all required headers are present and within the range,
" otherwise returns 0
fun s:has_required_headers_in_range(header_size_threshold)
    let l:save_pos = getpos(".")
    let l:headers_fields = b:user_headers
    call setpos(".", [0, 0, 0, 0])

    " check if required headers are present and within the range
    for header_field in headers_fields
        let header_field_line_nbr = search(header_field)
        if
            \ header_field_line_nbr == 0 ||
            \ header_field_line_nbr > a:header_size_threshold
            call setpos(".", save_pos)
            return 0
        endif
        call setpos(".", [0, 0, 0, 0])
    endfor
    call setpos(".", save_pos)
    return 1
endfun
"
" MAIN FUNCTION
" -------------
" Main function selects header generator to add header
" type parameter options;
"   0: Normal Header
"   1: Minified Header
"   2: License Header (also uses license parameter)
fun header#add_header(type, license, silent)
    call s:set_props()

    " If filetype is available, add header else inform user
    if b:is_filetype_available

        let file_contains_headers =
            \ s:has_required_headers_in_range(g:header_max_size)

        " Select header generator
        if a:type == 0

            let l:longer_header_length = strchars(s:get_longer_header(b:user_headers))
            call s:update_fields(l:longer_header_length)

            " If there is already header, update it
            if file_contains_headers
                call s:update_header()
            else
                call s:add_header()
            endif
        elseif a:type == 1
            call s:add_min_header()
        elseif a:type == 2
            call s:add_license_header(a:license)
        else
            echo 'There is no "' . a:type . '" type to add header.'
        endif

    else
        if a:silent == 1
            return
        endif

        if b:filetype == ''
            let filetype = 'this'
        else
            let filetype = '"' . b:filetype . '"'
        endif
        echo 'No defined comment syntax for ' . filetype . ' filetype.'
    endif
endfun

fun header#update_header()
    call s:set_props()
    if b:is_filetype_available && s:has_required_headers_in_range(g:header_max_size)
        let l:longer_header_length = strchars(s:get_longer_header(b:user_headers))
        call s:update_fields(l:longer_header_length)
        call s:update_header()
    endif
endfunc
