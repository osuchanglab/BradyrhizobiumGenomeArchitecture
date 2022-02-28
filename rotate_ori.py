#!/local/cluster/bin/python
#biopython take three regions, invert middle, then put together
import sys
from Bio import SeqIO

strain=sys.argv[1]
parAstart=int(sys.argv[2])
parAend=int(sys.argv[3])
infile="../" + strain + ".gbk"
outfile=strain + ".rot.gbk"

record = SeqIO.read(infile, "genbank")

if parAstart < parAend:
	#do not rotate exactly on parA ORF so as not to split genbank entry
	newori=parAstart - 5
	firstpart = record[1:newori]
	endpart = record[newori:len(record.seq)]
	newrecord = endpart + firstpart 
else:
	newori=parAstart + 5
	endpart= record[1:newori]
	firstpart= record[newori:len(record.seq)]
	newrecord = firstpart + endpart
	newrecord = newrecord.reverse_complement()

fw=open(outfile,'w')
SeqIO.write(newrecord,fw,"genbank")
