; Local override for nvim-treesitter's Python highlights.
; The upstream query currently references "except*", but the installed Python
; parser does not expose that anonymous node, which crashes highlighting.

(comment) @comment

(identifier) @variable

((identifier) @constant
  (#match? @constant "^[A-Z][A-Z_0-9]*$"))

((identifier) @constant.builtin
  (#any-of? @constant.builtin "NotImplemented" "Ellipsis" "__debug__"))

((identifier) @variable.builtin
  (#any-of? @variable.builtin "self" "cls"))

(function_definition
  name: (identifier) @function)

(class_definition
  name: (identifier) @type)

(call
  function: (identifier) @function.call)

(call
  function: (attribute
    attribute: (identifier) @function.method.call))

(attribute
  attribute: (identifier) @property)

(decorator) @attribute

[
  (string)
  (string_content)
] @string

(escape_sequence) @string.escape
(interpolation) @string.special

[
  (integer)
  (float)
] @number

[
  (true)
  (false)
] @boolean

(none) @constant.builtin

[
  "def"
  "class"
  "lambda"
] @keyword.function

[
  "if"
  "elif"
  "else"
  "match"
  "case"
] @keyword.conditional

[
  "for"
  "while"
  "break"
  "continue"
] @keyword.repeat

[
  "try"
  "except"
  "raise"
  "finally"
] @keyword.exception

[
  "import"
  "from"
  "as"
] @keyword.import

[
  "return"
  "yield"
] @keyword.return

[
  "async"
  "await"
] @keyword.coroutine

[
  "and"
  "or"
  "not"
  "in"
  "is"
] @keyword.operator

[
  "assert"
  "del"
  "global"
  "nonlocal"
  "pass"
  "with"
] @keyword

[
  "+"
  "-"
  "*"
  "**"
  "/"
  "//"
  "%"
  "@"
  "<<"
  ">>"
  "&"
  "|"
  "^"
  "~"
  ":="
  "<"
  "<="
  "=="
  "!="
  ">="
  ">"
  "="
  "+="
  "-="
  "*="
  "/="
  "//="
  "%="
  "@="
  "&="
  "|="
  "^="
  ">>="
  "<<="
  "**="
] @operator

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "."
  ","
  ":"
  ";"
] @punctuation.delimiter
