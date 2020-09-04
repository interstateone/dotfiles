# Dotfiles

```
git clone git@github.com:interstateone/dotfiles.git && \ 
git submodule update --init --recursive && \
cd dotfiles
```

Use GNU Stow to manage the installation of configuration packages.

`brew install stow`

Then use stow to symlink packages.

`stow --ignore=.DS_Store git`
