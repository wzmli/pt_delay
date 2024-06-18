library(tidyverse);theme_set(theme_bw())
library(zoo)
library(scales)
library(shellpipes)
library(cowplot)

#date_start <- as.Date("2021-11-01") 
#date_end <- as.Date("2022-02-01") 

# datevec <- as.Date("2020-02-01"):as.Date("2024-01-01")

dat <- (rdsRead()
	%>% group_by(pt)
	%>% mutate(prop = cases/max(cases,na.rm=TRUE))
	%>% ungroup()
)

print(head(dat))

gg <- (ggplot(dat,aes(x=date,y=cases))
	+ geom_line()
	+ facet_wrap(~pt,scale="free",ncol=3)
	+ scale_y_continuous(labels=comma)
#	+ xlab("")
	+ theme(axis.title.x=element_blank()
		, axis.text.x=element_blank()
		, axis.ticks.x=element_blank()
	)
)

print(gg)


can <- gg %+% filter(dat, pt == "Canada")

print(plot_grid(can,can,nrow=2))


