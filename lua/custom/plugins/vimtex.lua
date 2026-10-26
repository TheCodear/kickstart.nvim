-- Vimtex
vim.pack.add { 'https://github.com/lervag/vimtex' }

-- Requires:
--   brew tap homebrew-zathura/zathura
--   brew install zathura --with-synctex
--   brew install zathura-pdf-mupdf
--   // do as in the caveat
--   d="$(brew --prefix zathura)/lib/zathura"
--   mkdir -p $d
--   ln -s "$(brew --prefix zathura-pdf-mupdf)/libpdf-mupdf.dylib" "$d/"
vim.g.vimtex_view_method = 'zathura_simple'

-- seems to be the default
vim.g.vimtex_compiler_method = 'latexmk'

vim.g.vimtex_compiler_latexmk = {
  build_dir = "",
  continuous = 1,
  options = {
    "-pdf",
    "-synctex=1", -- important for reverse sync
    "-interaction=nonstopmode",
    "-file-line-error",
  },
}

-- in order to make syntex work with zathura, do the following:
--   mkdir -p ~/.config/zathura
--   echo "set synctex true" > ~/.config/zathura/zathurarc
