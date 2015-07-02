Test detection and identification modes of ipdSummary.py using .xml dataset file as input.  Results should be identical to those using the equivalent .bam file.  This will also be tested for a split dataset (two non-overlapping .bam files in one .xml).

  $ . $TESTDIR/portability.sh

Load in data:

  $ DATA=/mnt/secondary-siv/testdata/kineticsTools
  $ INPUT=$DATA/Hpyl_1_5000.xml
  $ REFERENCE=/mnt/secondary-siv/references/Helicobacter_pylori_J99/sequence/Helicobacter_pylori_J99.fasta

Run basic ipdSummary.py:

  $ ipdSummary.py --gff tmp_xml1.gff --csv tmp_xml1.csv --numWorkers 12 --pvalue 0.001 --identify m6A,m4C --reference $REFERENCE --referenceWindows="gi|12057207|gb|AE001439.1|:0-5000" $INPUT

Look at output csv file:

  $ head -3 tmp_xml1.csv
  refName,tpl,strand,base,score,tMean,tErr,modelPrediction,ipdRatio,coverage
  "gi|12057207|gb|AE001439.1|",1,0,A,9,2.296,0.470,1.710,1.343,29
  "gi|12057207|gb|AE001439.1|",1,1,T,1,0.517,0.077,0.602,0.859,57

  $ linecount tmp_xml1.csv
  10001

Look at output gff file:

  $ linecount tmp_xml1.gff
  273
  $ cat tmp_xml1.gff | head -20
  ##gff-version 3
  ##source ipdSummary.py * (glob)
  ##source-commandline * (glob)
  ##sequence-region gi|12057207|gb|AE001439.1| 1 1643831
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t35\t35\t185\t-\t.\tcoverage=118;context=TTTAAGGGCGTTTTATGCCTAAATTTAAAAAATGATGCTGT;IPDRatio=5.66;identificationQv=193 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm4C\t60\t60\t51\t-\t.\tcoverage=112;context=AAAAAGCTCGCTCAAAAACCCTTGATTTAAGGGCGTTTTAT;IPDRatio=2.64;identificationQv=35 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t89\t89\t222\t+\t.\tcoverage=139;context=AGCGAGCTTTTTGCTCAAAGAATCCAAGATAGCGTTTAAAA;IPDRatio=5.58;identificationQv=187 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t91\t91\t219\t-\t.\tcoverage=143;context=ATTTTTAAACGCTATCTTGGATTCTTTGAGCAAAAAGCTCG;IPDRatio=6.36;identificationQv=217 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tmodified_base\t113\t113\t38\t+\t.\tcoverage=132;context=CAAGATAGCGTTTAAAAATTTAGGGGTGTTAGGCTCAGCGT;IPDRatio=1.65 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tmodified_base\t115\t115\t32\t+\t.\tcoverage=147;context=AGATAGCGTTTAAAAATTTAGGGGTGTTAGGCTCAGCGTAG;IPDRatio=1.85 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t122\t122\t219\t-\t.\tcoverage=158;context=GCAAACTCTACGCTGAGCCTAACACCCCTAAATTTTTAAAC;IPDRatio=6.47;identificationQv=201 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t232\t232\t225\t+\t.\tcoverage=173;context=AGCGTAAAATCGCCTTTTCCATGCTCCCTAATCGCTTGAAA;IPDRatio=5.95;identificationQv=213 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t233\t233\t278\t-\t.\tcoverage=183;context=ATTTCAAGCGATTAGGGAGCATGGAAAAGGCGATTTTACGC;IPDRatio=6.38;identificationQv=257 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t241\t241\t268\t+\t.\tcoverage=178;context=TCGCCTTTTCCATGCTCCCTAATCGCTTGAAATCCCAGTCT;IPDRatio=5.57;identificationQv=233 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t248\t248\t239\t-\t.\tcoverage=185;context=ATTTAAAAGACTGGGATTTCAAGCGATTAGGGAGCATGGAA;IPDRatio=6.23;identificationQv=221 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t274\t274\t231\t-\t.\tcoverage=190;context=TGAGATTGACGCTCTCATCGAACCGCATTTAAAAGACTGGG;IPDRatio=6.85;identificationQv=223 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t277\t277\t272\t+\t.\tcoverage=188;context=AGTCTTTTAAATGCGGTTCGATGAGAGCGTCAATCTCATTG;IPDRatio=7.50;identificationQv=257 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm4C\t312\t312\t38\t-\t.\tcoverage=204;context=GCTTTAAGCCTTTTTAATGGCGTGTTAGAAAAAATCAATGA;IPDRatio=1.89;identificationQv=4 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t373\t373\t389\t+\t.\tcoverage=219;context=TAATCTTTTTTTCTTCTAACATGCTGGAAGCGATTTTTTTA;IPDRatio=7.08;identificationQv=347 (esc)
  gi|12057207|gb|AE001439.1|\tkinModCall\tm6A\t374\t374\t338\t-\t.\tcoverage=221;context=TTAAAAAAATCGCTTCCAGCATGTTAGAAGAAAAAAAGATT;IPDRatio=6.03;identificationQv=325 (esc)

Now try with a split dataset:

  $ INPUT=$DATA/Hpyl_1_5000_split.xml
  $ ipdSummary.py --gff tmp_xml2.gff --csv tmp_xml2.csv --numWorkers 12 --pvalue 0.001 --identify m6A,m4C --reference $REFERENCE --referenceWindows="gi|12057207|gb|AE001439.1|:0-5000" $INPUT
  $ grep -v "source-commandline" tmp_xml1.gff > tmp_xml1b.gff
  $ grep -v "source-commandline" tmp_xml2.gff > tmp_xml2b.gff
  $ diff tmp_xml1b.gff tmp_xml2b.gff