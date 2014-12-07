Dye
===

Note: This lib uses uppercase sigil modifiers. So only works with elixir master right now.

`Dye` introduced two sigils: `~d` and `~D`.

## Usage

```elixir
iex(1)> import Dye
nil

iex(2)> ~d"Red text"r
"\e[31mRed text\e[0m"

iex(3)> ~d"Bright red text"R
"\e[91mBright red text\e[0m"

iex(4)> ~d"Bright red text with green background"Rg
"\e[91;42mBright red text with green background\e[0m"

iex(5)> ~d"Underline"u
"\e[4mUnderline\e[0m"

iex(6)> ~d"Underline red text"ur
"\e[4;31mUnderline red text\e[0m"

iex(7)> ~d"Underline red text with bright green background"urG
"\e[4;31;102mUnderline red text with bright green background\e[0m"
```

## Color Modifiers

```
d: Default
k: Black
r: Red
g: Green
y: Yellow
b: Blue
m: Magenta
c: Cyan
w: White
K: Bright Black
R: Bright Red
G: Bright Green
Y: Bright Yellow
B: Bright Blue
M: Bright Magenta
C: Bright Cyan
W: Bright White
```

## Special Modifiers

These modifiers must appear before color modifiers.

```
e: Don't reset at the end
I: Inverse text and background color
D: Bold
i: Italic
u: Underline
l: Blink slow
L: Blink rapid
```
