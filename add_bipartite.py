#!/local/cluster/bin/python
#biopython take three regions, invert middle, then put together
import sys
from Bio import SeqIO

strain=sys.argv[1]
attVstart=int(sys.argv[2])
attVdir=sys.argv[3]
attYstart=int(sys.argv[4])
attYdir=sys.argv[5]
icetype=sys.argv[6]
icestrain=sys.argv[7]
infile="../" + strain + ".gbk"
outfile=strain + "__with__" + icetype + "__from__" + icestrain + ".gbk"

smallisland = SeqIO.read("./symICE_references/" + icestrain + ".tRNA-Val_SI_small.gbk", "genbank")
largeisland = SeqIO.read("./symICE_references/" + icestrain + ".tRNA-Val_SI_large.gbk", "genbank")

record = SeqIO.read(infile, "genbank")
if attVdir == "F":
	largeisland = largeisland.reverse_complement()
if attYdir == "R":
	smallisland = smallisland.reverse_complement()


if attVstart < attYstart:
	firstpart = record[1:attVstart]
	middlepart = record[attVstart:attYstart]
	endpart = record[attYstart:len(record.seq)]
	newrecord = firstpart + smallisland + middlepart.reverse_complement() + largeisland + endpart
else:
	firstpart = record[1:attYstart]
	middlepart = record[attYstart:attVstart]
	endpart = record[attVstart:len(record.seq)]
	newrecord = firstpart + largeisland + middlepart.reverse_complement() + smallisland + endpart
	

fw=open(outfile,'w')
SeqIO.write(newrecord,fw,"genbank")
