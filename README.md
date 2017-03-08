# "Emacs for the Laity" configuration

## What is this?

This configuration file causes Emacs to behave more like a "normal" text editor (with familiar keybindings [i.e., keyboard shortcuts] such as `C-c` for copy, `C-v` for paste, `C-z` for undo and `C-S-z` for redo, etc.). It thus allows users who have never interacted with Emacs but who want to use `org-mode` to do so.

### "This is an abomination! People who use Emacs need to learn all of its functionality and default keybindings!"

When I use Emacs, I use `evil-mode`, making Emacs work more like Vim. This is philosophically no different. In my mind, Emacs is a wonderful *platform* for doing text editing. Its configurability means that the *interface* for working with that platform can adapt to the people using it, whether by making it act more like Vim or like Notepad++.

## Usage

1. Install Emacs
    * For Linux, though your distribution's package manager
    * For OSX, from [Emacs for Mac OSX](https://emacsformacosx.com/ "Installer for Emacs for Mac OSX")
    * For Windows, from the [GNU Project](https://www.gnu.org/software/emacs/download.html#windows "Installer for Emacs for Windows")
1. Paste the `.emacs` file into your home directory (in Linux and OSX, it should be at `~/.emacs`).
    * For Windows, you can [alternatively paste the file](https://www.gnu.org/software/emacs/manual/html_node/efaq-w32/Location-of-init-file.html "GNU.org: Naming .emacs in Windows") so that it is named `_emacs`, if your system won't let you name a file starting with a period.
1. Open the `.emacs` file you just pasted in a text editor (ha, preferably not Emacs). Find the code chunk that starts with the line `(setq org-agenda-files (quote (`. Replace the lines below that with the folder(s) where you plan to keep the files you want to use with `org-mode`.
1. Start Emacs. If Emacs can see the `.emacs` file you moved in the step above, it should ask you whether you would like to install a series of add-ons (Press "Y" on your keyboard for each). 
1. You may then need to close and re-open Emacs.
1. If all goes well, when you open Emacs, you should be greeted with some helpful reminder text.
