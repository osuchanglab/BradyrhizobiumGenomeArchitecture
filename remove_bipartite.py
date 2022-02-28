#!/local/cluster/bin/python
#biopython take three regions, invert middle, then put together
import sys
from Bio import SeqIO

strain=sys.argv[1]
#include 50 bp margin so as not to interrupt att sites in blasts of rotated genome
largestart=int(sys.argv[2]) + 50
largeend=int(sys.argv[3]) - 50
smallstart=int(sys.argv[4]) + 50
smallend=int(sys.argv[5]) - 50
infile="../" + strain + ".gbk"
outfile=strain + ".noSI.gbk"

record = SeqIO.read(infile, "genbank")
firstpart = record[1:smallstart]
middlepart = record[smallend:largestart]
endpart = record[largeend:len(record.seq)]
newrecord = firstpart + middlepart.reverse_complement()
newrecord = newrecord + endpart
fw=open(outfile,'w')
SeqIO.write(newrecord,fw,"genbank")
