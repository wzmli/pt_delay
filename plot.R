library(tidyverse);theme_set(theme_bw())
library(zoo)
library(shellpipes)

date_start <- as.Date("2021-11-01") 
date_end <- as.Date("2022-02-01") 

pp1 <- c("BC", "AB","SK","MB","ON","QC", "NS","NB","PEI", "NL","YT","NT","NU")
pp2 <- c("BC", "AB","SK","MB","ON","QC", "NS","NB","PEI", "NL","YT","NT","NU")

datevec <- as.Date("2020-02-01"):as.Date("2024-01-01")

dat <- (rdsRead()
	%>% group_by(ptcode)
	%>% mutate(pt = ptcode
		, prop = cases/max(cases,na.rm=TRUE)
	)
	%>% ungroup()
)

dat2 <- (dat %>% select(pt,date,prop))

fulldat <- (expand.grid(pt1=pp1,pt2=pp2,date=as.Date(datevec))
#	%>% filter(pt1 != pt2)
	%>% left_join(.,dat2,by=c("pt1"="pt","date"="date"))
	%>% rename(prop1=prop)
	%>% left_join(.,dat2,by=c("pt2"="pt","date"="date"))
	%>% rename(prop2=prop)
	%>% filter(complete.cases(.))
	%>% mutate(NULL
		, pt1 = factor(pt1,levels=pp1)
		, pt2 = factor(pt2,levels=pp1)
	)
	%>% filter(as.numeric(pt1)<=as.numeric(pt2))
#	%>% filter(pt1 %in% c("BC","AB","SK"))
)

print(fulldat)


gg <- (ggplot(fulldat,aes(x=date))
	+ facet_grid(pt1~pt2,scale="free")
	+ geom_line(aes(y=prop2),color="red")
	+ geom_line(aes(y=prop1),color="black")
	+ coord_cartesian(xlim=c(date_start,date_end))
	+ theme(strip.text.x = element_text(colour = 'red')
   	, axis.title.x=element_blank()
      , axis.text.x=element_blank()
      , axis.ticks.x=element_blank()
		, axis.title.y=element_blank()
      , axis.text.y=element_blank()
      , axis.ticks.y=element_blank()
   )
)

print(gg)
ggsave("pairsts.png",width=10)

gg2 <- (ggplot(fulldat,aes(x=date))
	+ geom_line(aes(y=prop1,color=pt1))
	+ coord_cartesian(xlim=c(date_start,date_end))
)

print(gg2)


