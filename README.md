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

1. Install Emacs
    * For Linux, though your distribution's package manager
    * For OSX, from [Emacs for Mac OSX](https://emacsformacosx.com/ "Installer for Emacs for Mac OSX")
    * For Windows, from the [GNU Project](https://www.gnu.org/software/emacs/download.html#windows "Installer for Emacs for Windows")
    	* Click "main GNU FTP server"
    	* Select the Emacs version with the highest version number. You'll probably want the version that includes "x86" in its name (For example, `emacs-25.1-x86_64-w64-mingw32.zip`)
    	* Download the `.zip` file, and unpack it into any directory on your computer.
    	* Go into the unzipped folder, go into the `bin` directory, and double-click on `runemacs`.
    		* If you see a security warning, click "Run".
    		* Emacs on Windows doesn't require you to install anything. Just double-click that `runemacs` program when you want to load Emacs.
1. Paste the `.emacs` from this repository into your home directory (in Linux and OSX, it should be saved to `~/.emacs` (i.e., `[Your user home folder]/.emacs`).
	* **For Mac OSX and Linux,** if you are in Firefox, you can download the `.emacs` file [here](https://raw.githubusercontent.com/publicus/emacs-org-mode-for-the-laity/master/.emacs ".emacs file content").
	* In Firefox or a similar browswer, right click on the page, and click "Save Page As...". Then save it as "`.emacs`" in your home directory (on a Mac, for example, `/Users/Your_User_Name/`).  
	(Your home directory is the directory that includes folders called `Downloads`, `Documents`, `Music`, etc.).
	* **For Windows,** there are several ways to do this.
		* I think that the easiest way to do this is to set an "Environment Variable" called "HOME" and point it to `C:\Users\Your_User_Name`, following the instructions [here](www.computerhope.com/issues/ch000549.htm "How to set the path and environment variables in Windows").
			1. Follow the instructions at the website linked above.
				* The Varible name should be "`HOME`".
				* The Value should be your main user directory (`C:\Users\Your_User_Name`).
			1. Open Notepad.
			1. Paste the contents from [the .emacs file from this repository](https://raw.githubusercontent.com/publicus/emacs-org-mode-for-the-laity/master/.emacs ".emacs file content") into the Notepad window.
			1. In Notepad, click `File -> Save As...`
			1. Under `File name`, type "`.emacs`"
			1. Under `Save as type`, choose "All Files" (If you don't do this, Textedit will add "`.txt`" to the filename, which will cause Emacs to ignore it.
			1. Open Emacs. You'll know that it can find your .emacs file if it asks you at the bottom of the window whether you want to install a package (see below).			
		* (The other main way to do this is to go to `C:\Users\Your_User_Name\AppData\Roaming`. This is the directory where Emacs on Windows seems to look by default.
    	* For Windows, you can [alternatively paste the file](https://www.gnu.org/software/emacs/manual/html_node/efaq-w32/Location-of-init-file.html "GNU.org: Naming .emacs in Windows") so that it is named `_emacs`, if your system won't let you name a file starting with a period.
1. In a text editor (ha, preferably not Emacs; for **Windows, Notepad;** for **OSX, TextEdit;** for **Linux, Pluma, Kate, Gedit, etc.**), open the `.emacs` file you just saved. Find the code chunk that starts with the line `(setq org-agenda-files (quote (`. Replace the lines below that with the folder(s) where you plan to keep the files you want to use with `org-mode`.
1. Start Emacs. If Emacs can see the `.emacs` file you moved in the step above, it should ask you whether you would like to install a series of add-ons (Press "Y" on your keyboard for each). 
1. Close and then re-open Emacs to let the changes take full effect.
1. If all goes well, when you open Emacs, you should be greeted with some helpful text about org-mode.
