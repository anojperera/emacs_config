return {
  {
    'nvim-orgmode/orgmode',
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/org_files/**/*',
        org_default_notes_file = '~/org_files/refile.org',
      })
    end
  },

  {
    "akinsho/org-bullets.nvim",
    config = function()
      require('org-bullets').setup()
    end
  },
}
