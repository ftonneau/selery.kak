# Select every Nth item from an adjacent line block or from a preexisting set of
# selections, starting at item 1.
# Author: François Tonneau

# Public command
# ------------------------------

define-command -params 1 selery -docstring \
'selery <N>: select every Nth item, starting at item 1' %{
    set-option buffer selery_num %arg(1)
    try %{
        selery-has-one-selection
        execute-keys <a-s>
    }
    selery-select-items
}

# Implementation
# ------------------------------

declare-option -hidden int selery_num 0
declare-option -hidden int selery_check 0

define-command -hidden selery-has-one-selection %{
    set-option buffer selery_check 1
    set-option -remove buffer selery_check %val(selection_count)
    execute-keys -draft %opt(selery_check) h
    #                   ^-- negative/illegal when selection count > 1
}

define-command -hidden selery-select-items %{
    evaluate-commands %sh{
        num=$kak_opt_selery_num
        test "$num" -gt 1 || exit

        # We put Kakoune's selection descriptions on separate lines, replacing
        # punctuation by spaces to be able to sort the first two coordinates.
        printf %s\\n "$kak_selections_desc" \
        | tr ' ,.' '\n  ' \
        | sort -t ' ' -k 1,1n -k 2,2n \
        | awk -v num=$num '
            # Restore the original selection format.
            {
                sub(" ", ".")
                sub(" ", ",")
                sub(" ", ".")
            }
            # Select items 1, 1 + num, 1 + num + num, ...
            NR == 1 {
                printf("select %s", $0)
            }
            NR > 1 {
                if (NR % num == 1) printf(" %s", $0)
            }
        '
    }
}

