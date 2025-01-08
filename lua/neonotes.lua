local M = {}

M.notes_path = vim.fn.expand("~/Documents/Notes")

local function is_dir(path)
    return vim.fn.isdirectory(path) == 1
end


function M.open_notes()
    if not is_dir(M.notes_path) then
        vim.notify("Notes directory does not exist", vim.log.levels.ERROR)
        return
    end
    vim.cmd("e " .. M.notes_path)
    vim.cmd("Oil")
end

function M.search_notes()
    if not is_dir(M.notes_path) then
        vim.notify("Notes directory does not exist", vim.log.levels.ERROR)
        return
    end

    require("telescope.builtin").find_files({
        prompt_title = "Notes",
        cwd = M.notes_path,
        hidden = true,
    })
end

function M.search_text_in_notes()
    if not is_dir(M.notes_path) then
        vim.notify("Notes directory does not exist", vim.log.levels.ERROR)
        return
    end

    require("telescope.builtin").live_grep({
        prompt_title = "Search Notes",
        cwd = M.notes_path,
    })
end

function M.setup()
    opts = opts or {}

    M.notes_path = opts.notes_path or M.notes_path

    -- Keybinds
    vim.api.nvim_set_keymap("n", "<leader>no", "<cmd>lua require('neonotes').open_notes()<CR>",
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>sn", "<cmd>lua require('neonotes').search_notes()<CR>",
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>st", "<cmd>lua require('neonotes').search_text_in_notes()<CR>",
        { noremap = true, silent = true })
end

return M
