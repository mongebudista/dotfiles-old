require("todo-me-daddy").setup{
	    get_markdown_todo = false, -- The default for for this is false, what this does is as well as getting your to do comments this will also grab any to dos from a markdown file
	        your_name = "Jarco", -- There is an option you can call to get all the to do's which are asigend to you, in order for this to work you must enter in your name (the name that is used when to do's in code are asgined to you).
		    ignore_folders = { -- This allows you to tell todo-me-daddy to not search certin folders for to do's, there needs to be at least something in there or the plugin will glitch right now (I'm working on a fix for this), but you can add as many ignore folders as you want. There will be an option added to the telescope option to only ignore files on each call. This only works with one folder at the moment...
		            node_modules = "node_modules",
			        }
}
