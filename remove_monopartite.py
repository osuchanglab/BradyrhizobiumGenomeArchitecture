#!/local/cluster/bin/python
#biopython take three regions, invert middle, then put together
import sys
from Bio import SeqIO

strain=sys.argv[1]
#include 50 bp margin so as not to interrupt att site in rotated genome
largestart=int(sys.argv[2]) + 50
largeend=int(sys.argv[3]) - 50
infile="../" + strain + ".gbk"
outfile=strain + ".noSI.gbk"

record = SeqIO.read(infile, "genbank")
firstpart = record[1:largestart]
endpart = record[largeend:len(record.seq)]
newrecord = firstpart + endpart 
fw=open(outfile,'w')
SeqIO.write(newrecord,fw,"genbank")
