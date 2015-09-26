Dye
===

Note: This lib uses uppercase sigil modifiers. So only works with elixir >= 1.1.0.

`use Dye` will replaces sigils: `~s` and `~S`.


## Usage

```elixir
iex(1)> use Dye
nil

iex(2)> ~s"Red text"r
"\e[31mRed text\e[0m"

iex(3)> ~s"Bright red text"R
"\e[91mBright red text\e[0m"

iex(4)> ~s"Bright red text with green background"Rg
"\e[42;91mBright red text with green background\e[0m"

iex(5)> ~s"Underline"u
"\e[4mUnderline\e[0m"

iex(6)> ~s"Underline red text"ur
"\e[31;4mUnderline red text\e[0m"

iex(7)> ~s"Underline red text with bright green background"urG
"\e[102;31;4mUnderline red text with bright green background\e[0m"
```


## Color Modifiers

> $ mix test

![Color modifiers demo](https://github.com/Kabie/dye/raw/master/priv/demo.png)

The first color modifier will be used as text color. If you only want to set background, you can set text then use `I` to inverse the color.

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

```
e: Don't reset at the end
I: Inverse text and background color
D: Bold
i: Italic
u: Underline
l: Blink slow
L: Blink rapid
```


## Call `sigil_s/sigil_S` directly

The default implementation uses macro, which limits the modifiers can only be char list literal. The following won't work:

```elixir
mods = 'Rg'
sigil_S(<<"foo">>, mods)
```

To use the function implementation, simply do:

```elixir
use Dye, func: true
```
