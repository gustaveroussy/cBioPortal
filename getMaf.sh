vcf=$1
tmpVcf=${vcf//.vcf}".tmp"
maf=${vcf//.vcf}".maf"
rm -f $tmpVcf
rm -f $maf
rm -f $tmpVcf".vep.vcf"
#Change Ensembl to NCBI
sed 's/^chrM/^chrMT/' $vcf | sed 's/^chr//' > $tmpVcf

#Get samples from VCF file

line=$(grep -v "##" $tmpVcf | grep "#")
tumor=$(grep -v "##" $tmpVcf | grep "#" | cut -f 10)
normal=$(grep -v "##" $tmpVcf | grep "#" | cut -f 11)

echo "Doing it on $tumor and $normal"

if [[ ! -f $maf ]]; then
	perl vcf2maf-master/vcf2maf.pl --input-vcf $tmpVcf --output-maf $maf --tumor-id $tumor --normal-id $normal --vep-path ~/VEP --maf-center GustaveRoussy --species homo_sapiens_refseq --ref-fasta ~/.vep/homo_sapiens/84_GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz
	rm -f $tmpVcf
	rm -f $tmpVcf".vep.vcf"
fi
