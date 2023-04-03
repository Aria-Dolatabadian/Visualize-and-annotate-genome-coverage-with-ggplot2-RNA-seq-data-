
library("rtracklayer")
library("ggcoverage")

#Load metadata:
meta.file <- read.csv("meta_info.csv")
sample.meta = meta.file
sample.meta

#Load track files:
track.folder = ("C:/Users/00090473/RWD")
track.df = LoadTrackFile(track.folder = track.folder, format = "bw",
                         meta.info = sample.meta)
head(track.df)


#Prepare mark region:
mark.region=data.frame(start=c(21678900,21732001,21737590),
                       end=c(21679900,21732400,21737650),
                       label=c("M1", "M2", "M3"))


mark.region

#Load GTF file:

gtf.file = system.file("extdata", "used_hg19.gtf", package = "ggcoverage")
gtf.gr = rtracklayer::import.gff(con = gtf.file, format = 'gtf')

#Basic coverage
basic.coverage = ggcoverage(data = track.df, color = "auto", 
                            mark.region = mark.region, range.position = "out")
basic.coverage

#You can also change Y axis style:

basic.coverage = ggcoverage(data = track.df, color = "auto", 
                            mark.region = mark.region, range.position = "in")
basic.coverage

#Add gene annotation
basic.coverage + 
  geom_gene(gtf.gr=gtf.gr)


#Add transcript annotation
basic.coverage + 
  geom_transcript(gtf.gr=gtf.gr,label.vjust = 1.5)

#Add ideogram

basic.coverage +
  geom_gene(gtf.gr=gtf.gr) +
  geom_ideogram(genome = "hg19",plot.space = 0)

basic.coverage +
  geom_transcript(gtf.gr=gtf.gr,label.vjust = 1.5) +
  geom_ideogram(genome = "hg19",plot.space = 0)



