# selery.kak

Select every Nth item from a block of adjacent lines (or from a preexisting set
of selections), starting at item 1.

# Installation

Copy `selery.kak` somewhere in your autoload directory tree.

# Usage

Entering `:selery <N>` in normal mode will allow you to select items 1, 1 + N,
1 + 2N, ..., from an adjacent line block or from a set of multiple selections.

For example, with a 10-line paragraph selected, entering `:selery 2` will
select lines 1, 3, 5, 7, 9. With a group of 10 selections, entering `:selery 3`
will pick selections 1, 4, 7, and 10.

## Note

If you often use selery, you may want to bind a normal key to this command or
create a short alias to it.

## License

MIT

