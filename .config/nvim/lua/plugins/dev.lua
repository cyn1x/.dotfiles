-- [[ Local Development ]]
-- I only develop plugins on my personal device(s), so we do
--  not want Neovim to import them on my work device, or
--   other device if the dev plugin dir does not exist.
local dir = GetEnv()
    .. '/.nvim/plugins/'

if vim.fn.isdirectory(dir) ~= 0 then
  return {
    dir .. 'outhouse.nvim',
    dev = true
  }
else
  return {}
end
