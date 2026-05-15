vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities()
})

-- remove default lsp keymaps to set custom ones on lsp attach
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(args)
    -- disable color highlighting from LSP. this method works with both
    -- servers that obey and don't obey client capabilities because it doesn't
    -- let neovim start the semantic tokens engine
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil

    local opts = {buffer = args.buf}

    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

    -- show a list of all the places where what is under the cursor is used
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    -- show a list of all implementations of an interface or abstract methods/classes
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    -- show a list of  symbols (variables, functions, classes, methods, etc.)
    -- in the current file, makes navigation easier
    vim.keymap.set("n", "go", vim.lsp.buf.document_symbol, opts)

    -- go to where type is defined, typically in header files, for example
    vim.keymap.set("n", "gO", vim.lsp.buf.type_definition, opts)

    -- show where a symbol is declared, but not necessarily defined
    -- the difference between int num; and num = 5;
    -- NOTE: many servers do not implement this method, use definition instead
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    -- show where a symbol is defined and not just declared
    -- declared and defined are often in the same location, but not always
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  end,
})

-- make lsp warnings less annoying by delaying warnings in normal mode
vim.opt.updatetime = 1300
vim.diagnostic.enable(false)

vim.api.nvim_create_autocmd({"CursorHold"}, {
  desc = "Diagnostics on",
  callback = function()
    vim.diagnostic.enable(true)
  end,
})

vim.api.nvim_create_autocmd({"TextChanged", "InsertEnter"}, {
  desc = "Diagnostics off",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})
