all:
	cd $(mktemp -u -t hammerspoon) && \
	git clone http://github.com/asmagill/hammerspoon_asm.undocumented hsasm && \
	$(MAKE) -C hsasm/spaces install
