## This is pt_delay

current: target
-include target.mk
Ignore = target.mk


# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

data.Rout: data.R pts.tsv
	$(pipeR)

tsplot.Rout: tsplot.R data.rds
	$(pipeR)

plot.Rout: plot.R data.rds
	$(pipeR)


######################################################################

### Makestuff

Sources += Makefile README.md $(wildcard *.R)

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
