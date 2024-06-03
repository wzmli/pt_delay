## This is pt_delay

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

### Makestuff

Sources += Makefile README.md

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@
-include makestuff/os.mk
-include makestuff/pipeR.mk
-include makestuff/git.mk
-include makestuff/visual.mk
