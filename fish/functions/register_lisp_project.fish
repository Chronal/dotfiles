function register_lisp_project
    set arg $argv[1]
    if path is -d $argv[1]
	set target (path resolve $arg)
	set name (path basename $target)
	set link ~/.local/share/common-lisp/source/$name
	ln -s $target $link
    end
end
