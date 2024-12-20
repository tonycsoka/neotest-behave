# neotest-behave

A [Behave](https://behave.readthedocs.io/en/latest/), BDD  adapter for [Neotest](https://github.com/nvim-neotest/neotest)

Behave will need to be runnable, with all runtime packages installed, from the directory where your [gherkin](https://cucumber.io/docs/gherkin/) (*.feature) files are

__Needs https://github.com/tonycsoka/tree-sitter-gherkin installed first__

Soemting like this in your treesiter config will do

```lua
parser_config.gherkin = {
	install_info = {
    url = "https://github.com/tonycsoka/tree-sitter-gherkin", -- local path or git repo
    files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "cucumber", -- if filetype does not match the parser name
}
```

Then add this like any other adater.

For instance, add this to your package manager (Lazy in this case)

```lua
{
  "tonycsoka/neotest-behave",
  dependencies = {
    "nvim-neotest/neotest",
  },
}
```

Then add `neotest-behave` to the neotest setup, i.e.

```lua
require("neotest").setup({
  adapters = {
    require("neotest-behave"),
    ...
  },
  summary = {
    open = "botright vsplit | vertical resize 30",
  },
})
```
