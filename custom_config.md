# Custom configuration files
List of custom files that could be used with spf13 vim setup. 

* __.vimrc.before.local:__ Set bunch of global configuration. Look at
  __.vimrc.local__ for examples.
* __.vimrc.before.fork:__ I don't use it, as i don't understand the context.
* __.vimrc.bundles.local:__ To install custom bundles. I use it.
* __.vimrc.bundles.fork:__ Don't use it, frankly no idea.
* __.vimrc.bundles:__ This loads the core configurations and bundles
  and use configurations from the first files. However, i tweaked the
  sections that are redundant with the __.vimrc__ file. It was setting up
  __vundle__ twice which drove me completely clueless.
* __.vimrc.fork:__ Don't use it.
* __.vimrc.local:__ Custom vim configuration along with purging bundles that
  you don't need. This is useful and documented.
* __.gvimrc.local:__ For gvim user, however i don't use it.
