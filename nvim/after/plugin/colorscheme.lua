-- which-key labels
local wk = require("which-key")
wk.add({
    { "<leader>s", group = "Color Schemes" }
})


-- commands
local commands = {
    ["cat"] = { "<cmd>colorscheme catppuccin<cr>", desc = "catuppuccin" },
    ["cat_frappe"] = { "<cmd>colorscheme  catppuccin-frappe<cr>", desc = "frappe" },
    ["cat_latte"] = { "<cmd>colorscheme  catppuccin-latte<cr>", desc = "latte" },
    ["cat_mocha"] = { "<cmd>colorscheme  catppuccin-mocha<cr>", desc = "mocha" },
    ["cat_macchiato"] = { "<cmd>colorscheme  catppuccin-macchiato<cr>", desc = "macchiato" },
    ["kanagawa"] = { "<cmd>colorscheme kanagawa<cr>", desc = "kanagawa" },
    ["kanagawa_dragon"] = { "<cmd>colorscheme  kanagawa-dragon<cr>", desc = "dragon" },
    ["kanagawa_lotus"] = { "<cmd>colorscheme  kanagawa-lotus<cr>", desc = "lotus" },
    ["kanagawa_wave"] = { "<cmd>colorscheme  kanagawa-wave<cr>", desc = "wave" },
    ["tokyonight"] = { "<cmd>colorscheme tokyonight<cr>", desc = "tokyonight" },
    ["tokyonight_day"] = { "<cmd>colorscheme tokyonight-day<cr>", desc = "day" },
    ["tokyonight_moon"] = { "<cmd>colorscheme tokyonight-moon<cr>", desc = "moon" },
    ["tokyonight_night"] = { "<cmd>colorscheme tokyonight-night<cr>", desc = "night" },
    ["tokyonight_storm"] = { "<cmd>colorscheme tokyonight-storm<cr>", desc = "storm" },
    ["astro"] = { "<cmd>colorscheme astrotheme<cr>", desc = "astro" },
    ["astro_dark"] = { "<cmd>colorscheme astrodark<cr>", desc = "dark" },
    ["astro_light"] = { "<cmd>colorscheme astrolight<cr>", desc = "light" },
    ["oni"] = { "<cmd>colorscheme onitheme<cr>", desc = "oni" },
    ["oni_dark"] = { "<cmd>colorscheme onidark<cr>", desc = "dark" },
    ["oni_light"] = { "<cmd>colorscheme onilight<cr>", desc = "light" },
    ["xcode"] = { "<cmd>colorscheme xcode<cr>", desc = "xcode" },
    ["xcodedark"] = { "<cmd>colorscheme xcodedark<cr>", desc = "dark" },
    ["xcodedarkhc"] = { "<cmd>colorscheme xcodedarkhc<cr>", desc = "darkhc" },
    ["xcodelight"] = { "<cmd>colorscheme xcodelight<cr>", desc = "light" },
    ["xcodelighthc"] = { "<cmd>colorscheme xcodelighthc<cr>", desc = "lighthc" },
    ["xcodewwdc"] = { "<cmd>colorscheme xcodewwdc<cr>", desc = "wwdc" },
    ["lush"] = { "<cmd>colorscheme lush<cr>", desc = "lush" },
    ["arctic"] = { "<cmd>colorscheme arctic<cr>", desc = "arctic" }
}

-- leader mappings
local mappings = {
    ["<leader>s"] = false,
    ["<leader>sc"] = commands.cat,
    ["<leader>scf"] = commands.cat_frappe,
    ["<leader>scl"] = commands.cat_latte,
    ["<leader>scM"] = commands.cat_mocha,
    ["<leader>scm"] = commands.cat_macchiato,
    ["<leader>sk"] = commands.kanagawa,
    ["<leader>skd"] = commands.kanagawa_dragon,
    ["<leader>skl"] = commands.kanagawa_lotus,
    ["<leader>skw"] = commands.kanagawa_wave,
    ["<leader>st"] = commands.tokyonight,
    ["<leader>std"] = commands.tokyonight_day,
    ["<leader>stm"] = commands.tokyonight_moon,
    ["<leader>stn"] = commands.tokyonight_night,
    ["<leader>sts"] = commands.tokyonight_star,
    ["<leader>sa"] = commands.astro,
    ["<leader>sad"] = commands.astro_dark,
    ["<leader>sal"] = commands.astro_light,
    ["<leader>so"] = commands.oni,
    ["<leader>sod"] = commands.oni_dark,
    ["<leader>sol"] = commands.oni_light,
    ["<leader>sor"] = commands.oni_rust,
    ["<leader>sx"] = commands.xcode,
    ["<leader>sxd"] = commands.xcodedark,
    ["<leader>sxD"] = commands.xcodedarkhc,
    ["<leader>sxl"] = commands.xcodelight,
    ["<leader>sxL"] = commands.xcodelighthc,
    ["<leader>sxw"] = commands.xcodewwdc,
    ["<leader>sl"] = commands.lush,
    ["<leader>ss"] = commands.arctic,
}

-- map keys
for k, v in pairs(mappings) do
    if v then
        vim.keymap.set('n', k, v[1], { desc = v["desc"] })
    end
end
