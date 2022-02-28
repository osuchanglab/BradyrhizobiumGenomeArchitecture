#!/local/cluster/bin/python
#biopython take three regions, invert middle, then put together
import sys
from Bio import SeqIO

strain=sys.argv[1]
attstart=int(sys.argv[2])
attdir=sys.argv[3]
icetype=sys.argv[4]
icestrain=sys.argv[5]
infile="../" + strain + ".gbk"
outfile=strain + "__with__" + icetype + "__from__" + icestrain + ".gbk"

island = SeqIO.read("./symICE_references/" + icestrain + "." + icetype +".gbk", "genbank")


record = SeqIO.read(infile, "genbank")

firstpart = record[1:attstart]
endpart = record[attstart:len(record.seq)]
if attdir == "F":
	newrecord = firstpart + island + endpart
else:
	newrecord = firstpart + island.reverse_complement() + endpart



fw=open(outfile,'w')
SeqIO.write(newrecord,fw,"genbank")


#make wrong reverse orientation for simulation

outfilerev=strain + "__with__" + icetype + "__from__" + icestrain + "__wrongdir.gbk"
if attdir == "F":
	newrecordrev = firstpart + island.reverse_complement() + endpart
else:
	newrecordrev = firstpart + island + endpart

fwr=open(outfilerev,'w')
SeqIO.write(newrecordrev,fwr,"genbank")
