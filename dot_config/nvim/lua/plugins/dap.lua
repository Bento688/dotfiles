return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,

    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python"
    },

    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      -- ==========================
      -- DAP UI
      -- ==========================
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end

      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- ==========================
      -- JavaScript / TypeScript DAP
      -- ==========================
      local js_debug_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

      if vim.fn.filereadable(js_debug_path) == 0 then
        vim.notify("js-debug-adapter not found. Install it with :MasonInstall js-debug-adapter", vim.log.levels.ERROR)
      else
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              js_debug_path,
              "${port}",
            },
          },
          options = {
            detached = false,
          },
        }

        for _, language in ipairs {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        } do
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch current file",
              program = "${file}",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              console = "integratedTerminal",
              skipFiles = {
                "<node_internals>/**",
                "${workspaceFolder}/node_modules/**/*.js",
              },
            },

            {
              type = "pwa-node",
              request = "launch",
              name = "Launch Express server",
              program = "${workspaceFolder}/index.js",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              console = "integratedTerminal",
              skipFiles = {
                "<node_internals>/**",
                "${workspaceFolder}/node_modules/**/*.js",
              },
            },

            {
              type = "pwa-node",
              request = "attach",
              name = "Attach to Express server on 9229",
              address = "localhost",
              port = 9229,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              restart = true,
              skipFiles = {
                "<node_internals>/**",
                "${workspaceFolder}/node_modules/**/*.js",
              },
            },

            {
              type = "pwa-node",
              request = "attach",
              name = "Attach to Node process",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              skipFiles = {
                "<node_internals>/**",
                "${workspaceFolder}/node_modules/**/*.js",
              },
            },
          }
        end
      end

      -- ==========================
      -- Python / FastAPI DAP
      -- ==========================
      local function get_python_path()
        local cwd = vim.fn.getcwd()

        if vim.env.VIRTUAL_ENV then
          return vim.env.VIRTUAL_ENV .. "/bin/python"
        end

        if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        end

        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        end

        return "python3"
      end

      local debugpy_adapter = vim.fn.stdpath "data" .. "/mason/bin/debugpy-adapter"

      if vim.fn.executable(debugpy_adapter) == 0 then
        vim.notify("debugpy-adapter not found. Install it with :MasonInstall debugpy", vim.log.levels.ERROR)
      else
        dap.adapters.python = {
          type = "executable",
          command = debugpy_adapter,
          options = {
            source_filetype = "python",
          },
        }

        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch current file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            pythonPath = get_python_path,
          },

          {
            type = "python",
            request = "launch",
            name = "Launch FastAPI (app.main:app)",
            module = "uvicorn",
            args = {
              "app.main:app",
              "--host",
              "127.0.0.1",
              "--port",
              "8000",
            },
            cwd = "${workspaceFolder}",
            pythonPath = get_python_path,
            justMyCode = true,
            jinja = true,
          },

          {
            type = "python",
            request = "attach",
            name = "Attach to debugpy :5678",
            connect = {
              host = "127.0.0.1",
              port = 5678,
            },
            cwd = "${workspaceFolder}",
            pathMappings = {
              {
                localRoot = "${workspaceFolder}",
                remoteRoot = "${workspaceFolder}",
              },
            },
          },
        }
      end
    end,

    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "DAP Toggle Breakpoint",
      },

      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "DAP Continue",
      },

      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "DAP Step Over",
      },

      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "DAP Step Into",
      },

      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "DAP Step Out",
      },

      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "DAP UI Toggle",
      },

      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "DAP Open REPL",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "DAP Terminate",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        mode = { "n", "v" },
        desc = "DAP Evaluate",
      },
    },
  },
}
