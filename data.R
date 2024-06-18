library(tidyverse)
library(shellpipes)

dd <- read_csv("https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv")

clean_dat <- (dd
	%>% transmute(NULL
		, pt = prname
		, date
		, cases = as.numeric(numtotal_last7)
		, totalcases = as.numeric(totalcases)
	)
	%>% left_join(.,tsvRead())
)

print(head(clean_dat))

rdsSave(clean_dat)

