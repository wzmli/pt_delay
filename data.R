library(tidyverse)
library(shellpipes)

dd <- read_csv("https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv")


clean_dat <- (dd
	%>% transmute(NULL
		, pt = prname
		, date
		, cases = numtotal_last7
		, totalcases
	)
)

rdsSave(clean_dat)

