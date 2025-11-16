return {
  'chrishrb/gx.nvim',
  keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
  cmd = { 'Browse' },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  dependencies = { 'nvim-lua/plenary.nvim' }, -- Required for Neovim < 0.10.0
  -- config = true, -- default settings
  submodules = false, -- not needed, submodules are required only for tests

  -- you can specify also another config if you want
  config = function()
    require('gx').setup {
      open_browser_app = 'os_specific', -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
      open_browser_args = { '--background' }, -- specify any arguments, such as --background for macOS' "open".
      handlers = {
        plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
        github = true, -- open github issues
        brewfile = true, -- open Homebrew formulaes and casks
        package_json = true, -- open dependencies from package.json
        search = true, -- search the web/selection on the web if nothing else is found
        go = true, -- open pkg.go.dev from an import statement (uses treesitter)
        jira = { -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
          name = 'jira', -- set name of handler
          handle = function(mode, line, _)
            local ticket = require('gx.helper').find(line, mode, '(%u+-%d+)')
            if ticket and #ticket < 20 then
              return 'http://jira.lenta.tech/browse/' .. ticket
            end
          end,
        },
      },
      handler_options = {
        search_engine = 'google', -- you can select between google, bing, duckduckgo, ecosia and yandex
        -- search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
        select_for_search = false, -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link

        git_remotes = { 'upstream', 'origin' }, -- list of git remotes to search for git issue linking, in priority

        git_remote_push = false, -- use the push url for git issue linking,
      },
    }
  end,
  opts = {},
}
