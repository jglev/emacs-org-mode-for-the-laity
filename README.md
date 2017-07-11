# "Emacs `org-mode` for the Laity" configuration

## What is this?

This configuration file causes Emacs to behave more like a "normal" text editor (with familiar keybindings [i.e., keyboard shortcuts] such as `C-c` for copy, `C-v` for paste, `C-z` for undo and `C-S-z` for redo, etc.). It thus allows users who have never interacted with Emacs but who want to use `org-mode` to do so.

### "This is an abomination! People who use Emacs need to learn all of its functionality and default keybindings!"

When I use Emacs, I use `evil-mode`, making Emacs work more like Vim. What the configuration file in this repository does is philosophically no different. In my mind, Emacs is a wonderful *platform* for doing text editing. Its configurability means that the *interface* for working with that platform can adapt to the people using it, whether by making it act more like Vim or like Notepad++.

### "Won't this teach people bad habits about using Emacs? People won't be able to sit down at a clean Emacs installation on someone else's computer and use it."

Given Emacs' complexity, users adapt and learn new functionality based on the needs of the work they're doing at the time. That's how we learn, yes? -- by incrementally adding to our knowledge given a specific problem in a specific context. With this in mind, I suspect that users of this configuration file will learn new habits as they need to. If this configuration file helps users start using Emacs where they wouldn't have otherwise, and if Emacs is a useful tool for them given they work they're doing, I consider that a positive outcome, regardless of how "clean" the experience is.

### What do you mean by "laity"?

From [Oxford Living Dictionaries](https://en.oxforddictionaries.com/definition/laity "Oxford Living Dictionaries: 'laity'"): "Ordinary people, as distinct from professionals or experts." By this, I just mean people who don't have expert-level experience with *Emacs* specifically -- that is, users who have never worked with it before.

## Usage

1. Install Emacs (preferably **version 25.1 or higher**):
    * For Linux, though your distribution's package manager
    * For OSX, from [Emacs for Mac OSX](https://emacsformacosx.com/ "Installer for Emacs for Mac OSX")
    * For Windows, from the [GNU Project](https://www.gnu.org/software/emacs/download.html#windows "Installer for Emacs for Windows")
    	* Click "main GNU FTP server"
    	* Select the Emacs version with the highest version number. You'll probably want the version that includes "x86" in its name (For example, `emacs-25.1-x86_64-w64-mingw32.zip`)
    	* Download the `.zip` file, and unpack it into any directory on your computer.
    	* Go into the unzipped folder, go into the `bin` directory, and double-click on `runemacs`.
    		* If you see a security warning, click "Run".
    		* Emacs on Windows doesn't require you to install anything. Just double-click that `runemacs` program when you want to load Emacs.
1. Save the contents of the `dotemacs` file from this repository to the location where Emacs will look for it whenever Emacs is launched:
	1. Open Emacs.
	1. In Emacs, press the "`Meta`" key (usually the "`Alt`" key on your keyboard) at the same time as "`:`". For most keyboards in the USA, this means that you will be pressing `Alt + Shift + ;`.  
	You'll know that you pressed the correct keys if the bottom of the Emacs window says `Eval: `.
	1. In the `Eval: ` textbox at the bottom of the Emacs window, type the following (including the parentheses): `(find-file user-init-file)`. Press `Enter` on your keyboard.  
	This command tells Emacs to open its configuration file, wherever on your computer it is (its location depends on what Operating System you're using).
	1. In your web browser, go to the content of the `dotemacs` file from this repository, by [clicking here](https://raw.githubusercontent.com/publicus/emacs-org-mode-for-the-laity/master/dot-emacs "dotemacs raw content").
	1. Select all of the text from the `dotemacs` file, and copy it to your clipboard).
	1. Go back to Emacs. Click `Edit -> Paste` to paste the contents from `dotemacs` into the window (Use the point-and-click menu within Emacs for now; by default, Emacs uses different keyboard commands than other programs, so the typical `Control + v` or `Command + v` keyboard shortcut for "Paste" will not work in it at first).
	1. Close Emacs.
1. Install add-ons ("packages") for Emacs:
	1. Re-open Emacs. 
	1. If Emacs can see the `.emacs` file you moved in the step above, it should ask you whether you would like to install a series of add-ons (if you are running Emacs lower than version 25.1, it will just start installing the packages), if it didn't already at some point above. You'll see some text (and may see some "Warnings") appear in the Emacs window.
	1. Once the installation is finished, close emacs again.
1. Tell Emacs where you plan to store your .org files:
	1. Open Emacs again. Run the `Meta + :` keyboard command again, and, like above, type the following (including the parentheses): `(find-file user-init-file)`. Press `Enter` on your keyboard.
	1. Type `Control + F` on your keyboard to search the file, and type `agenda` (to search for the word "agenda"). Find the code chunk that starts with the line `(setq org-agenda-files (quote (`. Replace the lines below that ("`~/Daily_Logs`", "`~/Primary_Syncing_Folder/Documents/todo`") with the folder(s) where you plan to keep the files you want to use with `org-mode` (On Macs and Linux, `~` means your Home directory).
	1. Close Emacs
1. Re-open Emacs one more time to let the changes take full effect.
1. If all goes well, when you open Emacs, you should be greeted with some helpful text about org-mode.

## Changelog

### 2017-07-11

- Added `C-t` keybinding for buffer menu
- Configured `tabbar-mode` to set all tabs as part of one group
- Customized the look of the tabbar.

### 2017-07-05

Implemented the following ideas, many of which were from [suggestions by @shaund](https://github.com/publicus/emacs-org-mode-for-the-laity/issues/1 "Issue #1").

- Add `(prefer-coding-system 'utf-8)` to avoid a package installation error; similarly, remove `melpa-stable` from the list of repositories (`melpa` is still listed)
- Change the keyboard command for moving between emacs sub-windows to `C-S-M` (i.e., `Control-Shift-Meta-ArrowKey`, meaning usually `Control-Shift-Alt-ArrowKey`)
- Turn on `org-indent` mode
- Turn on `tabbar` mode, to create a web-browser-like tab-bar on the top of the window with open buffers.
- Add `Control-mousewheel` zooming
- Bind `Control-y` to `redo`, alongside `Control-Shift-z`
- Make `Shift-click` highlight text rather than open a menu
- Enforce Todo dependencies
- Add NeoTree for a file browser sidebar (with F8 keybinding)

### 2017-03-07

Initial posting/release!