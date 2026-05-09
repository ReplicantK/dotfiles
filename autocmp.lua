-- NOTE: there isn't a separate luasnip config file, as it's only used here
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  completion = {
    autocomplete = true
  },

  sources = {
    {name = "nvim_lsp"},
    {name = "luasnip"}
  },

  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({select = true}),
    ["<C-Space>"] = cmp.mapping.complete(),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {"i", "s"}),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"})
  }),

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
})
