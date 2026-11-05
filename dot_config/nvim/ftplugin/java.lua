local jdtls = require("jdtls")

local root_dir = vim.fs.root(0, {
  "gradlew",
  "mvnw",
  "pom.xml",
  "build.gradle",
  "settings.gradle",
  ".git",
})

-- For standalone Java files / simple learning exercises
if not root_dir then
  root_dir = vim.fn.expand("%:p:h")
end

local project_name = vim.fn.fnamemodify(root_dir, ":t")

local workspace_dir =
  vim.fn.stdpath("data")
  .. "/jdtls-workspace/"
  .. project_name

local config = {
  name = "jdtls",

  cmd = {
    "jdtls",
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {},
  },

  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)
